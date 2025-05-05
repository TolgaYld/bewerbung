// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth.state.dart';

class AuthStateMapper extends ClassMapperBase<AuthState> {
  AuthStateMapper._();

  static AuthStateMapper? _instance;
  static AuthStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateMapper._());
      AuthStateLoadingMapper.ensureInitialized();
      AuthStateEditingMapper.ensureInitialized();
      AuthStateAuthenticatedMapper.ensureInitialized();
      AuthStateLoggedOutMapper.ensureInitialized();
      AuthStateErrorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthState';

  @override
  final MappableFields<AuthState> fields = const {};

  static AuthState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('AuthState');
  }

  @override
  final Function instantiate = _instantiate;

  static AuthState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthState>(map);
  }

  static AuthState fromJson(String json) {
    return ensureInitialized().decodeJson<AuthState>(json);
  }
}

mixin AuthStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  AuthStateCopyWith<AuthState, AuthState, AuthState> get copyWith;
}

abstract class AuthStateCopyWith<$R, $In extends AuthState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  AuthStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class AuthStateLoadingMapper extends ClassMapperBase<AuthStateLoading> {
  AuthStateLoadingMapper._();

  static AuthStateLoadingMapper? _instance;
  static AuthStateLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateLoadingMapper._());
      AuthStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthStateLoading';

  static bool _$showLoadingPage(AuthStateLoading v) => v.showLoadingPage;
  static const Field<AuthStateLoading, bool> _f$showLoadingPage =
      Field('showLoadingPage', _$showLoadingPage, opt: true, def: true);

  @override
  final MappableFields<AuthStateLoading> fields = const {
    #showLoadingPage: _f$showLoadingPage,
  };

  static AuthStateLoading _instantiate(DecodingData data) {
    return AuthStateLoading(showLoadingPage: data.dec(_f$showLoadingPage));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthStateLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthStateLoading>(map);
  }

  static AuthStateLoading fromJson(String json) {
    return ensureInitialized().decodeJson<AuthStateLoading>(json);
  }
}

mixin AuthStateLoadingMappable {
  String toJson() {
    return AuthStateLoadingMapper.ensureInitialized()
        .encodeJson<AuthStateLoading>(this as AuthStateLoading);
  }

  Map<String, dynamic> toMap() {
    return AuthStateLoadingMapper.ensureInitialized()
        .encodeMap<AuthStateLoading>(this as AuthStateLoading);
  }

  AuthStateLoadingCopyWith<AuthStateLoading, AuthStateLoading, AuthStateLoading>
      get copyWith =>
          _AuthStateLoadingCopyWithImpl<AuthStateLoading, AuthStateLoading>(
              this as AuthStateLoading, $identity, $identity);
  @override
  String toString() {
    return AuthStateLoadingMapper.ensureInitialized()
        .stringifyValue(this as AuthStateLoading);
  }

  @override
  bool operator ==(Object other) {
    return AuthStateLoadingMapper.ensureInitialized()
        .equalsValue(this as AuthStateLoading, other);
  }

  @override
  int get hashCode {
    return AuthStateLoadingMapper.ensureInitialized()
        .hashValue(this as AuthStateLoading);
  }
}

extension AuthStateLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthStateLoading, $Out> {
  AuthStateLoadingCopyWith<$R, AuthStateLoading, $Out>
      get $asAuthStateLoading => $base
          .as((v, t, t2) => _AuthStateLoadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthStateLoadingCopyWith<$R, $In extends AuthStateLoading, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call({bool? showLoadingPage});
  AuthStateLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthStateLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthStateLoading, $Out>
    implements AuthStateLoadingCopyWith<$R, AuthStateLoading, $Out> {
  _AuthStateLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthStateLoading> $mapper =
      AuthStateLoadingMapper.ensureInitialized();
  @override
  $R call({bool? showLoadingPage}) => $apply(FieldCopyWithData(
      {if (showLoadingPage != null) #showLoadingPage: showLoadingPage}));
  @override
  AuthStateLoading $make(CopyWithData data) => AuthStateLoading(
      showLoadingPage: data.get(#showLoadingPage, or: $value.showLoadingPage));

  @override
  AuthStateLoadingCopyWith<$R2, AuthStateLoading, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthStateLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthStateEditingMapper extends ClassMapperBase<AuthStateEditing> {
  AuthStateEditingMapper._();

  static AuthStateEditingMapper? _instance;
  static AuthStateEditingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateEditingMapper._());
      AuthStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthStateEditing';

  static String? _$username(AuthStateEditing v) => v.username;
  static const Field<AuthStateEditing, String> _f$username =
      Field('username', _$username, opt: true);
  static String? _$password(AuthStateEditing v) => v.password;
  static const Field<AuthStateEditing, String> _f$password =
      Field('password', _$password, opt: true);
  static bool _$showEmail(AuthStateEditing v) => v.showEmail;
  static const Field<AuthStateEditing, bool> _f$showEmail =
      Field('showEmail', _$showEmail, opt: true, def: false);
  static bool _$qrMode(AuthStateEditing v) => v.qrMode;
  static const Field<AuthStateEditing, bool> _f$qrMode =
      Field('qrMode', _$qrMode, opt: true, def: true);

  @override
  final MappableFields<AuthStateEditing> fields = const {
    #username: _f$username,
    #password: _f$password,
    #showEmail: _f$showEmail,
    #qrMode: _f$qrMode,
  };

  static AuthStateEditing _instantiate(DecodingData data) {
    return AuthStateEditing(
        username: data.dec(_f$username),
        password: data.dec(_f$password),
        showEmail: data.dec(_f$showEmail),
        qrMode: data.dec(_f$qrMode));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthStateEditing fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthStateEditing>(map);
  }

  static AuthStateEditing fromJson(String json) {
    return ensureInitialized().decodeJson<AuthStateEditing>(json);
  }
}

mixin AuthStateEditingMappable {
  String toJson() {
    return AuthStateEditingMapper.ensureInitialized()
        .encodeJson<AuthStateEditing>(this as AuthStateEditing);
  }

  Map<String, dynamic> toMap() {
    return AuthStateEditingMapper.ensureInitialized()
        .encodeMap<AuthStateEditing>(this as AuthStateEditing);
  }

  AuthStateEditingCopyWith<AuthStateEditing, AuthStateEditing, AuthStateEditing>
      get copyWith =>
          _AuthStateEditingCopyWithImpl<AuthStateEditing, AuthStateEditing>(
              this as AuthStateEditing, $identity, $identity);
  @override
  String toString() {
    return AuthStateEditingMapper.ensureInitialized()
        .stringifyValue(this as AuthStateEditing);
  }

  @override
  bool operator ==(Object other) {
    return AuthStateEditingMapper.ensureInitialized()
        .equalsValue(this as AuthStateEditing, other);
  }

  @override
  int get hashCode {
    return AuthStateEditingMapper.ensureInitialized()
        .hashValue(this as AuthStateEditing);
  }
}

extension AuthStateEditingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthStateEditing, $Out> {
  AuthStateEditingCopyWith<$R, AuthStateEditing, $Out>
      get $asAuthStateEditing => $base
          .as((v, t, t2) => _AuthStateEditingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthStateEditingCopyWith<$R, $In extends AuthStateEditing, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call({String? username, String? password, bool? showEmail, bool? qrMode});
  AuthStateEditingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthStateEditingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthStateEditing, $Out>
    implements AuthStateEditingCopyWith<$R, AuthStateEditing, $Out> {
  _AuthStateEditingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthStateEditing> $mapper =
      AuthStateEditingMapper.ensureInitialized();
  @override
  $R call(
          {Object? username = $none,
          Object? password = $none,
          bool? showEmail,
          bool? qrMode}) =>
      $apply(FieldCopyWithData({
        if (username != $none) #username: username,
        if (password != $none) #password: password,
        if (showEmail != null) #showEmail: showEmail,
        if (qrMode != null) #qrMode: qrMode
      }));
  @override
  AuthStateEditing $make(CopyWithData data) => AuthStateEditing(
      username: data.get(#username, or: $value.username),
      password: data.get(#password, or: $value.password),
      showEmail: data.get(#showEmail, or: $value.showEmail),
      qrMode: data.get(#qrMode, or: $value.qrMode));

  @override
  AuthStateEditingCopyWith<$R2, AuthStateEditing, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthStateEditingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthStateAuthenticatedMapper
    extends ClassMapperBase<AuthStateAuthenticated> {
  AuthStateAuthenticatedMapper._();

  static AuthStateAuthenticatedMapper? _instance;
  static AuthStateAuthenticatedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateAuthenticatedMapper._());
      AuthStateMapper.ensureInitialized();
      CompanyMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthStateAuthenticated';

  static Company _$company(AuthStateAuthenticated v) => v.company;
  static const Field<AuthStateAuthenticated, Company> _f$company =
      Field('company', _$company);

  @override
  final MappableFields<AuthStateAuthenticated> fields = const {
    #company: _f$company,
  };

  static AuthStateAuthenticated _instantiate(DecodingData data) {
    return AuthStateAuthenticated(company: data.dec(_f$company));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthStateAuthenticated fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthStateAuthenticated>(map);
  }

  static AuthStateAuthenticated fromJson(String json) {
    return ensureInitialized().decodeJson<AuthStateAuthenticated>(json);
  }
}

mixin AuthStateAuthenticatedMappable {
  String toJson() {
    return AuthStateAuthenticatedMapper.ensureInitialized()
        .encodeJson<AuthStateAuthenticated>(this as AuthStateAuthenticated);
  }

  Map<String, dynamic> toMap() {
    return AuthStateAuthenticatedMapper.ensureInitialized()
        .encodeMap<AuthStateAuthenticated>(this as AuthStateAuthenticated);
  }

  AuthStateAuthenticatedCopyWith<AuthStateAuthenticated, AuthStateAuthenticated,
          AuthStateAuthenticated>
      get copyWith => _AuthStateAuthenticatedCopyWithImpl<
              AuthStateAuthenticated, AuthStateAuthenticated>(
          this as AuthStateAuthenticated, $identity, $identity);
  @override
  String toString() {
    return AuthStateAuthenticatedMapper.ensureInitialized()
        .stringifyValue(this as AuthStateAuthenticated);
  }

  @override
  bool operator ==(Object other) {
    return AuthStateAuthenticatedMapper.ensureInitialized()
        .equalsValue(this as AuthStateAuthenticated, other);
  }

  @override
  int get hashCode {
    return AuthStateAuthenticatedMapper.ensureInitialized()
        .hashValue(this as AuthStateAuthenticated);
  }
}

extension AuthStateAuthenticatedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthStateAuthenticated, $Out> {
  AuthStateAuthenticatedCopyWith<$R, AuthStateAuthenticated, $Out>
      get $asAuthStateAuthenticated => $base.as((v, t, t2) =>
          _AuthStateAuthenticatedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthStateAuthenticatedCopyWith<
    $R,
    $In extends AuthStateAuthenticated,
    $Out> implements AuthStateCopyWith<$R, $In, $Out> {
  CompanyCopyWith<$R, Company, Company> get company;
  @override
  $R call({Company? company});
  AuthStateAuthenticatedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthStateAuthenticatedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthStateAuthenticated, $Out>
    implements
        AuthStateAuthenticatedCopyWith<$R, AuthStateAuthenticated, $Out> {
  _AuthStateAuthenticatedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthStateAuthenticated> $mapper =
      AuthStateAuthenticatedMapper.ensureInitialized();
  @override
  CompanyCopyWith<$R, Company, Company> get company =>
      $value.company.copyWith.$chain((v) => call(company: v));
  @override
  $R call({Company? company}) =>
      $apply(FieldCopyWithData({if (company != null) #company: company}));
  @override
  AuthStateAuthenticated $make(CopyWithData data) =>
      AuthStateAuthenticated(company: data.get(#company, or: $value.company));

  @override
  AuthStateAuthenticatedCopyWith<$R2, AuthStateAuthenticated, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _AuthStateAuthenticatedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthStateLoggedOutMapper extends ClassMapperBase<AuthStateLoggedOut> {
  AuthStateLoggedOutMapper._();

  static AuthStateLoggedOutMapper? _instance;
  static AuthStateLoggedOutMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateLoggedOutMapper._());
      AuthStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthStateLoggedOut';

  static bool _$accountIsDeleted(AuthStateLoggedOut v) => v.accountIsDeleted;
  static const Field<AuthStateLoggedOut, bool> _f$accountIsDeleted =
      Field('accountIsDeleted', _$accountIsDeleted);

  @override
  final MappableFields<AuthStateLoggedOut> fields = const {
    #accountIsDeleted: _f$accountIsDeleted,
  };

  static AuthStateLoggedOut _instantiate(DecodingData data) {
    return AuthStateLoggedOut(data.dec(_f$accountIsDeleted));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthStateLoggedOut fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthStateLoggedOut>(map);
  }

  static AuthStateLoggedOut fromJson(String json) {
    return ensureInitialized().decodeJson<AuthStateLoggedOut>(json);
  }
}

mixin AuthStateLoggedOutMappable {
  String toJson() {
    return AuthStateLoggedOutMapper.ensureInitialized()
        .encodeJson<AuthStateLoggedOut>(this as AuthStateLoggedOut);
  }

  Map<String, dynamic> toMap() {
    return AuthStateLoggedOutMapper.ensureInitialized()
        .encodeMap<AuthStateLoggedOut>(this as AuthStateLoggedOut);
  }

  AuthStateLoggedOutCopyWith<AuthStateLoggedOut, AuthStateLoggedOut,
          AuthStateLoggedOut>
      get copyWith => _AuthStateLoggedOutCopyWithImpl<AuthStateLoggedOut,
          AuthStateLoggedOut>(this as AuthStateLoggedOut, $identity, $identity);
  @override
  String toString() {
    return AuthStateLoggedOutMapper.ensureInitialized()
        .stringifyValue(this as AuthStateLoggedOut);
  }

  @override
  bool operator ==(Object other) {
    return AuthStateLoggedOutMapper.ensureInitialized()
        .equalsValue(this as AuthStateLoggedOut, other);
  }

  @override
  int get hashCode {
    return AuthStateLoggedOutMapper.ensureInitialized()
        .hashValue(this as AuthStateLoggedOut);
  }
}

extension AuthStateLoggedOutValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthStateLoggedOut, $Out> {
  AuthStateLoggedOutCopyWith<$R, AuthStateLoggedOut, $Out>
      get $asAuthStateLoggedOut => $base.as(
          (v, t, t2) => _AuthStateLoggedOutCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthStateLoggedOutCopyWith<$R, $In extends AuthStateLoggedOut,
    $Out> implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call({bool? accountIsDeleted});
  AuthStateLoggedOutCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthStateLoggedOutCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthStateLoggedOut, $Out>
    implements AuthStateLoggedOutCopyWith<$R, AuthStateLoggedOut, $Out> {
  _AuthStateLoggedOutCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthStateLoggedOut> $mapper =
      AuthStateLoggedOutMapper.ensureInitialized();
  @override
  $R call({bool? accountIsDeleted}) => $apply(FieldCopyWithData(
      {if (accountIsDeleted != null) #accountIsDeleted: accountIsDeleted}));
  @override
  AuthStateLoggedOut $make(CopyWithData data) => AuthStateLoggedOut(
      data.get(#accountIsDeleted, or: $value.accountIsDeleted));

  @override
  AuthStateLoggedOutCopyWith<$R2, AuthStateLoggedOut, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthStateLoggedOutCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AuthStateErrorMapper extends ClassMapperBase<AuthStateError> {
  AuthStateErrorMapper._();

  static AuthStateErrorMapper? _instance;
  static AuthStateErrorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthStateErrorMapper._());
      AuthStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AuthStateError';

  static String _$message(AuthStateError v) => v.message;
  static const Field<AuthStateError, String> _f$message =
      Field('message', _$message);

  @override
  final MappableFields<AuthStateError> fields = const {
    #message: _f$message,
  };

  static AuthStateError _instantiate(DecodingData data) {
    return AuthStateError(data.dec(_f$message));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthStateError fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthStateError>(map);
  }

  static AuthStateError fromJson(String json) {
    return ensureInitialized().decodeJson<AuthStateError>(json);
  }
}

mixin AuthStateErrorMappable {
  String toJson() {
    return AuthStateErrorMapper.ensureInitialized()
        .encodeJson<AuthStateError>(this as AuthStateError);
  }

  Map<String, dynamic> toMap() {
    return AuthStateErrorMapper.ensureInitialized()
        .encodeMap<AuthStateError>(this as AuthStateError);
  }

  AuthStateErrorCopyWith<AuthStateError, AuthStateError, AuthStateError>
      get copyWith =>
          _AuthStateErrorCopyWithImpl<AuthStateError, AuthStateError>(
              this as AuthStateError, $identity, $identity);
  @override
  String toString() {
    return AuthStateErrorMapper.ensureInitialized()
        .stringifyValue(this as AuthStateError);
  }

  @override
  bool operator ==(Object other) {
    return AuthStateErrorMapper.ensureInitialized()
        .equalsValue(this as AuthStateError, other);
  }

  @override
  int get hashCode {
    return AuthStateErrorMapper.ensureInitialized()
        .hashValue(this as AuthStateError);
  }
}

extension AuthStateErrorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthStateError, $Out> {
  AuthStateErrorCopyWith<$R, AuthStateError, $Out> get $asAuthStateError =>
      $base.as((v, t, t2) => _AuthStateErrorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthStateErrorCopyWith<$R, $In extends AuthStateError, $Out>
    implements AuthStateCopyWith<$R, $In, $Out> {
  @override
  $R call({String? message});
  AuthStateErrorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _AuthStateErrorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthStateError, $Out>
    implements AuthStateErrorCopyWith<$R, AuthStateError, $Out> {
  _AuthStateErrorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthStateError> $mapper =
      AuthStateErrorMapper.ensureInitialized();
  @override
  $R call({String? message}) =>
      $apply(FieldCopyWithData({if (message != null) #message: message}));
  @override
  AuthStateError $make(CopyWithData data) =>
      AuthStateError(data.get(#message, or: $value.message));

  @override
  AuthStateErrorCopyWith<$R2, AuthStateError, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthStateErrorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
