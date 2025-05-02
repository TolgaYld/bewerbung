// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'company.dart';

class CompanyMapper extends ClassMapperBase<Company> {
  CompanyMapper._();

  static CompanyMapper? _instance;
  static CompanyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompanyMapper._());
      ContactMapper.ensureInitialized();
      CoverLetterMapper.ensureInitialized();
      DecisionStatusMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Company';

  static String _$id(Company v) => v.id;
  static const Field<Company, String> _f$id = Field('id', _$id);
  static String _$name(Company v) => v.name;
  static const Field<Company, String> _f$name = Field('name', _$name);
  static String? _$logoUrl(Company v) => v.logoUrl;
  static const Field<Company, String> _f$logoUrl =
      Field('logoUrl', _$logoUrl, opt: true);
  static Color? _$primaryColor(Company v) => v.primaryColor;
  static const Field<Company, Color> _f$primaryColor =
      Field('primaryColor', _$primaryColor, opt: true);
  static Color? _$secondaryColor(Company v) => v.secondaryColor;
  static const Field<Company, Color> _f$secondaryColor =
      Field('secondaryColor', _$secondaryColor, opt: true);
  static Color? _$accentColor(Company v) => v.accentColor;
  static const Field<Company, Color> _f$accentColor =
      Field('accentColor', _$accentColor, opt: true);
  static Contact? _$contact(Company v) => v.contact;
  static const Field<Company, Contact> _f$contact =
      Field('contact', _$contact, opt: true);
  static CoverLetter? _$coverLetter(Company v) => v.coverLetter;
  static const Field<Company, CoverLetter> _f$coverLetter =
      Field('coverLetter', _$coverLetter, opt: true);
  static DateTime? _$inviteDate(Company v) => v.inviteDate;
  static const Field<Company, DateTime> _f$inviteDate =
      Field('inviteDate', _$inviteDate, opt: true);
  static Duration? _$inviteDuration(Company v) => v.inviteDuration;
  static const Field<Company, Duration> _f$inviteDuration =
      Field('inviteDuration', _$inviteDuration, opt: true);
  static DecisionStatus _$decisionStatus(Company v) => v.decisionStatus;
  static const Field<Company, DecisionStatus> _f$decisionStatus =
      Field('decisionStatus', _$decisionStatus, opt: true);
  static String? _$decisionMessage(Company v) => v.decisionMessage;
  static const Field<Company, String> _f$decisionMessage =
      Field('decisionMessage', _$decisionMessage, opt: true);
  static bool? _$employeeAcceptedInvite(Company v) => v.employeeAcceptedInvite;
  static const Field<Company, bool> _f$employeeAcceptedInvite =
      Field('employeeAcceptedInvite', _$employeeAcceptedInvite, opt: true);
  static String? _$messageFromEmployee(Company v) => v.messageFromEmployee;
  static const Field<Company, String> _f$messageFromEmployee =
      Field('messageFromEmployee', _$messageFromEmployee, opt: true);

  @override
  final MappableFields<Company> fields = const {
    #id: _f$id,
    #name: _f$name,
    #logoUrl: _f$logoUrl,
    #primaryColor: _f$primaryColor,
    #secondaryColor: _f$secondaryColor,
    #accentColor: _f$accentColor,
    #contact: _f$contact,
    #coverLetter: _f$coverLetter,
    #inviteDate: _f$inviteDate,
    #inviteDuration: _f$inviteDuration,
    #decisionStatus: _f$decisionStatus,
    #decisionMessage: _f$decisionMessage,
    #employeeAcceptedInvite: _f$employeeAcceptedInvite,
    #messageFromEmployee: _f$messageFromEmployee,
  };

  static Company _instantiate(DecodingData data) {
    return Company(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        logoUrl: data.dec(_f$logoUrl),
        primaryColor: data.dec(_f$primaryColor),
        secondaryColor: data.dec(_f$secondaryColor),
        accentColor: data.dec(_f$accentColor),
        contact: data.dec(_f$contact),
        coverLetter: data.dec(_f$coverLetter),
        inviteDate: data.dec(_f$inviteDate),
        inviteDuration: data.dec(_f$inviteDuration),
        decisionStatus: data.dec(_f$decisionStatus),
        decisionMessage: data.dec(_f$decisionMessage),
        employeeAcceptedInvite: data.dec(_f$employeeAcceptedInvite),
        messageFromEmployee: data.dec(_f$messageFromEmployee));
  }

  @override
  final Function instantiate = _instantiate;

  static Company fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Company>(map);
  }

  static Company fromJson(String json) {
    return ensureInitialized().decodeJson<Company>(json);
  }
}

mixin CompanyMappable {
  String toJson() {
    return CompanyMapper.ensureInitialized()
        .encodeJson<Company>(this as Company);
  }

  Map<String, dynamic> toMap() {
    return CompanyMapper.ensureInitialized()
        .encodeMap<Company>(this as Company);
  }

  CompanyCopyWith<Company, Company, Company> get copyWith =>
      _CompanyCopyWithImpl<Company, Company>(
          this as Company, $identity, $identity);
  @override
  String toString() {
    return CompanyMapper.ensureInitialized().stringifyValue(this as Company);
  }

  @override
  bool operator ==(Object other) {
    return CompanyMapper.ensureInitialized()
        .equalsValue(this as Company, other);
  }

  @override
  int get hashCode {
    return CompanyMapper.ensureInitialized().hashValue(this as Company);
  }
}

extension CompanyValueCopy<$R, $Out> on ObjectCopyWith<$R, Company, $Out> {
  CompanyCopyWith<$R, Company, $Out> get $asCompany =>
      $base.as((v, t, t2) => _CompanyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CompanyCopyWith<$R, $In extends Company, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ContactCopyWith<$R, Contact, Contact>? get contact;
  CoverLetterCopyWith<$R, CoverLetter, CoverLetter>? get coverLetter;
  $R call(
      {String? id,
      String? name,
      String? logoUrl,
      Color? primaryColor,
      Color? secondaryColor,
      Color? accentColor,
      Contact? contact,
      CoverLetter? coverLetter,
      DateTime? inviteDate,
      Duration? inviteDuration,
      DecisionStatus? decisionStatus,
      String? decisionMessage,
      bool? employeeAcceptedInvite,
      String? messageFromEmployee});
  CompanyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CompanyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Company, $Out>
    implements CompanyCopyWith<$R, Company, $Out> {
  _CompanyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Company> $mapper =
      CompanyMapper.ensureInitialized();
  @override
  ContactCopyWith<$R, Contact, Contact>? get contact =>
      $value.contact?.copyWith.$chain((v) => call(contact: v));
  @override
  CoverLetterCopyWith<$R, CoverLetter, CoverLetter>? get coverLetter =>
      $value.coverLetter?.copyWith.$chain((v) => call(coverLetter: v));
  @override
  $R call(
          {String? id,
          String? name,
          Object? logoUrl = $none,
          Object? primaryColor = $none,
          Object? secondaryColor = $none,
          Object? accentColor = $none,
          Object? contact = $none,
          Object? coverLetter = $none,
          Object? inviteDate = $none,
          Object? inviteDuration = $none,
          Object? decisionStatus = $none,
          Object? decisionMessage = $none,
          Object? employeeAcceptedInvite = $none,
          Object? messageFromEmployee = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (logoUrl != $none) #logoUrl: logoUrl,
        if (primaryColor != $none) #primaryColor: primaryColor,
        if (secondaryColor != $none) #secondaryColor: secondaryColor,
        if (accentColor != $none) #accentColor: accentColor,
        if (contact != $none) #contact: contact,
        if (coverLetter != $none) #coverLetter: coverLetter,
        if (inviteDate != $none) #inviteDate: inviteDate,
        if (inviteDuration != $none) #inviteDuration: inviteDuration,
        if (decisionStatus != $none) #decisionStatus: decisionStatus,
        if (decisionMessage != $none) #decisionMessage: decisionMessage,
        if (employeeAcceptedInvite != $none)
          #employeeAcceptedInvite: employeeAcceptedInvite,
        if (messageFromEmployee != $none)
          #messageFromEmployee: messageFromEmployee
      }));
  @override
  Company $make(CopyWithData data) => Company(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      logoUrl: data.get(#logoUrl, or: $value.logoUrl),
      primaryColor: data.get(#primaryColor, or: $value.primaryColor),
      secondaryColor: data.get(#secondaryColor, or: $value.secondaryColor),
      accentColor: data.get(#accentColor, or: $value.accentColor),
      contact: data.get(#contact, or: $value.contact),
      coverLetter: data.get(#coverLetter, or: $value.coverLetter),
      inviteDate: data.get(#inviteDate, or: $value.inviteDate),
      inviteDuration: data.get(#inviteDuration, or: $value.inviteDuration),
      decisionStatus: data.get(#decisionStatus, or: $value.decisionStatus),
      decisionMessage: data.get(#decisionMessage, or: $value.decisionMessage),
      employeeAcceptedInvite:
          data.get(#employeeAcceptedInvite, or: $value.employeeAcceptedInvite),
      messageFromEmployee:
          data.get(#messageFromEmployee, or: $value.messageFromEmployee));

  @override
  CompanyCopyWith<$R2, Company, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CompanyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
