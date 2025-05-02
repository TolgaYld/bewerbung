import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/employee/data/datasources/employee.remote.datasource.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/employee.model.dart';
import 'package:pleasehiretolga/core/features/employee/data/repo/employee.repo.impl.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/employee.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

class MockEmployeeRemoteDataSource extends Mock
    implements EmployeeRemoteDataSource {}

void main() {
  late EmployeeRemoteDataSource mockEmployeeRemoteDataSource;
  late EmployeeRepoImpl employeeRepo;
  late EmployeeModel tEmployeeModel;

  setUp(() {
    mockEmployeeRemoteDataSource = MockEmployeeRemoteDataSource();
    employeeRepo = EmployeeRepoImpl(mockEmployeeRemoteDataSource);
    tEmployeeModel = EmployeeModel.empty();
  });

  group('watchEmployee', () {
    test(
        'should return stream of [Employee] entity when remote call is successful',
        () async {
      when(() => mockEmployeeRemoteDataSource.watchEmployee())
          .thenAnswer((_) => Stream.value(tEmployeeModel));

      final resultStream = employeeRepo.watchEmployee();

      await expectLater(
        resultStream,
        emits(
          isA<Right<dynamic, Employee?>>()
              .having((right) => right.value, 'value', isA<Employee>()),
        ),
      );
    });

    test('should map DTO to entity correctly', () async {
      when(() => mockEmployeeRemoteDataSource.watchEmployee())
          .thenAnswer((_) => Stream.value(tEmployeeModel));

      final resultStream = employeeRepo.watchEmployee();
      final result = await resultStream.first;

      expect(result, isA<Right<Failure, Employee?>>());
      final employee = (result as Right<Failure, Employee?>).value;
      expect(employee?.person.firstName, tEmployeeModel.person.firstName);
      expect(employee?.person.lastName, tEmployeeModel.person.lastName);
    });

    test('should return null  when remote returns null', () async {
      when(() => mockEmployeeRemoteDataSource.watchEmployee())
          .thenAnswer((_) => Stream.value(null));

      final resultStream = employeeRepo.watchEmployee();

      await expectLater(
        resultStream,
        emits(
          isA<Right<dynamic, Employee?>>().having(
            (right) => right.value,
            'value',
            isNull,
          ),
        ),
      );
    });
  });
}
