import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/auth/data/models/company.model.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/provider/external/firabase.external.dart';

abstract interface class AuthRemoteDatasource {
  Future<CompanyModel> signInWithEmailAndPassword({
    required String username,
    required String password,
  });
  Future<void> signOut(bool deleteAccount);
  Future<void> deleteCompany();
  Stream<CompanyModel?> watchCompany();
}

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>(
  (ref) => AuthRemoteDatasourceImpl(
    firebaseAuthClient: ref.watch(firebaseAuthProvider),
    cloudStoreClient: ref.watch(firebaseFirestoreProvider),
  ),
);

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl({
    required FirebaseAuth firebaseAuthClient,
    required FirebaseFirestore cloudStoreClient,
  })  : _firebaseAuthClient = firebaseAuthClient,
        _cloudStoreClient = cloudStoreClient;

  final FirebaseAuth _firebaseAuthClient;
  final FirebaseFirestore _cloudStoreClient;

  @override
  Future<CompanyModel> signInWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      final email = '${username.trim().toLowerCase()}@ty-software.dev';
      final result = await _firebaseAuthClient.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final company = result.user;

      if (company == null) {
        throw ServerException(
          message: 'Please try again later',
          statusCode: "Unknown",
        );
      }
      final companyData = await _cloudStoreClient
          .collection(FirestoreKeys.companies)
          .doc(company.uid)
          .get();

      if (companyData.data() case final data?) {
        return CompanyModel.fromMap(data);
      } else {
        throw ServerException(
          message: 'Company not found',
          statusCode: "Unknown",
        );
      }
    } on FirebaseAuthException catch (e, s) {
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

  @override
  Future<void> signOut(bool deleteAccount) async {
    try {
      if (deleteAccount) {
        await deleteCompany();
      } else {
        await _firebaseAuthClient.signOut();
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(
        message: e.message ?? 'Error Occurred',
        statusCode: e.code,
      );
    }
  }

  @override
  Future<void> deleteCompany() async {
    try {
      final companyId = _firebaseAuthClient.currentUser?.uid;
      if (companyId == null) {
        throw ServerException(
          message: 'Company ID not found',
          statusCode: 'Unknown',
        );
      }
      await _cloudStoreClient
          .collection(FirestoreKeys.companies)
          .doc(companyId)
          .delete();
      await _firebaseAuthClient.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
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

  @override
  Stream<CompanyModel?> watchCompany() {
    try {
      final company = _firebaseAuthClient.currentUser;
      if (company == null) {
        return Stream.value(null);
      }

      return _cloudStoreClient
          .collection(FirestoreKeys.companies)
          .doc(company.uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.data() case final data?) {
          return CompanyModel.fromMap(data);
        } else {
          return null;
        }
      });
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      throw ServerException(
        message: e.toString(),
        statusCode: '505',
      );
    }
  }
}
