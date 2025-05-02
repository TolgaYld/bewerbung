// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'contact.dart';

class ContactMapper extends ClassMapperBase<Contact> {
  ContactMapper._();

  static ContactMapper? _instance;
  static ContactMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Contact';

  static String? _$street(Contact v) => v.street;
  static const Field<Contact, String> _f$street =
      Field('street', _$street, opt: true);
  static String? _$postalCode(Contact v) => v.postalCode;
  static const Field<Contact, String> _f$postalCode =
      Field('postalCode', _$postalCode, opt: true);
  static Map<String, String>? _$_city(Contact v) => v._city;
  static const Field<Contact, Map<String, String>> _f$_city =
      Field('_city', _$_city, key: r'city', opt: true);
  static Map<String, String>? _$_country(Contact v) => v._country;
  static const Field<Contact, Map<String, String>> _f$_country =
      Field('_country', _$_country, key: r'country', opt: true);
  static String? _$phoneNumber(Contact v) => v.phoneNumber;
  static const Field<Contact, String> _f$phoneNumber =
      Field('phoneNumber', _$phoneNumber, opt: true);
  static String? _$email(Contact v) => v.email;
  static const Field<Contact, String> _f$email =
      Field('email', _$email, opt: true);

  @override
  final MappableFields<Contact> fields = const {
    #street: _f$street,
    #postalCode: _f$postalCode,
    #_city: _f$_city,
    #_country: _f$_country,
    #phoneNumber: _f$phoneNumber,
    #email: _f$email,
  };

  static Contact _instantiate(DecodingData data) {
    return Contact(
        street: data.dec(_f$street),
        postalCode: data.dec(_f$postalCode),
        city: data.dec(_f$_city),
        country: data.dec(_f$_country),
        phoneNumber: data.dec(_f$phoneNumber),
        email: data.dec(_f$email));
  }

  @override
  final Function instantiate = _instantiate;

  static Contact fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Contact>(map);
  }

  static Contact fromJson(String json) {
    return ensureInitialized().decodeJson<Contact>(json);
  }
}

mixin ContactMappable {
  String toJson() {
    return ContactMapper.ensureInitialized()
        .encodeJson<Contact>(this as Contact);
  }

  Map<String, dynamic> toMap() {
    return ContactMapper.ensureInitialized()
        .encodeMap<Contact>(this as Contact);
  }

  ContactCopyWith<Contact, Contact, Contact> get copyWith =>
      _ContactCopyWithImpl<Contact, Contact>(
          this as Contact, $identity, $identity);
  @override
  String toString() {
    return ContactMapper.ensureInitialized().stringifyValue(this as Contact);
  }

  @override
  bool operator ==(Object other) {
    return ContactMapper.ensureInitialized()
        .equalsValue(this as Contact, other);
  }

  @override
  int get hashCode {
    return ContactMapper.ensureInitialized().hashValue(this as Contact);
  }
}

extension ContactValueCopy<$R, $Out> on ObjectCopyWith<$R, Contact, $Out> {
  ContactCopyWith<$R, Contact, $Out> get $asContact =>
      $base.as((v, t, t2) => _ContactCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContactCopyWith<$R, $In extends Contact, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
      get _city;
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
      get _country;
  $R call(
      {String? street,
      String? postalCode,
      Map<String, String>? city,
      Map<String, String>? country,
      String? phoneNumber,
      String? email});
  ContactCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ContactCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Contact, $Out>
    implements ContactCopyWith<$R, Contact, $Out> {
  _ContactCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Contact> $mapper =
      ContactMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
      get _city => $value._city != null
          ? MapCopyWith($value._city!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(city: v))
          : null;
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
      get _country => $value._country != null
          ? MapCopyWith(
              $value._country!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(country: v))
          : null;
  @override
  $R call(
          {Object? street = $none,
          Object? postalCode = $none,
          Object? city = $none,
          Object? country = $none,
          Object? phoneNumber = $none,
          Object? email = $none}) =>
      $apply(FieldCopyWithData({
        if (street != $none) #street: street,
        if (postalCode != $none) #postalCode: postalCode,
        if (city != $none) #city: city,
        if (country != $none) #country: country,
        if (phoneNumber != $none) #phoneNumber: phoneNumber,
        if (email != $none) #email: email
      }));
  @override
  Contact $make(CopyWithData data) => Contact(
      street: data.get(#street, or: $value.street),
      postalCode: data.get(#postalCode, or: $value.postalCode),
      city: data.get(#city, or: $value._city),
      country: data.get(#country, or: $value._country),
      phoneNumber: data.get(#phoneNumber, or: $value.phoneNumber),
      email: data.get(#email, or: $value.email));

  @override
  ContactCopyWith<$R2, Contact, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ContactCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
