import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/constants/firestore_keys.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/features/auth/data/datasources/auth.remote.datasource.dart';
import 'package:pleasehiretolga/core/features/auth/data/models/company.model.dart';

class MockUserMocktail extends Mock implements User {}

class MockFirebaseAuthMocktail extends Mock implements FirebaseAuth {}

void main() {
  late FakeFirebaseFirestore firestoreClient;
  late MockFirebaseAuth firebaseAuthClient;
  late AuthRemoteDatasource authRemoteDatasource;

  setUp(() async {
    final mockUser = MockUser(
      isAnonymous: false,
      uid: CompanyModel.empty().id,
      email: 'aaa@aa.de',
    );
    firebaseAuthClient = MockFirebaseAuth(mockUser: mockUser);

    firestoreClient = FakeFirebaseFirestore();

    authRemoteDatasource = AuthRemoteDatasourceImpl(
      cloudStoreClient: firestoreClient,
      firebaseAuthClient: firebaseAuthClient,
    );
  });
  setUpAll(() {
    registerFallbackValue(MockUserMocktail());
  });

  const tUsername = 'testUsername';
  const tPassword = 'testPassword';
  final tCompanyModel = CompanyModel.empty();

  group("signUpWithEmailAndPassword", () {
    test("signUp is successfull", () async {
      await firestoreClient
          .collection(FirestoreKeys.companies)
          .doc(tCompanyModel.id)
          .set(tCompanyModel.toMap());

      await authRemoteDatasource.signInWithEmailAndPassword(
        username: tUsername,
        password: tPassword,
      );

      expect(firebaseAuthClient.currentUser, isNotNull);

      final tUser = await firestoreClient
          .collection(FirestoreKeys.companies)
          .doc(firebaseAuthClient.currentUser?.uid)
          .get();

      expect(tUser.exists, isTrue);
    });

    test("signUp is not successfull", () async {
      expect(
        () => authRemoteDatasource.signInWithEmailAndPassword(
          username: tUsername,
          password: tPassword,
        ),
        throwsA(isA<ServerException>()),
      );
    });
  });
  group("signOut", () {
    test("signs out without error", () async {
      expect(() => authRemoteDatasource.signOut(false), returnsNormally);
    });

    test("deletes account if deleteAccount is true", () async {
      final mockAuth = MockFirebaseAuthMocktail();
      final mockUser = MockUserMocktail();

      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('blabla');
      when(mockUser.delete).thenAnswer((_) async {});

      authRemoteDatasource = AuthRemoteDatasourceImpl(
        firebaseAuthClient: mockAuth,
        cloudStoreClient: firestoreClient,
      );

      await firestoreClient
          .collection(FirestoreKeys.companies)
          .doc('blabla')
          .set(tCompanyModel.toMap());

      expect(() => authRemoteDatasource.signOut(true), returnsNormally);
    });

    test("throws [ServerException] if delete fails", () async {
      final mockAuth = MockFirebaseAuthMocktail();
      final mockUser = MockUserMocktail();

      when(() => mockAuth.currentUser).thenReturn(mockUser);

      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('test-company-id');
      when(mockUser.delete).thenThrow(
        FirebaseAuthException(
          code: 'permission-denied',
          message: 'not allowed.',
        ),
      );

      authRemoteDatasource = AuthRemoteDatasourceImpl(
        firebaseAuthClient: mockAuth,
        cloudStoreClient: firestoreClient,
      );

      expect(
        () => authRemoteDatasource.signOut(true),
        throwsA(
          isA<ServerException>().having(
            (e) => e.statusCode,
            'statusCode',
            'permission-denied',
          ),
        ),
      );
    });
  });

  group("deleteCompany", () {
    test("deleteCompany  is successfull", () async {
      final companyId = tCompanyModel.id;
      const tEmail = 'asdfdd@fsf.de';

      await firestoreClient
          .collection(FirestoreKeys.companies)
          .doc(companyId)
          .set(tCompanyModel.toMap());

      final mockUser = MockUser(
        uid: companyId,
        email: 'aaa@aa.de',
      );

      firebaseAuthClient = MockFirebaseAuth(mockUser: mockUser);

      await firebaseAuthClient.signInWithCredential(
        EmailAuthProvider.credential(
          email: tEmail,
          password: 'any',
        ),
      );

      authRemoteDatasource = AuthRemoteDatasourceImpl(
        cloudStoreClient: firestoreClient,
        firebaseAuthClient: firebaseAuthClient,
      );

      await authRemoteDatasource.deleteCompany();

      final deletedDoc = await firestoreClient
          .collection(FirestoreKeys.companies)
          .doc(companyId)
          .get();

      expect(deletedDoc.exists, isFalse);
    });

    test("throws [ServerException] if company is null", () async {
      final mockAuth = MockFirebaseAuthMocktail();

      when(() => mockAuth.currentUser).thenReturn(null);

      authRemoteDatasource = AuthRemoteDatasourceImpl(
        firebaseAuthClient: mockAuth,
        cloudStoreClient: firestoreClient,
      );

      expect(
        () => authRemoteDatasource.deleteCompany(),
        throwsA(
          isA<ServerException>().having(
            (e) => e.message,
            'message',
            contains('Company ID not found'),
          ),
        ),
      );
    });
  });

  group("watchCompany", () {
    late MockUser mockUser;

    setUp(() {
      mockUser = MockUser(
        uid: CompanyModel.empty().id,
        email: 'blabla@blabla.de',
      );
      firebaseAuthClient = MockFirebaseAuth(mockUser: mockUser);
      authRemoteDatasource = AuthRemoteDatasourceImpl(
        firebaseAuthClient: firebaseAuthClient,
        cloudStoreClient: firestoreClient,
      );
    });

    test("should return [null] when no user is signed in", () async {
      final mockAuthNone = MockFirebaseAuthMocktail();
      when(() => mockAuthNone.currentUser).thenReturn(null);
      authRemoteDatasource = AuthRemoteDatasourceImpl(
        firebaseAuthClient: mockAuthNone,
        cloudStoreClient: firestoreClient,
      );

      final values = await authRemoteDatasource.watchCompany().take(1).toList();
      expect(values, [null]);
    });

    test(
      "should emit a [CompanyModel] when the document exists",
      () async {
        final mockAuth = MockFirebaseAuthMocktail();
        final mockUser = MockUserMocktail();

        when(() => mockUser.uid).thenReturn(tCompanyModel.id);
        when(() => mockAuth.currentUser).thenReturn(mockUser);

        final testDatasource = AuthRemoteDatasourceImpl(
          cloudStoreClient: firestoreClient,
          firebaseAuthClient: mockAuth,
        );

        await firestoreClient
            .collection(FirestoreKeys.companies)
            .doc(tCompanyModel.id)
            .set(tCompanyModel.toMap());

        await expectLater(
          testDatasource.watchCompany(),
          emits(isA<CompanyModel>()),
        );
      },
    );

    test("should emit [null] when the document is deleted", () async {
      await firestoreClient
          .collection(FirestoreKeys.companies)
          .doc(mockUser.uid)
          .set(CompanyModel.empty().toMap());

      final values = <CompanyModel?>[];
      final sub = authRemoteDatasource.watchCompany().listen(values.add);

      await firestoreClient
          .collection(FirestoreKeys.companies)
          .doc(mockUser.uid)
          .delete();

      expect(values, [null]);
      await sub.cancel();
    });
  });
}
