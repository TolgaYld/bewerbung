import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/features/employee/data/datasources/employee.remote.datasource.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/employee.model.dart';

void main() {
  late FakeFirebaseFirestore firestoreClient;
  late EmployeeRemoteDataSource employeeRemoteDataSource;
  late EmployeeModel tEmployeeModel;

  setUp(() {
    firestoreClient = FakeFirebaseFirestore();
    employeeRemoteDataSource = EmployeeRemoteDataSourceImpl(firestoreClient);
    tEmployeeModel = EmployeeModel.empty();
  });

  group('watchEmployee', () {
    test(
        'should return a Stream with an [EmployeeModel] when a document exists',
        () async {
      await firestoreClient
          .collection(FirestoreKeys.employee)
          .doc(tEmployeeModel.id)
          .set(tEmployeeModel.toMap());

      await expectLater(
        employeeRemoteDataSource.watchEmployee(),
        emits(isA<EmployeeModel>()),
      );
    });

    test('should throw a [ServerException] when no employee is found',
        () async {
      expect(
        () => employeeRemoteDataSource.watchEmployee().first,
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            'No employee found',
          ),
        ),
      );
    });

    test('should return the correct EmployeeModel', () async {
      await firestoreClient
          .collection(FirestoreKeys.employee)
          .doc(tEmployeeModel.id)
          .set(tEmployeeModel.toMap());

      final result = await employeeRemoteDataSource.watchEmployee().first;

      expect(result?.id, equals(tEmployeeModel.id));
      expect(result?.person.firstName, equals(tEmployeeModel.person.firstName));
      expect(result?.aboutMe, equals(tEmployeeModel.aboutMe));
    });

    test('should return the first document when multiple documents exist',
        () async {
      final secondEmployee = EmployeeModel(
        id: 'Kennys_id',
        aboutMe: {},
        cv: tEmployeeModel.cv,
        person: tEmployeeModel.person,
        jobTitle: tEmployeeModel.jobTitle,
        generalSkills: tEmployeeModel.generalSkills,
        programmingLanguages: tEmployeeModel.programmingLanguages,
        languages: tEmployeeModel.languages,
      );

      await firestoreClient
          .collection(FirestoreKeys.employee)
          .doc(tEmployeeModel.id)
          .set(tEmployeeModel.toMap());

      await firestoreClient
          .collection(FirestoreKeys.employee)
          .doc(secondEmployee.id)
          .set(secondEmployee.toMap());

      final result = await employeeRemoteDataSource.watchEmployee().first;

      expect(
        [
          tEmployeeModel.id,
          secondEmployee.id,
        ].contains(result?.id),
        isTrue,
      );
    });
  });
}
