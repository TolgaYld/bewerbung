// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'person.dart';

class GenderMapper extends EnumMapper<Gender> {
  GenderMapper._();

  static GenderMapper? _instance;
  static GenderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = GenderMapper._());
    }
    return _instance!;
  }

  static Gender fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  Gender decode(dynamic value) {
    switch (value) {
      case r'male':
        return Gender.male;
      case r'female':
        return Gender.female;
      case r'other':
        return Gender.other;
      case r'preferNotToSay':
        return Gender.preferNotToSay;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(Gender self) {
    switch (self) {
      case Gender.male:
        return r'male';
      case Gender.female:
        return r'female';
      case Gender.other:
        return r'other';
      case Gender.preferNotToSay:
        return r'preferNotToSay';
    }
  }
}

extension GenderMapperExtension on Gender {
  String toValue() {
    GenderMapper.ensureInitialized();
    return MapperContainer.globals.toValue<Gender>(this) as String;
  }
}

class PersonMapper extends ClassMapperBase<Person> {
  PersonMapper._();

  static PersonMapper? _instance;
  static PersonMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PersonMapper._());
      GenderMapper.ensureInitialized();
      ContactMapper.ensureInitialized();
      DisabilityMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Person';

  static Gender _$gender(Person v) => v.gender;
  static const Field<Person, Gender> _f$gender = Field('gender', _$gender);
  static String _$firstName(Person v) => v.firstName;
  static const Field<Person, String> _f$firstName =
      Field('firstName', _$firstName);
  static String _$lastName(Person v) => v.lastName;
  static const Field<Person, String> _f$lastName =
      Field('lastName', _$lastName);
  static DateTime _$birthDate(Person v) => v.birthDate;
  static const Field<Person, DateTime> _f$birthDate =
      Field('birthDate', _$birthDate);
  static Contact? _$contact(Person v) => v.contact;
  static const Field<Person, Contact> _f$contact =
      Field('contact', _$contact, opt: true);
  static Disability? _$disability(Person v) => v.disability;
  static const Field<Person, Disability> _f$disability =
      Field('disability', _$disability, opt: true);
  static List<String>? _$imageUrls(Person v) => v.imageUrls;
  static const Field<Person, List<String>> _f$imageUrls =
      Field('imageUrls', _$imageUrls, opt: true);

  @override
  final MappableFields<Person> fields = const {
    #gender: _f$gender,
    #firstName: _f$firstName,
    #lastName: _f$lastName,
    #birthDate: _f$birthDate,
    #contact: _f$contact,
    #disability: _f$disability,
    #imageUrls: _f$imageUrls,
  };

  static Person _instantiate(DecodingData data) {
    return Person(
        gender: data.dec(_f$gender),
        firstName: data.dec(_f$firstName),
        lastName: data.dec(_f$lastName),
        birthDate: data.dec(_f$birthDate),
        contact: data.dec(_f$contact),
        disability: data.dec(_f$disability),
        imageUrls: data.dec(_f$imageUrls));
  }

  @override
  final Function instantiate = _instantiate;

  static Person fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Person>(map);
  }

  static Person fromJson(String json) {
    return ensureInitialized().decodeJson<Person>(json);
  }
}

mixin PersonMappable {
  String toJson() {
    return PersonMapper.ensureInitialized().encodeJson<Person>(this as Person);
  }

  Map<String, dynamic> toMap() {
    return PersonMapper.ensureInitialized().encodeMap<Person>(this as Person);
  }

  PersonCopyWith<Person, Person, Person> get copyWith =>
      _PersonCopyWithImpl<Person, Person>(this as Person, $identity, $identity);
  @override
  String toString() {
    return PersonMapper.ensureInitialized().stringifyValue(this as Person);
  }

  @override
  bool operator ==(Object other) {
    return PersonMapper.ensureInitialized().equalsValue(this as Person, other);
  }

  @override
  int get hashCode {
    return PersonMapper.ensureInitialized().hashValue(this as Person);
  }
}

extension PersonValueCopy<$R, $Out> on ObjectCopyWith<$R, Person, $Out> {
  PersonCopyWith<$R, Person, $Out> get $asPerson =>
      $base.as((v, t, t2) => _PersonCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PersonCopyWith<$R, $In extends Person, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ContactCopyWith<$R, Contact, Contact>? get contact;
  DisabilityCopyWith<$R, Disability, Disability>? get disability;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get imageUrls;
  $R call(
      {Gender? gender,
      String? firstName,
      String? lastName,
      DateTime? birthDate,
      Contact? contact,
      Disability? disability,
      List<String>? imageUrls});
  PersonCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PersonCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Person, $Out>
    implements PersonCopyWith<$R, Person, $Out> {
  _PersonCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Person> $mapper = PersonMapper.ensureInitialized();
  @override
  ContactCopyWith<$R, Contact, Contact>? get contact =>
      $value.contact?.copyWith.$chain((v) => call(contact: v));
  @override
  DisabilityCopyWith<$R, Disability, Disability>? get disability =>
      $value.disability?.copyWith.$chain((v) => call(disability: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get imageUrls =>
      $value.imageUrls != null
          ? ListCopyWith(
              $value.imageUrls!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(imageUrls: v))
          : null;
  @override
  $R call(
          {Gender? gender,
          String? firstName,
          String? lastName,
          DateTime? birthDate,
          Object? contact = $none,
          Object? disability = $none,
          Object? imageUrls = $none}) =>
      $apply(FieldCopyWithData({
        if (gender != null) #gender: gender,
        if (firstName != null) #firstName: firstName,
        if (lastName != null) #lastName: lastName,
        if (birthDate != null) #birthDate: birthDate,
        if (contact != $none) #contact: contact,
        if (disability != $none) #disability: disability,
        if (imageUrls != $none) #imageUrls: imageUrls
      }));
  @override
  Person $make(CopyWithData data) => Person(
      gender: data.get(#gender, or: $value.gender),
      firstName: data.get(#firstName, or: $value.firstName),
      lastName: data.get(#lastName, or: $value.lastName),
      birthDate: data.get(#birthDate, or: $value.birthDate),
      contact: data.get(#contact, or: $value.contact),
      disability: data.get(#disability, or: $value.disability),
      imageUrls: data.get(#imageUrls, or: $value.imageUrls));

  @override
  PersonCopyWith<$R2, Person, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PersonCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
