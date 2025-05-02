import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/auth/data/datasources/auth.remote.datasource.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/features/auth/domain/repo/auth.repo.dart';
import 'package:pleasehiretolga/core/utils/either.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

final authRepoProvider = Provider<AuthRepo>(
  (ref) => AuthRepoImpl(ref.watch(authRemoteDatasourceProvider)),
);

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._authRemoteDatasource);
  final AuthRemoteDatasource _authRemoteDatasource;

  @override
  ResultFuture<void> deleteCompany() async {
    try {
      await _authRemoteDatasource.deleteCompany();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Company> signInWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      final result = await _authRemoteDatasource.signInWithEmailAndPassword(
        username: username,
        password: password,
      );
      return Right(result.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> signOut(bool deleteAccount) async {
    try {
      await _authRemoteDatasource.signOut(deleteAccount);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultStream<Company?> watchCompany() {
    try {
      return _authRemoteDatasource.watchCompany().map((companyModel) {
        return Right(companyModel?.toEntity());
      });
    } on ServerException catch (e) {
      return Stream.value(Left(ServerFailure.fromException(e)));
    }
  }
}
