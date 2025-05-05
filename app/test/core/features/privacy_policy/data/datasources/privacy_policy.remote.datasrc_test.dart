import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/datasources/privacy_policy.remote.datasrc.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/model/privacy_policy.model.dart';

void main() {
  late FakeFirebaseFirestore firestoreClient;
  late PrivacyPolicyRemoteDatasource privacyPolicyRemoteDatasrc;
  late Map<String, dynamic> testPrivacyPolicyData;

  setUp(() {
    firestoreClient = FakeFirebaseFirestore();
    privacyPolicyRemoteDatasrc =
        PrivacyPolicyRemoteDatasourceImpl(firestoreClient);

    testPrivacyPolicyData = {
      'de': 'Datenschutzerklärung mit wichtigen Informationen...',
      'en': 'Privacy policy with important information...',
      'es': 'Política de privacidad con información importante...',
    };
  });

  group('getPrivacyPolicy', () {
    const testDocId = 'test_privacy_policy_id';

    test(
      'should return a Stream with a [PrivacyPolicyModel] when a document exists',
      () async {
        await firestoreClient
            .collection(FirestoreKeys.privacyPolicy)
            .doc(testDocId)
            .set(testPrivacyPolicyData);

        await expectLater(
          privacyPolicyRemoteDatasrc.watchPrivacyPolicy(),
          emits(isA<PrivacyPolicyModel>()),
        );
      },
    );

    test(
      'should throw a [ServerException] when no privacy policy document is found',
      () async {
        expect(
          () => privacyPolicyRemoteDatasrc.watchPrivacyPolicy().first,
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'No privacy found',
            ),
          ),
        );
      },
    );

    test(
      'should return the correct [PrivacyPolicyModel] with all language contents',
      () async {
        await firestoreClient
            .collection(FirestoreKeys.privacyPolicy)
            .doc(testDocId)
            .set(testPrivacyPolicyData);

        final result =
            await privacyPolicyRemoteDatasrc.watchPrivacyPolicy().first;

        expect(result?.content.length, equals(3));
        expect(
          result?.content['de'],
          equals('Datenschutzerklärung mit wichtigen Informationen...'),
        );
        expect(
          result?.content['en'],
          equals('Privacy policy with important information...'),
        );
        expect(
          result?.content['es'],
          equals('Política de privacidad con información importante...'),
        );
      },
    );
  });
}
