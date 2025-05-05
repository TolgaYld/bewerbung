import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/contact.model.dart';
import 'package:pleasehiretolga/core/interfaces/id_holder.dart';
import 'package:pleasehiretolga/core/utils/extensions/color.extension.dart';
import 'package:pleasehiretolga/features/cover_letter/data/models/cover_letter.model.dart';

class CompanyModel implements IdHolder {
  const CompanyModel({
    required this.id,
    required this.name,
    this.logoUrl,
    this.primaryColor,
    this.secondaryColor,
    this.accentColor,
    this.imageBackgroundColor,
    this.coverLetter,
    this.contact,
    this.inviteDate,
    this.inviteDurationInMinutes,
    this.decisionStatus,
    this.decisionMessage,
    this.employeeAcceptedInvite,
    this.messageFromEmployee,
  });
  factory CompanyModel.fromMap(Map<String, dynamic> map) => CompanyModel(
        id: map['id'] as String,
        name: map['name'] as String,
        logoUrl: map['logoUrl'] as String?,
        primaryColor: map['primaryColor'] as String?,
        secondaryColor: map['secondaryColor'] as String?,
        accentColor: map['accentColor'] as String?,
        imageBackgroundColor: map['imageBackgroundColor'] as String?,
        coverLetter: map['coverLetter'] != null
            ? CoverLetterModel.fromMap(
                map['coverLetter'] as Map<String, dynamic>)
            : null,
        contact: map['contact'] != null
            ? ContactModel.fromMap(map['contact'] as Map<String, dynamic>)
            : null,
        inviteDate: map['inviteDate'] != null
            ? (map['inviteDate'] as Timestamp).toDate()
            : null,
        inviteDurationInMinutes: map['inviteDurationInMinutes'] != null
            ? (map['inviteDurationInMinutes'] as int)
            : null,
        decisionStatus: map['decisionStatus'] as String?,
        decisionMessage: map['decisionMessage'] as String?,
        employeeAcceptedInvite: map['employeeAcceptedInvite'] as bool?,
        messageFromEmployee: map['messageFromEmployee'] as String?,
      );

  factory CompanyModel.empty() => const CompanyModel(
        id: '123',
        name: "TestCompany",
        logoUrl: null,
        primaryColor: null,
        secondaryColor: null,
        accentColor: null,
        imageBackgroundColor: null,
        coverLetter: null,
        contact: null,
        decisionStatus: null,
        decisionMessage: null,
        employeeAcceptedInvite: null,
        messageFromEmployee: null,
      );

  @override
  final String id;
  final String name;
  final String? logoUrl;
  final String? primaryColor;
  final String? secondaryColor;
  final String? accentColor;
  final String? imageBackgroundColor;
  final CoverLetterModel? coverLetter;
  final ContactModel? contact;
  final String? decisionStatus;
  final String? decisionMessage;
  final bool? employeeAcceptedInvite;
  final String? messageFromEmployee;
  final DateTime? inviteDate;
  final int? inviteDurationInMinutes;

  Company toEntity() => Company(
        id: id,
        name: name,
        logoUrl: logoUrl,
        contact: contact?.toEntity(),
        primaryColor: primaryColor?.toColor(),
        secondaryColor: secondaryColor?.toColor(),
        accentColor: accentColor?.toColor(),
        imageBackgroundColor: imageBackgroundColor?.toColor(),
        coverLetter: coverLetter?.toEntity(),
        inviteDate: inviteDate,
        inviteDuration: switch (inviteDurationInMinutes) {
          final duration? => Duration(minutes: duration),
          null => null,
        },
        decisionStatus: DecisionStatus.values.firstWhere(
          (e) => e.name == decisionStatus,
          orElse: () => DecisionStatus.pending,
        ),
        decisionMessage: decisionMessage,
        employeeAcceptedInvite: employeeAcceptedInvite,
        messageFromEmployee: messageFromEmployee,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'logoUrl': logoUrl,
        'primaryColor': primaryColor,
        'secondaryColor': secondaryColor,
        'accentColor': accentColor,
        'imageBackgroundColor': imageBackgroundColor,
        'contact': contact?.toMap(),
        'coverLetter': coverLetter?.toMap(),
        'inviteDate': inviteDate,
        'inviteDurationInMinutes': inviteDurationInMinutes,
        'decisionStatus': decisionStatus,
        'decisionMessage': decisionMessage,
        'employeeAcceptedInvite': employeeAcceptedInvite,
        'messageFromEmployee': messageFromEmployee,
      };
}
