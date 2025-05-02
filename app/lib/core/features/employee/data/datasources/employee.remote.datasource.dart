import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/employee.model.dart';
import 'package:pleasehiretolga/core/provider/external/firabase.external.dart';

abstract interface class EmployeeRemoteDataSource {
  Stream<EmployeeModel?> watchEmployee();
}

final employeeRemoteDatasourceProvider = Provider<EmployeeRemoteDataSource>(
  (ref) => EmployeeRemoteDataSourceImpl(
    ref.watch(firebaseFirestoreProvider),
  ),
);

class EmployeeRemoteDataSourceImpl implements EmployeeRemoteDataSource {
  EmployeeRemoteDataSourceImpl(this.firestore);

  final FirebaseFirestore firestore;
  @override
  Stream<EmployeeModel?> watchEmployee() {
    try {
      return firestore
          .collection(FirestoreKeys.employee)
          .limit(1)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return EmployeeModel.fromMap(snapshot.docs.first.data());
        } else {
          throw ServerException(
            message: 'No employee found',
            statusCode: '404',
          );
        }
      });
    } on FirebaseException catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
