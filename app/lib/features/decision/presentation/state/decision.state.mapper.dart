// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'decision.state.dart';

class DecisionStateMapper extends ClassMapperBase<DecisionState> {
  DecisionStateMapper._();

  static DecisionStateMapper? _instance;
  static DecisionStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DecisionStateMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DecisionState';

  static bool _$isLoading(DecisionState v) => v.isLoading;
  static const Field<DecisionState, bool> _f$isLoading =
      Field('isLoading', _$isLoading, opt: true, def: false);
  static String? _$errorMessage(DecisionState v) => v.errorMessage;
  static const Field<DecisionState, String> _f$errorMessage =
      Field('errorMessage', _$errorMessage, opt: true);

  @override
  final MappableFields<DecisionState> fields = const {
    #isLoading: _f$isLoading,
    #errorMessage: _f$errorMessage,
  };

  static DecisionState _instantiate(DecodingData data) {
    return DecisionState(
        isLoading: data.dec(_f$isLoading),
        errorMessage: data.dec(_f$errorMessage));
  }

  @override
  final Function instantiate = _instantiate;

  static DecisionState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DecisionState>(map);
  }

  static DecisionState fromJson(String json) {
    return ensureInitialized().decodeJson<DecisionState>(json);
  }
}

mixin DecisionStateMappable {
  String toJson() {
    return DecisionStateMapper.ensureInitialized()
        .encodeJson<DecisionState>(this as DecisionState);
  }

  Map<String, dynamic> toMap() {
    return DecisionStateMapper.ensureInitialized()
        .encodeMap<DecisionState>(this as DecisionState);
  }

  DecisionStateCopyWith<DecisionState, DecisionState, DecisionState>
      get copyWith => _DecisionStateCopyWithImpl<DecisionState, DecisionState>(
          this as DecisionState, $identity, $identity);
  @override
  String toString() {
    return DecisionStateMapper.ensureInitialized()
        .stringifyValue(this as DecisionState);
  }

  @override
  bool operator ==(Object other) {
    return DecisionStateMapper.ensureInitialized()
        .equalsValue(this as DecisionState, other);
  }

  @override
  int get hashCode {
    return DecisionStateMapper.ensureInitialized()
        .hashValue(this as DecisionState);
  }
}

extension DecisionStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DecisionState, $Out> {
  DecisionStateCopyWith<$R, DecisionState, $Out> get $asDecisionState =>
      $base.as((v, t, t2) => _DecisionStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DecisionStateCopyWith<$R, $In extends DecisionState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({bool? isLoading, String? errorMessage});
  DecisionStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DecisionStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DecisionState, $Out>
    implements DecisionStateCopyWith<$R, DecisionState, $Out> {
  _DecisionStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DecisionState> $mapper =
      DecisionStateMapper.ensureInitialized();
  @override
  $R call({bool? isLoading, Object? errorMessage = $none}) =>
      $apply(FieldCopyWithData({
        if (isLoading != null) #isLoading: isLoading,
        if (errorMessage != $none) #errorMessage: errorMessage
      }));
  @override
  DecisionState $make(CopyWithData data) => DecisionState(
      isLoading: data.get(#isLoading, or: $value.isLoading),
      errorMessage: data.get(#errorMessage, or: $value.errorMessage));

  @override
  DecisionStateCopyWith<$R2, DecisionState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DecisionStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
