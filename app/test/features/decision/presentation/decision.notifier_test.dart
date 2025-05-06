import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/utils/either.dart';
import 'package:pleasehiretolga/features/decision/data/repo/decision.repo.impl.dart';
import 'package:pleasehiretolga/features/decision/domain/repo/decision.repo.dart';
import 'package:pleasehiretolga/features/decision/presentation/decision.notifier.dart';
import 'package:pleasehiretolga/features/decision/presentation/state/decision.state.dart';

class MockDecisionRepo extends Mock implements DecisionRepo {}

void main() {
  late MockDecisionRepo mockRepo;
  late ProviderContainer container;
  late StateNotifierProvider<DecisionNotifier, DecisionState> decisionProvider;

  setUp(() {
    mockRepo = MockDecisionRepo();

    container = ProviderContainer(
      overrides: [
        decisionRepoProvider.overrideWithValue(mockRepo),
      ],
    );

    decisionProvider =
        StateNotifierProvider<DecisionNotifier, DecisionState>((ref) {
      return DecisionNotifier(
        const DecisionState(isLoading: false, errorMessage: null),
        ref: ref,
      );
    });

    addTearDown(() => container.dispose());
  });

  const tEmployeeId = 'uuid asdfasdfdsa';
  final tInviteDate = DateTime.now();
  const tInviteDuration = Duration(minutes: 60);
  const tDecisionMessage = 'tolga nimm die einladung an, die app ist geil';

  group('setDecisionOptions', () {
    test(
        'should update state to loading and then success when repo returns Right',
        () async {
      when(
        () => mockRepo.updateDecision(
          employeeId: any(named: 'employeeId'),
          status: any(named: 'status'),
          decisionMessage: any(named: 'decisionMessage'),
          inviteDate: any(named: 'inviteDate'),
          inviteDuration: any(named: 'inviteDuration'),
        ),
      ).thenAnswer((_) async => const Right(null));

      await container.read(decisionProvider.notifier).setDecisionOptions(
            employeeId: tEmployeeId,
            status: DecisionStatus.invited,
            decisionMessage: tDecisionMessage,
            inviteDate: tInviteDate,
            inviteDuration: tInviteDuration,
          );

      final state = container.read(decisionProvider);
      expect(state.isLoading, false);
      expect(state.errorMessage, null);

      verify(
        () => mockRepo.updateDecision(
          employeeId: tEmployeeId,
          status: DecisionStatus.invited,
          decisionMessage: tDecisionMessage,
          inviteDate: tInviteDate,
          inviteDuration: tInviteDuration,
        ),
      ).called(1);
    });

    test('should update state to error when repo returns Left', () async {
      when(
        () => mockRepo.updateDecision(
          employeeId: any(named: 'employeeId'),
          status: any(named: 'status'),
          decisionMessage: any(named: 'decisionMessage'),
          inviteDate: any(named: 'inviteDate'),
          inviteDuration: any(named: 'inviteDuration'),
        ),
      ).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message: 'oh neinnnn',
          ),
        ),
      );

      await container.read(decisionProvider.notifier).setDecisionOptions(
            employeeId: tEmployeeId,
            status: DecisionStatus.rejected,
          );

      final state = container.read(decisionProvider);
      expect(state.isLoading, false);
      expect(state.errorMessage, 'oh neinnnn');

      verify(
        () => mockRepo.updateDecision(
          employeeId: tEmployeeId,
          status: DecisionStatus.rejected,
          decisionMessage: null,
          inviteDate: null,
          inviteDuration: null,
        ),
      ).called(1);
    });

    test('should update state to error when an exception is thrown', () async {
      when(
        () => mockRepo.updateDecision(
          employeeId: any(named: 'employeeId'),
          status: any(named: 'status'),
          decisionMessage: any(named: 'decisionMessage'),
          inviteDate: any(named: 'inviteDate'),
          inviteDuration: any(named: 'inviteDuration'),
        ),
      ).thenThrow(Exception('feeehler'));

      await container.read(decisionProvider.notifier).setDecisionOptions(
            employeeId: tEmployeeId,
            status: DecisionStatus.invited,
          );

      final state = container.read(decisionProvider);
      expect(state.isLoading, false);
      expect(state.errorMessage, 'Exception: feeehler');

      verify(
        () => mockRepo.updateDecision(
          employeeId: tEmployeeId,
          status: DecisionStatus.invited,
          decisionMessage: null,
          inviteDate: null,
          inviteDuration: null,
        ),
      ).called(1);
    });
  });

  group('revertDecision', () {
    test('should update state to success when repo returns Right', () async {
      when(() => mockRepo.revertDecision(any()))
          .thenAnswer((_) async => const Right(null));

      await container
          .read(decisionProvider.notifier)
          .revertDecision(tEmployeeId);

      final state = container.read(decisionProvider);
      expect(state.isLoading, false);
      expect(state.errorMessage, null);

      verify(() => mockRepo.revertDecision(tEmployeeId)).called(1);
    });

    test('should update state to error when repo returns Left', () async {
      when(() => mockRepo.revertDecision(any())).thenAnswer(
        (_) async => Left(
          ServerFailure(
            message:
                'entscheidung konnte nicht rückgängig gemacht werden, weils die richtige entscheidung war. spass fehler aufgetreten',
          ),
        ),
      );

      await container
          .read(decisionProvider.notifier)
          .revertDecision(tEmployeeId);

      final state = container.read(decisionProvider);
      expect(state.isLoading, false);
      expect(
        state.errorMessage,
        'entscheidung konnte nicht rückgängig gemacht werden, weils die richtige entscheidung war. spass fehler aufgetreten',
      );

      verify(() => mockRepo.revertDecision(tEmployeeId)).called(1);
    });

    test('should update state to error when an exception is thrown', () async {
      when(() => mockRepo.revertDecision(any()))
          .thenThrow(Exception('Kritischer Fehler'));

      await container
          .read(decisionProvider.notifier)
          .revertDecision(tEmployeeId);

      final state = container.read(decisionProvider);
      expect(state.isLoading, false);
      expect(state.errorMessage, 'Exception: Kritischer Fehler');

      verify(() => mockRepo.revertDecision(tEmployeeId)).called(1);
    });
  });

  test('should track loading state during operations', () async {
    when(
      () => mockRepo.updateDecision(
        employeeId: any(named: 'employeeId'),
        status: any(named: 'status'),
        decisionMessage: any(named: 'decisionMessage'),
        inviteDate: any(named: 'inviteDate'),
        inviteDuration: any(named: 'inviteDuration'),
      ),
    ).thenAnswer((_) async {
      return const Right(null);
    });

    final result = container.read(decisionProvider.notifier).setDecisionOptions(
          employeeId: tEmployeeId,
          status: DecisionStatus.invited,
        );

    expect(container.read(decisionProvider).isLoading, true);

    await result;
    expect(container.read(decisionProvider).isLoading, false);
  });
}
