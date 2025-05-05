// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'privacy_policy.dart';

class PrivacyPolicyMapper extends ClassMapperBase<PrivacyPolicy> {
  PrivacyPolicyMapper._();

  static PrivacyPolicyMapper? _instance;
  static PrivacyPolicyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PrivacyPolicyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PrivacyPolicy';

  static Map<String, String> _$_content(PrivacyPolicy v) => v._content;
  static const Field<PrivacyPolicy, Map<String, String>> _f$_content =
      Field('_content', _$_content, key: r'content');

  @override
  final MappableFields<PrivacyPolicy> fields = const {
    #_content: _f$_content,
  };

  static PrivacyPolicy _instantiate(DecodingData data) {
    return PrivacyPolicy(content: data.dec(_f$_content));
  }

  @override
  final Function instantiate = _instantiate;

  static PrivacyPolicy fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PrivacyPolicy>(map);
  }

  static PrivacyPolicy fromJson(String json) {
    return ensureInitialized().decodeJson<PrivacyPolicy>(json);
  }
}

mixin PrivacyPolicyMappable {
  String toJson() {
    return PrivacyPolicyMapper.ensureInitialized()
        .encodeJson<PrivacyPolicy>(this as PrivacyPolicy);
  }

  Map<String, dynamic> toMap() {
    return PrivacyPolicyMapper.ensureInitialized()
        .encodeMap<PrivacyPolicy>(this as PrivacyPolicy);
  }

  PrivacyPolicyCopyWith<PrivacyPolicy, PrivacyPolicy, PrivacyPolicy>
      get copyWith => _PrivacyPolicyCopyWithImpl<PrivacyPolicy, PrivacyPolicy>(
          this as PrivacyPolicy, $identity, $identity);
  @override
  String toString() {
    return PrivacyPolicyMapper.ensureInitialized()
        .stringifyValue(this as PrivacyPolicy);
  }

  @override
  bool operator ==(Object other) {
    return PrivacyPolicyMapper.ensureInitialized()
        .equalsValue(this as PrivacyPolicy, other);
  }

  @override
  int get hashCode {
    return PrivacyPolicyMapper.ensureInitialized()
        .hashValue(this as PrivacyPolicy);
  }
}

extension PrivacyPolicyValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PrivacyPolicy, $Out> {
  PrivacyPolicyCopyWith<$R, PrivacyPolicy, $Out> get $asPrivacyPolicy =>
      $base.as((v, t, t2) => _PrivacyPolicyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PrivacyPolicyCopyWith<$R, $In extends PrivacyPolicy, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get _content;
  $R call({Map<String, String>? content});
  PrivacyPolicyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PrivacyPolicyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PrivacyPolicy, $Out>
    implements PrivacyPolicyCopyWith<$R, PrivacyPolicy, $Out> {
  _PrivacyPolicyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PrivacyPolicy> $mapper =
      PrivacyPolicyMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get _content => MapCopyWith($value._content,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(content: v));
  @override
  $R call({Map<String, String>? content}) =>
      $apply(FieldCopyWithData({if (content != null) #content: content}));
  @override
  PrivacyPolicy $make(CopyWithData data) =>
      PrivacyPolicy(content: data.get(#content, or: $value._content));

  @override
  PrivacyPolicyCopyWith<$R2, PrivacyPolicy, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _PrivacyPolicyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
