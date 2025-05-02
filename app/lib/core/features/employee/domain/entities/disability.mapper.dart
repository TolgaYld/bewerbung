// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'disability.dart';

class DisabilityMapper extends ClassMapperBase<Disability> {
  DisabilityMapper._();

  static DisabilityMapper? _instance;
  static DisabilityMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DisabilityMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Disability';

  static String _$type(Disability v) => v.type;
  static const Field<Disability, String> _f$type = Field('type', _$type);
  static double _$percentage(Disability v) => v.percentage;
  static const Field<Disability, double> _f$percentage =
      Field('percentage', _$percentage);
  static String? _$description(Disability v) => v.description;
  static const Field<Disability, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$url(Disability v) => v.url;
  static const Field<Disability, String> _f$url =
      Field('url', _$url, opt: true);

  @override
  final MappableFields<Disability> fields = const {
    #type: _f$type,
    #percentage: _f$percentage,
    #description: _f$description,
    #url: _f$url,
  };

  static Disability _instantiate(DecodingData data) {
    return Disability(
        type: data.dec(_f$type),
        percentage: data.dec(_f$percentage),
        description: data.dec(_f$description),
        url: data.dec(_f$url));
  }

  @override
  final Function instantiate = _instantiate;

  static Disability fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Disability>(map);
  }

  static Disability fromJson(String json) {
    return ensureInitialized().decodeJson<Disability>(json);
  }
}

mixin DisabilityMappable {
  String toJson() {
    return DisabilityMapper.ensureInitialized()
        .encodeJson<Disability>(this as Disability);
  }

  Map<String, dynamic> toMap() {
    return DisabilityMapper.ensureInitialized()
        .encodeMap<Disability>(this as Disability);
  }

  DisabilityCopyWith<Disability, Disability, Disability> get copyWith =>
      _DisabilityCopyWithImpl<Disability, Disability>(
          this as Disability, $identity, $identity);
  @override
  String toString() {
    return DisabilityMapper.ensureInitialized()
        .stringifyValue(this as Disability);
  }

  @override
  bool operator ==(Object other) {
    return DisabilityMapper.ensureInitialized()
        .equalsValue(this as Disability, other);
  }

  @override
  int get hashCode {
    return DisabilityMapper.ensureInitialized().hashValue(this as Disability);
  }
}

extension DisabilityValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Disability, $Out> {
  DisabilityCopyWith<$R, Disability, $Out> get $asDisability =>
      $base.as((v, t, t2) => _DisabilityCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DisabilityCopyWith<$R, $In extends Disability, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? type, double? percentage, String? description, String? url});
  DisabilityCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DisabilityCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Disability, $Out>
    implements DisabilityCopyWith<$R, Disability, $Out> {
  _DisabilityCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Disability> $mapper =
      DisabilityMapper.ensureInitialized();
  @override
  $R call(
          {String? type,
          double? percentage,
          Object? description = $none,
          Object? url = $none}) =>
      $apply(FieldCopyWithData({
        if (type != null) #type: type,
        if (percentage != null) #percentage: percentage,
        if (description != $none) #description: description,
        if (url != $none) #url: url
      }));
  @override
  Disability $make(CopyWithData data) => Disability(
      type: data.get(#type, or: $value.type),
      percentage: data.get(#percentage, or: $value.percentage),
      description: data.get(#description, or: $value.description),
      url: data.get(#url, or: $value.url));

  @override
  DisabilityCopyWith<$R2, Disability, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DisabilityCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
