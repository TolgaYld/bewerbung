import 'package:pleasehiretolga/core/features/employee/domain/entities/employee.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

abstract interface class EmployeeRepo {
  ResultStream<Employee?> watchEmployee();
}
