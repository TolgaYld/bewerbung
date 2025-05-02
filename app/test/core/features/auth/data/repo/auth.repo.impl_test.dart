import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/errors/exception.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/auth/data/datasources/auth.remote.datasource.dart';
import 'package:pleasehiretolga/core/features/auth/data/models/company.model.dart';
import 'package:pleasehiretolga/core/features/auth/data/repo/auth.repo.impl.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/features/auth/domain/repo/auth.repo.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  late AuthRemoteDatasource authRemoteDatasource;
  late AuthRepo authRepo;

  setUp(() {
    authRemoteDatasource = MockAuthRemoteDatasource();
    authRepo = AuthRepoImpl(authRemoteDatasource);
  });

  group("signInWithEmailAndPassword", () {
    final tCompany = CompanyModel.empty();

    final tServerException = ServerException(
      message: "Server error",
      statusCode: "505",
    );

    test("should return [Company] when call t remote datasrc is successful",
        () async {
      when(
        () => authRemoteDatasource.signInWithEmailAndPassword(
          username: any(named: "username"),
          password: any(named: "password"),
        ),
      ).thenAnswer((_) async => tCompany);

      final result = await authRepo.signInWithEmailAndPassword(
        username: tCompany.name,
        password: "testPw",
      );

      expect(
        result,
        isA<Right<Failure, Company>>().having(
          (r) => r.value,
          'value',
          equals(tCompany.toEntity()),
        ),
      );
      verify(
        () => authRemoteDatasource.signInWithEmailAndPassword(
          username: tCompany.name,
          password: "testPw",
        ),
      ).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });

    test(
        "should return [ServerFailure] when call t remote datasrc is unsuccessful",
        () async {
      when(
        () => authRemoteDatasource.signInWithEmailAndPassword(
          username: any(named: "username"),
          password: any(named: "password"),
        ),
      ).thenThrow(tServerException);

      final result = await authRepo.signInWithEmailAndPassword(
        username: tCompany.name,
        password: "testPw",
      );

      expect(
        result,
        isA<Left<Failure, Company>>().having(
          (l) => l.failure,
          'failure',
          equals(ServerFailure.fromException(tServerException)),
        ),
      );
      verify(
        () => authRemoteDatasource.signInWithEmailAndPassword(
          username: tCompany.name,
          password: "testPw",
        ),
      ).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });
  });

  group("signOut", () {
    final tServerException = ServerException(
      message: "Server error",
      statusCode: "505",
    );

    test("should call datasource with deleteAccount == false", () async {
      when(() => authRemoteDatasource.signOut(false))
          .thenAnswer((_) async => Future.value());

      final result = await authRepo.signOut(false);

      expect(result, const Right<Failure, void>(null));
      verify(() => authRemoteDatasource.signOut(false)).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });

    test("should call datasource with deleteAccount = true", () async {
      when(() => authRemoteDatasource.signOut(true))
          .thenAnswer((_) async => Future.value());

      final result = await authRepo.signOut(true);

      expect(result, const Right<Failure, void>(null));
      verify(() => authRemoteDatasource.signOut(true)).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });

    test("should return [ServerFailure] when ServerException is thrown",
        () async {
      when(() => authRemoteDatasource.signOut(any()))
          .thenThrow(tServerException);

      final result = await authRepo.signOut(true);

      expect(
        result,
        isA<Left<Failure, void>>().having(
          (l) => l.failure,
          'failure',
          equals(ServerFailure.fromException(tServerException)),
        ),
      );

      verify(() => authRemoteDatasource.signOut(true)).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });
  });

  group("deleteCompany", () {
    final tServerException = ServerException(
      message: 'Delete failed',
      statusCode: '500',
    );
    test("should call datasource successfully", () async {
      when(() => authRemoteDatasource.deleteCompany())
          .thenAnswer((_) async => Future.value());

      final result = await authRepo.deleteCompany();

      expect(result, const Right<Failure, void>(null));
      verify(() => authRemoteDatasource.deleteCompany()).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });

    test("should return [ServerFailure] when ServerException is thrown",
        () async {
      when(() => authRemoteDatasource.deleteCompany())
          .thenThrow(tServerException);

      final result = await authRepo.deleteCompany();

      expect(
        result,
        isA<Left<Failure, void>>().having(
          (l) => l.failure,
          'failure',
          equals(ServerFailure.fromException(tServerException)),
        ),
      );

      verify(() => authRemoteDatasource.deleteCompany()).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });
  });

  group("watchCompany", () {
    test("should return stream of [Company] when datasource succeeds",
        () async {
      final tCompany = CompanyModel.empty();

      when(() => authRemoteDatasource.watchCompany())
          .thenAnswer((_) => Stream.value(tCompany));

      final resultStream = authRepo.watchCompany();

      await expectLater(
        resultStream,
        emits(
          isA<Right<Failure, Company?>>().having(
            (r) => r.value,
            'value',
            equals(tCompany.toEntity()),
          ),
        ),
      );
      verify(() => authRemoteDatasource.watchCompany()).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });

    test("should return stream of [Right] when datasource returns null",
        () async {
      when(() => authRemoteDatasource.watchCompany())
          .thenAnswer((_) => Stream.value(null));

      final resultStream = authRepo.watchCompany();

      await expectLater(
        resultStream,
        emits(
          isA<Right<Failure, Company?>>().having(
            (r) => r.value,
            'value',
            isNull,
          ),
        ),
      );

      verify(() => authRemoteDatasource.watchCompany()).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });

    test("should return stream of [Failure] when datasource throws", () async {
      final tServerException = ServerException(
        message: "Stream error",
        statusCode: "505",
      );

      when(() => authRemoteDatasource.watchCompany())
          .thenThrow(tServerException);

      final resultStream = authRepo.watchCompany();

      await expectLater(
        resultStream,
        emits(
          isA<Left<Failure, Company?>>().having(
            (l) => l.failure,
            'failure',
            equals(ServerFailure.fromException(tServerException)),
          ),
        ),
      );

      verify(() => authRemoteDatasource.watchCompany()).called(1);
      verifyNoMoreInteractions(authRemoteDatasource);
    });
  });
}
