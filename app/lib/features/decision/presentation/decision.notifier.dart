import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/utils/either.dart';
import 'package:pleasehiretolga/features/decision/data/repo/decision.repo.impl.dart';
import 'package:pleasehiretolga/features/decision/presentation/state/decision.state.dart';

final decisionStateProvider =
    StateNotifierProvider<DecisionNotifier, DecisionState>((ref) {
  return DecisionNotifier(
    const DecisionState(
      isLoading: false,
      errorMessage: null,
    ),
    ref: ref,
  );
});

class DecisionNotifier extends StateNotifier<DecisionState> {
  DecisionNotifier(
    super.state, {
    required this.ref,
  });

  final Ref ref;

  Future<void> setDecisionOptions({
    required String employeeId,
    DecisionStatus? status,
    String? decisionMessage,
    DateTime? inviteDate,
    Duration? inviteDuration,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final repo = ref.read(decisionRepoProvider);

      final result = await repo.updateDecision(
        employeeId: employeeId,
        status: status,
        decisionMessage: decisionMessage,
        inviteDate: inviteDate,
        inviteDuration: inviteDuration,
      );

      if (result case Right()) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: null,
        );
      } else if (result case Left(:final failure)) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> revertDecision(String employeeId) async {
    state = state.copyWith(isLoading: true);

    try {
      final repo = ref.read(decisionRepoProvider);

      final result = await repo.revertDecision(employeeId);

      if (result case Right()) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: null,
        );
      } else if (result case Left(:final failure)) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
}
