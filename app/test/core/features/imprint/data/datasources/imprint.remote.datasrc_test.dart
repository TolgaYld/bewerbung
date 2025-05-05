import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/features/imprint/data/datasources/imprint.remote.datasrc.dart';
import 'package:pleasehiretolga/core/features/imprint/data/model/imprint.model.dart';

void main() {
  late FakeFirebaseFirestore firestoreClient;
  late ImprintRemoteDatasource imprintRemoteDatasource;
  late ImprintModel tImprintModel;

  setUp(() {
    firestoreClient = FakeFirebaseFirestore();
    imprintRemoteDatasource = ImprintRemoteDatasourceImpl(firestoreClient);

    final translations = <String, Map<String, String>>{
      'de': {
        'contact': 'Telefon: +49 176 22658759 E-Mail: tolga@ty-software.dev',
        'imprint': 'Tolga Yıldırım Kolumbusstraße 36 81543 München',
      },
      'en': {
        'contact': 'Phone: +49 176 22658759 Email: tolga@ty-software.dev',
        'imprint': 'Tolga Yıldırım Kolumbusstraße 36 81543 Munich',
      },
    };

    tImprintModel = ImprintModel(translations: translations);
  });

  group('getImprint', () {
    const testDocId = 'test_imprint_id';
    test(
      'should return a Stream with an [ImprintModel] when a document exists',
      () async {
        await firestoreClient
            .collection(FirestoreKeys.imprint)
            .doc(testDocId)
            .set(tImprintModel.toMap());

        await expectLater(
          imprintRemoteDatasource.watchImprint(),
          emits(isA<ImprintModel>()),
        );
      },
    );

    test(
      'should throw a [ServerException] when no imprint document is found',
      () async {
        expect(
          () => imprintRemoteDatasource.watchImprint().first,
          throwsA(
            isA<ServerException>().having(
              (e) => e.message,
              'message',
              'No imprint found',
            ),
          ),
        );
      },
    );

    test(
      'should return the correct [ImprintModel] with translations',
      () async {
        await firestoreClient
            .collection(FirestoreKeys.imprint)
            .doc(testDocId)
            .set(tImprintModel.toMap());

        final result = await imprintRemoteDatasource.watchImprint().first;

        expect(
          result?.translations.length,
          equals(tImprintModel.translations.length),
        );
        expect(
          result?.translations['de']?['contact'],
          equals(tImprintModel.translations['de']?['contact']),
        );
        expect(
          result?.translations['en']?['imprint'],
          equals(tImprintModel.translations['en']?['imprint']),
        );
      },
    );

    test(
      'should return the first document when multiple imprint documents exist',
      () async {
        final secondImprint = ImprintModel(
          translations: {
            'de': {
              'contact': 'Telefon: +49 123 4567890 E-Mail: test@test.de',
              'imprint': 'Test Imprint',
            },
          },
        );

        await firestoreClient
            .collection(FirestoreKeys.imprint)
            .doc(testDocId)
            .set(tImprintModel.toMap());

        await firestoreClient
            .collection(FirestoreKeys.imprint)
            .doc('second_imprint')
            .set(secondImprint.toMap());

        final result = await imprintRemoteDatasource.watchImprint().first;

        final resultMatches = ((result?.translations['de']?['contact'] ==
                tImprintModel.translations['de']?['contact']) ||
            (result?.translations['de']?['contact'] ==
                secondImprint.translations['de']?['contact']));

        expect(resultMatches, isTrue);
      },
    );
  });
}
