import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

abstract interface class AuthRepo {
  ResultFuture<Company> signInWithEmailAndPassword({
    required String username,
    required String password,
  });
  ResultFuture<void> signOut(bool deleteAccount);
  ResultFuture<void> deleteCompany();
  ResultStream<Company?> watchCompany();
}
