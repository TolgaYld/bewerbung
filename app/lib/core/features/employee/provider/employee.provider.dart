import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/employee/data/repo/employee.repo.impl.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/disability.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/employee.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/person.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

final employeeProvider = StreamProvider<Employee?>(
  (ref) {
    return ref.watch(employeeRepoProvider).watchEmployee().map((employee) {
      if (employee case Right(:final value)) {
        return value;
      } else {
        return null;
      }
    });
  },
);

final disabilityProvider = StreamProvider<Disability?>(
  (ref) {
    final employee = ref.watch(employeeProvider).valueOrNull;
    final disabilityValue = switch (employee) {
      Employee(person: Person(:final disability?)) => disability,
      _ => null,
    };
    return Stream.value(disabilityValue);
  },
);
