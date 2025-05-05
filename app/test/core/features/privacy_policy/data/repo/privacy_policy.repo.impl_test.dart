import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/datasources/privacy_policy.remote.datasrc.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/model/privacy_policy.model.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/repo/privacy_policy.repo.impl.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/domain/entity/privacy_policy.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

class MockPrivacyPolicyRemoteDataSource extends Mock
    implements PrivacyPolicyRemoteDatasource {}

void main() {
  late PrivacyPolicyRemoteDatasource mockPrivacyPolicyRemoteDataSource;
  late PrivacyPolicyRepositoryImpl privacyPolicyRepo;
  late PrivacyPolicyModel tPrivacyPolicyModel;

  setUp(() {
    mockPrivacyPolicyRemoteDataSource = MockPrivacyPolicyRemoteDataSource();
    privacyPolicyRepo =
        PrivacyPolicyRepositoryImpl(mockPrivacyPolicyRemoteDataSource);

    tPrivacyPolicyModel = PrivacyPolicyModel(
      content: {
        'de': 'Datenschutzerklärung mit wichtigen Informationen...',
        'en': 'Privacy policy with important information...',
      },
    );
  });

  group('watchPrivacyPolicy', () {
    test(
      'should return stream of [Right(PrivacyPolicy)] entity when remote call is successful',
      () async {
        when(() => mockPrivacyPolicyRemoteDataSource.watchPrivacyPolicy())
            .thenAnswer((_) => Stream.value(tPrivacyPolicyModel));

        // Act
        final resultStream = privacyPolicyRepo.watchPrivacyPolicy();

        // Assert
        await expectLater(
          resultStream,
          emits(
            isA<Right<dynamic, PrivacyPolicy?>>()
                .having((right) => right.value, 'value', isA<PrivacyPolicy>()),
          ),
        );
      },
    );

    test(
      'should return [Right(null)] when remote returns null',
      () async {
        // Arrange
        when(() => mockPrivacyPolicyRemoteDataSource.watchPrivacyPolicy())
            .thenAnswer((_) => Stream.value(null));

        // Act
        final resultStream = privacyPolicyRepo.watchPrivacyPolicy();

        // Assert
        await expectLater(
          resultStream,
          emits(
            isA<Right<dynamic, PrivacyPolicy?>>().having(
              (right) => right.value,
              'value',
              isNull,
            ),
          ),
        );
      },
    );

    test(
      'should return [Left(ServerFailure)] when remote throws ServerException',
      () async {
        final tException = ServerException(
          message: 'Server error',
          statusCode: '500',
        );

        when(() => mockPrivacyPolicyRemoteDataSource.watchPrivacyPolicy())
            .thenThrow(tException);

        final resultStream = privacyPolicyRepo.watchPrivacyPolicy();

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
