import 'package:dart_mappable/dart_mappable.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';

part 'auth.state.mapper.dart';

@MappableClass()
sealed class AuthState with AuthStateMappable {
  const AuthState();
}

@MappableClass()
class AuthStateLoading extends AuthState with AuthStateLoadingMappable {
  const AuthStateLoading({this.showLoadingPage = true});

  final bool showLoadingPage;
}

@MappableClass()
class AuthStateEditing extends AuthState with AuthStateEditingMappable {
  const AuthStateEditing({
    this.username,
    this.password,
    this.showEmail = false,
    this.qrMode = true,
  });

  final String? username;
  final String? password;
  final bool showEmail;
  final bool qrMode;
}

@MappableClass()
class AuthStateAuthenticated extends AuthState
    with AuthStateAuthenticatedMappable {
  const AuthStateAuthenticated({
    required this.company,
  });

  final Company company;
}

@MappableClass()
class AuthStateLoggedOut extends AuthState with AuthStateLoggedOutMappable {
  const AuthStateLoggedOut(
    this.accountIsDeleted,
  );

  final bool accountIsDeleted;
}

@MappableClass()
class AuthStateError extends AuthState with AuthStateErrorMappable {
  const AuthStateError(this.message);

  final String message;
}
