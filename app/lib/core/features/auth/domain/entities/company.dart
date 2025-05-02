import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/contact.dart';
import 'package:pleasehiretolga/features/cover_letter/domain/entities/cover_letter.dart';

part 'company.mapper.dart';

@MappableClass()
class Company with CompanyMappable {
  const Company({
    required this.id,
    required this.name,
    this.logoUrl,
    this.primaryColor,
    this.secondaryColor,
    this.accentColor,
    this.contact,
    this.coverLetter,
    this.inviteDate,
    this.inviteDuration,
    DecisionStatus? decisionStatus,
    this.decisionMessage,
    this.employeeAcceptedInvite,
    this.messageFromEmployee,
  }) : decisionStatus = decisionStatus ?? DecisionStatus.pending;

  final String id;
  final String name;
  final String? logoUrl;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? accentColor;
  final Contact? contact;
  final CoverLetter? coverLetter;
  final DecisionStatus decisionStatus;
  final String? decisionMessage;
  final bool? employeeAcceptedInvite;
  final String? messageFromEmployee;
  final DateTime? inviteDate;
  final Duration? inviteDuration;
}
