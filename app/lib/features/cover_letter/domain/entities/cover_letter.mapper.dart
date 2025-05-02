// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cover_letter.dart';

class CoverLetterMapper extends ClassMapperBase<CoverLetter> {
  CoverLetterMapper._();

  static CoverLetterMapper? _instance;
  static CoverLetterMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CoverLetterMapper._());
      CoverLetterTranslationMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CoverLetter';

  static DateTime? _$date(CoverLetter v) => v.date;
  static const Field<CoverLetter, DateTime> _f$date =
      Field('date', _$date, opt: true);
  static String? _$signature(CoverLetter v) => v.signature;
  static const Field<CoverLetter, String> _f$signature =
      Field('signature', _$signature, opt: true);
  static Map<String, CoverLetterTranslation>? _$translations(CoverLetter v) =>
      v.translations;
  static const Field<CoverLetter, Map<String, CoverLetterTranslation>>
      _f$translations = Field('translations', _$translations, opt: true);
  static String? _$imageUrl(CoverLetter v) => v.imageUrl;
  static const Field<CoverLetter, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, opt: true);
  static String? _$address(CoverLetter v) => v.address;
  static const Field<CoverLetter, String> _f$address =
      Field('address', _$address, opt: true);

  @override
  final MappableFields<CoverLetter> fields = const {
    #date: _f$date,
    #signature: _f$signature,
    #translations: _f$translations,
    #imageUrl: _f$imageUrl,
    #address: _f$address,
  };

  static CoverLetter _instantiate(DecodingData data) {
    return CoverLetter(
        date: data.dec(_f$date),
        signature: data.dec(_f$signature),
        translations: data.dec(_f$translations),
        imageUrl: data.dec(_f$imageUrl),
        address: data.dec(_f$address));
  }

  @override
  final Function instantiate = _instantiate;

  static CoverLetter fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CoverLetter>(map);
  }

  static CoverLetter fromJson(String json) {
    return ensureInitialized().decodeJson<CoverLetter>(json);
  }
}

mixin CoverLetterMappable {
  String toJson() {
    return CoverLetterMapper.ensureInitialized()
        .encodeJson<CoverLetter>(this as CoverLetter);
  }

  Map<String, dynamic> toMap() {
    return CoverLetterMapper.ensureInitialized()
        .encodeMap<CoverLetter>(this as CoverLetter);
  }

  CoverLetterCopyWith<CoverLetter, CoverLetter, CoverLetter> get copyWith =>
      _CoverLetterCopyWithImpl<CoverLetter, CoverLetter>(
          this as CoverLetter, $identity, $identity);
  @override
  String toString() {
    return CoverLetterMapper.ensureInitialized()
        .stringifyValue(this as CoverLetter);
  }

  @override
  bool operator ==(Object other) {
    return CoverLetterMapper.ensureInitialized()
        .equalsValue(this as CoverLetter, other);
  }

  @override
  int get hashCode {
    return CoverLetterMapper.ensureInitialized().hashValue(this as CoverLetter);
  }
}

extension CoverLetterValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CoverLetter, $Out> {
  CoverLetterCopyWith<$R, CoverLetter, $Out> get $asCoverLetter =>
      $base.as((v, t, t2) => _CoverLetterCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CoverLetterCopyWith<$R, $In extends CoverLetter, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<
      $R,
      String,
      CoverLetterTranslation,
      CoverLetterTranslationCopyWith<$R, CoverLetterTranslation,
          CoverLetterTranslation>>? get translations;
  $R call(
      {DateTime? date,
      String? signature,
      Map<String, CoverLetterTranslation>? translations,
      String? imageUrl,
      String? address});
  CoverLetterCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CoverLetterCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CoverLetter, $Out>
    implements CoverLetterCopyWith<$R, CoverLetter, $Out> {
  _CoverLetterCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CoverLetter> $mapper =
      CoverLetterMapper.ensureInitialized();
  @override
  MapCopyWith<
      $R,
      String,
      CoverLetterTranslation,
      CoverLetterTranslationCopyWith<$R, CoverLetterTranslation,
          CoverLetterTranslation>>? get translations =>
      $value.translations != null
          ? MapCopyWith($value.translations!, (v, t) => v.copyWith.$chain(t),
              (v) => call(translations: v))
          : null;
  @override
  $R call(
          {Object? date = $none,
          Object? signature = $none,
          Object? translations = $none,
          Object? imageUrl = $none,
          Object? address = $none}) =>
      $apply(FieldCopyWithData({
        if (date != $none) #date: date,
        if (signature != $none) #signature: signature,
        if (translations != $none) #translations: translations,
        if (imageUrl != $none) #imageUrl: imageUrl,
        if (address != $none) #address: address
      }));
  @override
  CoverLetter $make(CopyWithData data) => CoverLetter(
      date: data.get(#date, or: $value.date),
      signature: data.get(#signature, or: $value.signature),
      translations: data.get(#translations, or: $value.translations),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      address: data.get(#address, or: $value.address));

  @override
  CoverLetterCopyWith<$R2, CoverLetter, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CoverLetterCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CoverLetterTranslationMapper
    extends ClassMapperBase<CoverLetterTranslation> {
  CoverLetterTranslationMapper._();

  static CoverLetterTranslationMapper? _instance;
  static CoverLetterTranslationMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CoverLetterTranslationMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CoverLetterTranslation';

  static String _$subject(CoverLetterTranslation v) => v.subject;
  static const Field<CoverLetterTranslation, String> _f$subject =
      Field('subject', _$subject);
  static String _$content(CoverLetterTranslation v) => v.content;
  static const Field<CoverLetterTranslation, String> _f$content =
      Field('content', _$content);
  static String? _$position(CoverLetterTranslation v) => v.position;
  static const Field<CoverLetterTranslation, String> _f$position =
      Field('position', _$position, opt: true);
  static String? _$city(CoverLetterTranslation v) => v.city;
  static const Field<CoverLetterTranslation, String> _f$city =
      Field('city', _$city, opt: true);

  @override
  final MappableFields<CoverLetterTranslation> fields = const {
    #subject: _f$subject,
    #content: _f$content,
    #position: _f$position,
    #city: _f$city,
  };

  static CoverLetterTranslation _instantiate(DecodingData data) {
    return CoverLetterTranslation(
        subject: data.dec(_f$subject),
        content: data.dec(_f$content),
        position: data.dec(_f$position),
        city: data.dec(_f$city));
  }

  @override
  final Function instantiate = _instantiate;

  static CoverLetterTranslation fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CoverLetterTranslation>(map);
  }

  static CoverLetterTranslation fromJson(String json) {
    return ensureInitialized().decodeJson<CoverLetterTranslation>(json);
  }
}

mixin CoverLetterTranslationMappable {
  String toJson() {
    return CoverLetterTranslationMapper.ensureInitialized()
        .encodeJson<CoverLetterTranslation>(this as CoverLetterTranslation);
  }

  Map<String, dynamic> toMap() {
    return CoverLetterTranslationMapper.ensureInitialized()
        .encodeMap<CoverLetterTranslation>(this as CoverLetterTranslation);
  }

  CoverLetterTranslationCopyWith<CoverLetterTranslation, CoverLetterTranslation,
          CoverLetterTranslation>
      get copyWith => _CoverLetterTranslationCopyWithImpl<
              CoverLetterTranslation, CoverLetterTranslation>(
          this as CoverLetterTranslation, $identity, $identity);
  @override
  String toString() {
    return CoverLetterTranslationMapper.ensureInitialized()
        .stringifyValue(this as CoverLetterTranslation);
  }

  @override
  bool operator ==(Object other) {
    return CoverLetterTranslationMapper.ensureInitialized()
        .equalsValue(this as CoverLetterTranslation, other);
  }

  @override
  int get hashCode {
    return CoverLetterTranslationMapper.ensureInitialized()
        .hashValue(this as CoverLetterTranslation);
  }
}

extension CoverLetterTranslationValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CoverLetterTranslation, $Out> {
  CoverLetterTranslationCopyWith<$R, CoverLetterTranslation, $Out>
      get $asCoverLetterTranslation => $base.as((v, t, t2) =>
          _CoverLetterTranslationCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CoverLetterTranslationCopyWith<
    $R,
    $In extends CoverLetterTranslation,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? subject, String? content, String? position, String? city});
  CoverLetterTranslationCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CoverLetterTranslationCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CoverLetterTranslation, $Out>
    implements
        CoverLetterTranslationCopyWith<$R, CoverLetterTranslation, $Out> {
  _CoverLetterTranslationCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CoverLetterTranslation> $mapper =
      CoverLetterTranslationMapper.ensureInitialized();
  @override
  $R call(
          {String? subject,
          String? content,
          Object? position = $none,
          Object? city = $none}) =>
      $apply(FieldCopyWithData({
        if (subject != null) #subject: subject,
        if (content != null) #content: content,
        if (position != $none) #position: position,
        if (city != $none) #city: city
      }));
  @override
  CoverLetterTranslation $make(CopyWithData data) => CoverLetterTranslation(
      subject: data.get(#subject, or: $value.subject),
      content: data.get(#content, or: $value.content),
      position: data.get(#position, or: $value.position),
      city: data.get(#city, or: $value.city));

  @override
  CoverLetterTranslationCopyWith<$R2, CoverLetterTranslation, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CoverLetterTranslationCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
