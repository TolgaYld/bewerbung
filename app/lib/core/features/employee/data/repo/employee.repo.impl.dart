import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/employee/data/datasources/employee.remote.datasource.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/employee.dart';
import 'package:pleasehiretolga/core/features/employee/domain/repo/employee.repo.dart';
import 'package:pleasehiretolga/core/utils/either.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

final employeeRepoProvider = Provider<EmployeeRepo>(
  (ref) => EmployeeRepoImpl(ref.watch(employeeRemoteDatasourceProvider)),
);

class EmployeeRepoImpl implements EmployeeRepo {
  const EmployeeRepoImpl(this._employeeRemoteDataSource);

  final EmployeeRemoteDataSource _employeeRemoteDataSource;
  @override
  ResultStream<Employee?> watchEmployee() {
    try {
      return _employeeRemoteDataSource.watchEmployee().map((employeeModel) {
        return Right(employeeModel?.toEntity());
      });
    } on ServerException catch (e) {
      return Stream.value(Left(ServerFailure.fromException(e)));
    }
  }
}
