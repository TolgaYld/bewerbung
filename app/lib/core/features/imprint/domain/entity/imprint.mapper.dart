// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'imprint.dart';

class ImprintMapper extends ClassMapperBase<Imprint> {
  ImprintMapper._();

  static ImprintMapper? _instance;
  static ImprintMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ImprintMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Imprint';

  static Map<String, Map<String, String>> _$translations(Imprint v) =>
      v.translations;
  static const Field<Imprint, Map<String, Map<String, String>>>
      _f$translations = Field('translations', _$translations);

  @override
  final MappableFields<Imprint> fields = const {
    #translations: _f$translations,
  };

  static Imprint _instantiate(DecodingData data) {
    return Imprint(translations: data.dec(_f$translations));
  }

  @override
  final Function instantiate = _instantiate;

  static Imprint fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Imprint>(map);
  }

  static Imprint fromJson(String json) {
    return ensureInitialized().decodeJson<Imprint>(json);
  }
}

mixin ImprintMappable {
  String toJson() {
    return ImprintMapper.ensureInitialized()
        .encodeJson<Imprint>(this as Imprint);
  }

  Map<String, dynamic> toMap() {
    return ImprintMapper.ensureInitialized()
        .encodeMap<Imprint>(this as Imprint);
  }

  ImprintCopyWith<Imprint, Imprint, Imprint> get copyWith =>
      _ImprintCopyWithImpl<Imprint, Imprint>(
          this as Imprint, $identity, $identity);
  @override
  String toString() {
    return ImprintMapper.ensureInitialized().stringifyValue(this as Imprint);
  }

  @override
  bool operator ==(Object other) {
    return ImprintMapper.ensureInitialized()
        .equalsValue(this as Imprint, other);
  }

  @override
  int get hashCode {
    return ImprintMapper.ensureInitialized().hashValue(this as Imprint);
  }
}

extension ImprintValueCopy<$R, $Out> on ObjectCopyWith<$R, Imprint, $Out> {
  ImprintCopyWith<$R, Imprint, $Out> get $asImprint =>
      $base.as((v, t, t2) => _ImprintCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ImprintCopyWith<$R, $In extends Imprint, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, Map<String, String>,
          ObjectCopyWith<$R, Map<String, String>, Map<String, String>>>
      get translations;
  $R call({Map<String, Map<String, String>>? translations});
  ImprintCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ImprintCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Imprint, $Out>
    implements ImprintCopyWith<$R, Imprint, $Out> {
  _ImprintCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Imprint> $mapper =
      ImprintMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, Map<String, String>,
          ObjectCopyWith<$R, Map<String, String>, Map<String, String>>>
      get translations => MapCopyWith(
          $value.translations,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(translations: v));
  @override
  $R call({Map<String, Map<String, String>>? translations}) =>
      $apply(FieldCopyWithData(
          {if (translations != null) #translations: translations}));
  @override
  Imprint $make(CopyWithData data) =>
      Imprint(translations: data.get(#translations, or: $value.translations));

  @override
  ImprintCopyWith<$R2, Imprint, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ImprintCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
