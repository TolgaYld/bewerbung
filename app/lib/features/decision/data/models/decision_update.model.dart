import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';

class DecisionUpdateModel {
  const DecisionUpdateModel({
    required this.id,
    this.decisionStatus,
    this.decisionMessage,
    this.employeeAcceptedInvite,
    this.messageFromEmployee,
    this.inviteDate,
    this.inviteDurationInMinutes,
  });

  final String id;
  final DecisionStatus? decisionStatus;
  final String? decisionMessage;
  final bool? employeeAcceptedInvite;
  final String? messageFromEmployee;
  final DateTime? inviteDate;
  final int? inviteDurationInMinutes;

  Map<String, dynamic> toFirestoreUpdate() {
    final Map<String, dynamic> updateData = {};

    if (decisionStatus != null) {
      updateData['decisionStatus'] = switch (decisionStatus) {
        final status? => status.name,
        null => DecisionStatus.pending.name,
      };
    }

    if (decisionMessage != null) {
      updateData['decisionMessage'] = decisionMessage;
    }

    if (employeeAcceptedInvite != null) {
      updateData['employeeAcceptedInvite'] = employeeAcceptedInvite;
    }

    if (messageFromEmployee != null) {
      updateData['messageFromEmployee'] = messageFromEmployee;
    }

    if (inviteDate != null) {
      updateData['inviteDate'] = switch (inviteDate) {
        final date? => Timestamp.fromDate(date),
        null => null,
      };
    }

    if (inviteDurationInMinutes != null) {
      updateData['inviteDurationInMinutes'] = inviteDurationInMinutes;
    }

    return updateData;
  }

  @override
  String toString() {
    return 'DecisionUpdateModel(id: $id, decisionStatus: $decisionStatus, decisionMessage: $decisionMessage, employeeAcceptedInvite: $employeeAcceptedInvite, messageFromEmployee: $messageFromEmployee, inviteDate: $inviteDate, inviteDurationInMinutes: $inviteDurationInMinutes)';
  }
}
