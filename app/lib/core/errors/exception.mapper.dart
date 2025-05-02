// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'exception.dart';

class ServerExceptionMapper extends ClassMapperBase<ServerException> {
  ServerExceptionMapper._();

  static ServerExceptionMapper? _instance;
  static ServerExceptionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServerExceptionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ServerException';

  static String _$message(ServerException v) => v.message;
  static const Field<ServerException, String> _f$message =
      Field('message', _$message);
  static bool _$isUnknownException(ServerException v) => v.isUnknownException;
  static const Field<ServerException, bool> _f$isUnknownException =
      Field('isUnknownException', _$isUnknownException, opt: true, def: false);
  static String? _$statusCode(ServerException v) => v.statusCode;
  static const Field<ServerException, String> _f$statusCode =
      Field('statusCode', _$statusCode, opt: true);

  @override
  final MappableFields<ServerException> fields = const {
    #message: _f$message,
    #isUnknownException: _f$isUnknownException,
    #statusCode: _f$statusCode,
  };

  static ServerException _instantiate(DecodingData data) {
    return ServerException(
        message: data.dec(_f$message),
        isUnknownException: data.dec(_f$isUnknownException),
        statusCode: data.dec(_f$statusCode));
  }

  @override
  final Function instantiate = _instantiate;

  static ServerException fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServerException>(map);
  }

  static ServerException fromJson(String json) {
    return ensureInitialized().decodeJson<ServerException>(json);
  }
}

mixin ServerExceptionMappable {
  String toJson() {
    return ServerExceptionMapper.ensureInitialized()
        .encodeJson<ServerException>(this as ServerException);
  }

  Map<String, dynamic> toMap() {
    return ServerExceptionMapper.ensureInitialized()
        .encodeMap<ServerException>(this as ServerException);
  }

  ServerExceptionCopyWith<ServerException, ServerException, ServerException>
      get copyWith =>
          _ServerExceptionCopyWithImpl<ServerException, ServerException>(
              this as ServerException, $identity, $identity);
  @override
  String toString() {
    return ServerExceptionMapper.ensureInitialized()
        .stringifyValue(this as ServerException);
  }

  @override
  bool operator ==(Object other) {
    return ServerExceptionMapper.ensureInitialized()
        .equalsValue(this as ServerException, other);
  }

  @override
  int get hashCode {
    return ServerExceptionMapper.ensureInitialized()
        .hashValue(this as ServerException);
  }
}

extension ServerExceptionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServerException, $Out> {
  ServerExceptionCopyWith<$R, ServerException, $Out> get $asServerException =>
      $base.as((v, t, t2) => _ServerExceptionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ServerExceptionCopyWith<$R, $In extends ServerException, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? message, bool? isUnknownException, String? statusCode});
  ServerExceptionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ServerExceptionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServerException, $Out>
    implements ServerExceptionCopyWith<$R, ServerException, $Out> {
  _ServerExceptionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServerException> $mapper =
      ServerExceptionMapper.ensureInitialized();
  @override
  $R call(
          {String? message,
          bool? isUnknownException,
          Object? statusCode = $none}) =>
      $apply(FieldCopyWithData({
        if (message != null) #message: message,
        if (isUnknownException != null) #isUnknownException: isUnknownException,
        if (statusCode != $none) #statusCode: statusCode
      }));
  @override
  ServerException $make(CopyWithData data) => ServerException(
      message: data.get(#message, or: $value.message),
      isUnknownException:
          data.get(#isUnknownException, or: $value.isUnknownException),
      statusCode: data.get(#statusCode, or: $value.statusCode));

  @override
  ServerExceptionCopyWith<$R2, ServerException, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ServerExceptionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
