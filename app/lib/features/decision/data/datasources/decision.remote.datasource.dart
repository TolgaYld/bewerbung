import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/provider/external/firabase.external.dart';
import 'package:pleasehiretolga/features/decision/data/models/decision_update.model.dart';

abstract interface class DecisionRemoteDataSource {
  Future<void> updateDecision(DecisionUpdateModel decisionUpdateModel);
  Future<void> revertDecision(String employeeId);
}

final decisionRemoteDatasourceProvider =
    Provider<DecisionRemoteDataSource>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return DecisionRemoteDataSourceImpl(firestore);
});

class DecisionRemoteDataSourceImpl implements DecisionRemoteDataSource {
  DecisionRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<void> updateDecision(DecisionUpdateModel decisionUpdateModel) async {
    try {
      final companyRef = _firestore
          .collection(FirestoreKeys.companies)
          .doc(decisionUpdateModel.id);
      final companySnapshot = await companyRef.get();

      if (companySnapshot.exists == false) {
        throw ServerException(
          message: 'Company not found',
          statusCode: "404",
        );
      }

      final updatedData = <String, dynamic>{
        'decisionStatus': decisionUpdateModel.decisionStatus?.name,
        'decisionMessage': decisionUpdateModel.decisionMessage,
        'inviteDate': decisionUpdateModel.inviteDate,
        'inviteDurationInMinutes': decisionUpdateModel.inviteDurationInMinutes,
      };

      await companyRef.update(updatedData);
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'An error occurred',
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

  @override
  Future<void> revertDecision(String employeeId) async {
    try {
      final companyRef =
          _firestore.collection(FirestoreKeys.companies).doc(employeeId);

      final companySnapshot = await companyRef.get();

      if (companySnapshot.exists == false) {
        throw ServerException(
          message: 'Company not found',
          statusCode: "404",
        );
      }

      final updatedData = <String, dynamic>{
        'decisionStatus': DecisionStatus.pending.name,
        'decisionMessage': null,
        'inviteDate': null,
        'inviteDurationInMinutes': null,
        'employeeAcceptedInvite': null,
        'messageFromEmployee': null,
      };

      await companyRef.update(updatedData);
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'An error occurred',
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
