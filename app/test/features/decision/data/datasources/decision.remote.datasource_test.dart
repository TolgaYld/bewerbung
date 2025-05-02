import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/features/decision/data/datasources/decision.remote.datasource.dart';
import 'package:pleasehiretolga/features/decision/data/models/decision_update.model.dart';

void main() {
  late DecisionRemoteDataSource dataSource;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    dataSource = DecisionRemoteDataSourceImpl(fakeFirestore);
  });

  group('updateDecision', () {
    final tDecisionUpdateModel = DecisionUpdateModel(
      id: 'uuid 1234',
      decisionStatus: DecisionStatus.invited,
      decisionMessage: 'du bist eingelaadeeennn',
      inviteDate: DateTime.now(),
      inviteDurationInMinutes: 60,
    );

    test('should throw [ServerException] when company does not exist',
        () async {
      expect(
        () => dataSource.updateDecision(tDecisionUpdateModel),
        throwsA(
          isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', '404'),
        ),
      );
    });

    test('should update decision when [Company] exists', () async {
      await fakeFirestore
          .collection(FirestoreKeys.companies)
          .doc(tDecisionUpdateModel.id)
          .set({
        'name': 'blbla company',
        'decisionStatus': DecisionStatus.pending.name,
      });

      await dataSource.updateDecision(tDecisionUpdateModel);

      final updatedDoc = await fakeFirestore
          .collection(FirestoreKeys.companies)
          .doc(tDecisionUpdateModel.id)
          .get();

      if (updatedDoc.data() case final data?) {
        expect(data['decisionStatus'], equals(DecisionStatus.invited.name));
        expect(data['decisionMessage'], equals('du bist eingelaadeeennn'));
      }
    });

    test('should throw [ServerException] on [FirebaseException]', () async {
      final docId = 'uuid v4';

      await fakeFirestore.collection(FirestoreKeys.companies).doc(docId).set({
        'name': 'Test Company',
      });

      await fakeFirestore
          .collection(FirestoreKeys.companies)
          .doc(docId)
          .delete();

      expect(
        () => dataSource.updateDecision(tDecisionUpdateModel),
        throwsA(
          isA<ServerException>().having(
            (e) => e.statusCode,
            'statusCode',
            '404',
          ),
        ),
      );
    });
  });

  group('revertDecision', () {
    final companyId = 'uuid 1234';

    test('should throw ServerException when [Company] does not exist',
        () async {
      expect(
        () => dataSource.revertDecision(companyId),
        throwsA(
          isA<ServerException>()
              .having((e) => e.statusCode, 'statusCode', '404'),
        ),
      );
    });

    test('should revert decision when [Company] exists', () async {
      await fakeFirestore
          .collection(FirestoreKeys.companies)
          .doc(companyId)
          .set({
        'name': 'Test Company',
        'decisionStatus': DecisionStatus.invited.name,
        'decisionMessage': 'Some message',
        'inviteDate': Timestamp.now(),
        'inviteDurationInMinutes': 120,
      });

      await dataSource.revertDecision(companyId);

      final updatedDoc = await fakeFirestore
          .collection(FirestoreKeys.companies)
          .doc(companyId)
          .get();

      if (updatedDoc.data() case final data?) {
        expect(
          data['decisionStatus'],
          equals(DecisionStatus.pending.name),
        );
        expect(data['decisionMessage'], isNull);
        expect(data['inviteDate'], isNull);
        expect(data['inviteDurationInMinutes'], isNull);
      }
    });
  });
}
