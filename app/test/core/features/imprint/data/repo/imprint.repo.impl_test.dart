import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/imprint/data/datasources/imprint.remote.datasrc.dart';
import 'package:pleasehiretolga/core/features/imprint/data/model/imprint.model.dart';
import 'package:pleasehiretolga/core/features/imprint/data/repo/imprint.repo.impl.dart';
import 'package:pleasehiretolga/core/features/imprint/domain/entity/imprint.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

class MockImprintRemoteDataSource extends Mock
    implements ImprintRemoteDatasource {}

void main() {
  late ImprintRemoteDatasource mockImprintRemoteDataSource;
  late ImprintRepoImpl imprintRepo;
  late ImprintModel tImprintModel;

  setUp(() {
    mockImprintRemoteDataSource = MockImprintRemoteDataSource();
    imprintRepo = ImprintRepoImpl(mockImprintRemoteDataSource);

    tImprintModel = ImprintModel(
      translations: {
        'de': {
          'contact': 'Telefon: +49 176 22658759 E-Mail: tolga@ty-software.dev',
          'imprint': 'Tolga Yıldırım Kolumbusstraße 36 81543 München',
        },
        'en': {
          'contact': 'Phone: +49 176 22658759 Email: tolga@ty-software.dev',
          'imprint': 'Tolga Yıldırım Kolumbusstraße 36 81543 Munich',
        },
      },
    );
  });

  group('getImprint', () {
    test(
      'should return stream of [Right(Imprint)] entity when remote call is successful',
      () async {
        when(() => mockImprintRemoteDataSource.watchImprint())
            .thenAnswer((_) => Stream.value(tImprintModel));

        final resultStream = imprintRepo.watchImprint();

        await expectLater(
          resultStream,
          emits(
            isA<Right<dynamic, Imprint?>>()
                .having((right) => right.value, 'value', isA<Imprint>()),
          ),
        );
      },
    );

    test(
      'should map [ImprintModel] to Imprint entity correctly',
      () async {
        when(() => mockImprintRemoteDataSource.watchImprint())
            .thenAnswer((_) => Stream.value(tImprintModel));

        final resultStream = imprintRepo.watchImprint();
        final result = await resultStream.first;

        expect(result, isA<Right<Failure, Imprint?>>());
        final imprint = (result as Right<Failure, Imprint?>).value;

        expect(imprint?.translations, equals(tImprintModel.translations));
        expect(
          imprint?.translations['de']?['contact'],
          equals('Telefon: +49 176 22658759 E-Mail: tolga@ty-software.dev'),
        );
        expect(
          imprint?.translations['en']?['imprint'],
          equals('Tolga Yıldırım Kolumbusstraße 36 81543 Munich'),
        );
      },
    );

    test(
      'should return [Right(null)] when remote returns null',
      () async {
        when(() => mockImprintRemoteDataSource.watchImprint())
            .thenAnswer((_) => Stream.value(null));

        final resultStream = imprintRepo.watchImprint();

        await expectLater(
          resultStream,
          emits(
            isA<Right<dynamic, Imprint?>>().having(
              (right) => right.value,
              'value',
              isNull,
            ),
          ),
        );
      },
    );

    test(
      'should return [Left(Failure)] when remote throws ServerException',
      () async {
        final tException = ServerException(
          message: 'Server error',
          statusCode: '500',
        );

        when(() => mockImprintRemoteDataSource.watchImprint())
            .thenThrow(tException);

        final resultStream = imprintRepo.watchImprint();

        await expectLater(
          resultStream,
          emits(
            isA<Left<Failure, dynamic>>().having(
              (left) => left.failure.message,
              'message',
              'Server error',
            ),
          ),
        );
      },
    );
  });
}
