import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

abstract interface class DecisionRepo {
  ResultFuture<void> updateDecision({
    required String employeeId,
    DecisionStatus? status,
    String? decisionMessage,
    DateTime? inviteDate,
    Duration? inviteDuration,
  });

  ResultFuture<void> revertDecision(String employeeId);
}
