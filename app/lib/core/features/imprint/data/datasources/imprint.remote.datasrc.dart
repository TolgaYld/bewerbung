import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/features/imprint/data/model/imprint.model.dart';
import 'package:pleasehiretolga/core/provider/external/firabase.external.dart';

abstract interface class ImprintRemoteDatasource {
  Stream<ImprintModel?> watchImprint();
}

final imprintRemoteDatasourceProvider = Provider(
  (ref) => ImprintRemoteDatasourceImpl(ref.watch(firebaseFirestoreProvider)),
);

class ImprintRemoteDatasourceImpl implements ImprintRemoteDatasource {
  const ImprintRemoteDatasourceImpl(this._firestore);

  final FirebaseFirestore _firestore;
  @override
  Stream<ImprintModel?> watchImprint() {
    try {
      return _firestore
          .collection(FirestoreKeys.imprint)
          .limit(1)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          return ImprintModel.fromMap(snapshot.docs.first.data());
        } else {
          throw ServerException(
            message: 'No imprint found',
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
