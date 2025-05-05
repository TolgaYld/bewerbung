import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/model/privacy_policy.model.dart';
import 'package:pleasehiretolga/core/provider/external/firabase.external.dart';

abstract interface class PrivacyPolicyRemoteDatasource {
  Stream<PrivacyPolicyModel?> watchPrivacyPolicy();
}

final privacyPolicyRemoteDatasourceProvider =
    Provider<PrivacyPolicyRemoteDatasource>((ref) {
  return PrivacyPolicyRemoteDatasourceImpl(
    ref.watch(firebaseFirestoreProvider),
  );
});

class PrivacyPolicyRemoteDatasourceImpl
    implements PrivacyPolicyRemoteDatasource {
  const PrivacyPolicyRemoteDatasourceImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<PrivacyPolicyModel?> watchPrivacyPolicy() {
    try {
      return _firestore
          .collection(FirestoreKeys.privacyPolicy)
          .limit(1)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return PrivacyPolicyModel.fromMap(snapshot.docs.first.data());
        } else {
          throw ServerException(
            message: 'No privacy found',
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
