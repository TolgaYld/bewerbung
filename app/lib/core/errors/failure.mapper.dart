// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'failure.dart';

class FailureMapper extends ClassMapperBase<Failure> {
  FailureMapper._();

  static FailureMapper? _instance;
  static FailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = FailureMapper._());
      ServerFailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Failure';

  static String _$message(Failure v) => v.message;
  static const Field<Failure, String> _f$message = Field('message', _$message);
  static bool _$isUnknownException(Failure v) => v.isUnknownException;
  static const Field<Failure, bool> _f$isUnknownException =
      Field('isUnknownException', _$isUnknownException, opt: true, def: false);
  static int? _$statusCode(Failure v) => v.statusCode;
  static const Field<Failure, int> _f$statusCode =
      Field('statusCode', _$statusCode, opt: true);

  @override
  final MappableFields<Failure> fields = const {
    #message: _f$message,
    #isUnknownException: _f$isUnknownException,
    #statusCode: _f$statusCode,
  };

  static Failure _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('Failure');
  }

  @override
  final Function instantiate = _instantiate;

  static Failure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Failure>(map);
  }

  static Failure fromJson(String json) {
    return ensureInitialized().decodeJson<Failure>(json);
  }
}

mixin FailureMappable {
  String toJson();
  Map<String, dynamic> toMap();
  FailureCopyWith<Failure, Failure, Failure> get copyWith;
}

abstract class FailureCopyWith<$R, $In extends Failure, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? message, int? statusCode});
  FailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class ServerFailureMapper extends ClassMapperBase<ServerFailure> {
  ServerFailureMapper._();

  static ServerFailureMapper? _instance;
  static ServerFailureMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerFailureMapper._());
      FailureMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ServerFailure';

  static String _$message(ServerFailure v) => v.message;
  static const Field<ServerFailure, String> _f$message =
      Field('message', _$message);
  static int? _$statusCode(ServerFailure v) => v.statusCode;
  static const Field<ServerFailure, int> _f$statusCode =
      Field('statusCode', _$statusCode, opt: true);
  static bool _$isUnknownException(ServerFailure v) => v.isUnknownException;
  static const Field<ServerFailure, bool> _f$isUnknownException =
      Field('isUnknownException', _$isUnknownException, mode: FieldMode.member);

  @override
  final MappableFields<ServerFailure> fields = const {
    #message: _f$message,
    #statusCode: _f$statusCode,
    #isUnknownException: _f$isUnknownException,
  };

  static ServerFailure _instantiate(DecodingData data) {
    return ServerFailure(
        message: data.dec(_f$message), statusCode: data.dec(_f$statusCode));
  }

  @override
  final Function instantiate = _instantiate;

  static ServerFailure fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerFailure>(map);
  }

  static ServerFailure fromJson(String json) {
    return ensureInitialized().decodeJson<ServerFailure>(json);
  }
}

mixin ServerFailureMappable {
  String toJson() {
    return ServerFailureMapper.ensureInitialized()
        .encodeJson<ServerFailure>(this as ServerFailure);
  }

  Map<String, dynamic> toMap() {
    return ServerFailureMapper.ensureInitialized()
        .encodeMap<ServerFailure>(this as ServerFailure);
  }

  ServerFailureCopyWith<ServerFailure, ServerFailure, ServerFailure>
      get copyWith => _ServerFailureCopyWithImpl<ServerFailure, ServerFailure>(
          this as ServerFailure, $identity, $identity);
  @override
  String toString() {
    return ServerFailureMapper.ensureInitialized()
        .stringifyValue(this as ServerFailure);
  }

  @override
  bool operator ==(Object other) {
    return ServerFailureMapper.ensureInitialized()
        .equalsValue(this as ServerFailure, other);
  }

  @override
  int get hashCode {
    return ServerFailureMapper.ensureInitialized()
        .hashValue(this as ServerFailure);
  }
}

extension ServerFailureValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerFailure, $Out> {
  ServerFailureCopyWith<$R, ServerFailure, $Out> get $asServerFailure =>
      $base.as((v, t, t2) => _ServerFailureCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ServerFailureCopyWith<$R, $In extends ServerFailure, $Out>
    implements FailureCopyWith<$R, $In, $Out> {
  @override
  $R call({String? message, int? statusCode});
  ServerFailureCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ServerFailureCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerFailure, $Out>
    implements ServerFailureCopyWith<$R, ServerFailure, $Out> {
  _ServerFailureCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerFailure> $mapper =
      ServerFailureMapper.ensureInitialized();
  @override
  $R call({String? message, Object? statusCode = $none}) =>
      $apply(FieldCopyWithData({
        if (message != null) #message: message,
        if (statusCode != $none) #statusCode: statusCode
      }));
  @override
  ServerFailure $make(CopyWithData data) => ServerFailure(
      message: data.get(#message, or: $value.message),
      statusCode: data.get(#statusCode, or: $value.statusCode));

  @override
  ServerFailureCopyWith<$R2, ServerFailure, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ServerFailureCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
