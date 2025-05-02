import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/utils/either.dart';
import 'package:pleasehiretolga/features/decision/data/datasources/decision.remote.datasource.dart';
import 'package:pleasehiretolga/features/decision/data/models/decision_update.model.dart';
import 'package:pleasehiretolga/features/decision/data/repo/decision.repo.impl.dart';
import 'package:pleasehiretolga/features/decision/domain/repo/decision.repo.dart';

class MockDecisionRemoteDataSource extends Mock
    implements DecisionRemoteDataSource {}

class FakeDecisionUpdateModel extends Fake implements DecisionUpdateModel {}

void main() {
  late DecisionRepo repo;
  late MockDecisionRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(FakeDecisionUpdateModel());
  });

  setUp(() {
    mockRemoteDataSource = MockDecisionRemoteDataSource();
    repo = DecisionRepoImpl(mockRemoteDataSource);
  });

  const tEmployeeId = 'uuid 1234';
  final tInviteDate = DateTime.now();
  const tInviteDuration = Duration(minutes: 90);

  group('updateDecision', () {
    test(
      'should return [Right(void)] when update decision is successful',
      () async {
        when(() => mockRemoteDataSource.updateDecision(any()))
            .thenAnswer((_) async => Future.value());

        final result = await repo.updateDecision(
          employeeId: tEmployeeId,
          status: DecisionStatus.invited,
          decisionMessage: 'du bist eingeladen',
          inviteDate: tInviteDate,
          inviteDuration: tInviteDuration,
        );

        expect(result, equals(const Right<Failure, void>(null)));
        verify(
          () => mockRemoteDataSource.updateDecision(
            any(
              that: predicate<DecisionUpdateModel>(
                (model) =>
                    model.id == tEmployeeId &&
                    model.decisionStatus == DecisionStatus.invited &&
                    model.decisionMessage == 'du bist eingeladen' &&
                    model.inviteDate == tInviteDate &&
                    model.inviteDurationInMinutes == 90,
              ),
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return [Left(ServerFailure)] when remote data source throws ServerException',
      () async {
        when(() => mockRemoteDataSource.updateDecision(any())).thenThrow(
          ServerException(
            message: 'Company not found',
            statusCode: '404',
          ),
        );

        final result = await repo.updateDecision(
          employeeId: tEmployeeId,
          status: DecisionStatus.invited,
        );

        expect(
          result,
          equals(
            Left<Failure, void>(
              ServerFailure(
                message: 'Company not found',
                statusCode: 404,
              ),
            ),
          ),
        );
        verify(
          () => mockRemoteDataSource.updateDecision(
            any(
              that: predicate<DecisionUpdateModel>(
                (model) =>
                    model.id == tEmployeeId &&
                    model.decisionStatus == DecisionStatus.invited,
              ),
            ),
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });

  group('revertDecision', () {
    test(
      'should return Right(void) when revert decision is successful',
      () async {
        when(() => mockRemoteDataSource.revertDecision(any()))
            .thenAnswer((_) async => Future.value());

        final result = await repo.revertDecision(tEmployeeId);

        expect(result, equals(const Right<Failure, void>(null)));
        verify(() => mockRemoteDataSource.revertDecision(tEmployeeId))
            .called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );

    test(
      'should return [Left(ServerFailure)] when remote data source throws ServerException',
      () async {
        when(() => mockRemoteDataSource.revertDecision(any())).thenThrow(
          ServerException(
            message: 'Company not found',
            statusCode: '404',
          ),
        );

        final result = await repo.revertDecision(tEmployeeId);

        expect(
          result,
          equals(
            Left<Failure, void>(
              ServerFailure(
                message: 'Company not found',
                statusCode: 404,
              ),
            ),
          ),
        );
        verify(() => mockRemoteDataSource.revertDecision(tEmployeeId))
            .called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      },
    );
  });
}
