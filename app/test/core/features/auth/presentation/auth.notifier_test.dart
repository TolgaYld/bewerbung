import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/auth/data/repo/auth.repo.impl.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/features/auth/domain/repo/auth.repo.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';
import 'package:pleasehiretolga/core/features/auth/utils/url_launcher_service.dart';
import 'package:pleasehiretolga/core/localization/localizations.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

class MockAuthRepo extends Mock implements AuthRepo {}

class MockUrlLauncherService extends Mock implements UrlLauncherService {}

class FakeL10n extends Fake implements L10n {
  @override
  String get oopsSomethingWentWrongPleaseTryAgain => 'dummy-error-message';
}

class MockRef extends Mock implements Ref {}

void main() {
  late ProviderContainer container;
  late AuthNotifier notifier;
  late AuthRepo authRepo;
  late UrlLauncherService urlLauncherService;

  setUp(() {
    urlLauncherService = MockUrlLauncherService();
    authRepo = MockAuthRepo();
    when(() => authRepo.watchCompany())
        .thenAnswer((_) => Stream.value(const Right(null)));

    container = ProviderContainer(
      overrides: [
        authStateProvider.overrideWith((ref) {
          return AuthNotifier(
            ref: ref,
            urlLauncherService: urlLauncherService,
            AuthStateEditing(username: "", password: ""),
          );
        }),
        authRepoProvider.overrideWithValue(authRepo),
      ],
    );
    notifier = container.read(authStateProvider.notifier);

    notifier.state = const AuthStateEditing(username: "test", password: "test");
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse('blabla@blabla.de'));
  });

  tearDown(() => container.dispose());

  group('updateFields', () {
    test("changes state correctly", () {
      notifier.updateFields(username: "tolga", password: "1234");

      final state = container.read(authStateProvider);
      expect(state, isA<AuthStateEditing>());
      final editing = state as AuthStateEditing;
      expect(editing.username, "tolga");
      expect(editing.password, "1234");
    });
  });

  group('sendMailTo', () {
    test("sets showEmail to true when launch is unsuccessful", () async {
      when(() => urlLauncherService.canLaunch(any()))
          .thenAnswer((_) async => true);
      when(() => urlLauncherService.launch(any()))
          .thenAnswer((_) async => true);

      await notifier.sendMailTo();

      final state = container.read(authStateProvider) as AuthStateEditing;
      expect(state.showEmail, isFalse);
    });

    test("sets showEmail to false when launch is successful", () async {
      when(() => urlLauncherService.canLaunch(any()))
          .thenAnswer((_) async => false);

      await notifier.sendMailTo();

      final state = container.read(authStateProvider) as AuthStateEditing;
      expect(state.showEmail, isTrue);
    });
  });

  group("toggleQrMode", () {
    test("changes qrMode to false", () {
      container.read(authStateProvider.notifier).state = const AuthStateEditing(
        username: "",
        password: "",
        qrMode: true,
      );

      notifier.toggleQrMode();

      final state = container.read(authStateProvider);
      final editing = state as AuthStateEditing;
      expect(editing.qrMode, isFalse);
    });

    test("changes qrMode to true", () {
      container.read(authStateProvider.notifier).state = const AuthStateEditing(
        username: "",
        password: "",
        qrMode: false,
      );

      notifier.toggleQrMode();

      final state = container.read(authStateProvider);
      final editing = state as AuthStateEditing;
      expect(editing.qrMode, isTrue);
    });
  });

  group('login', () {
    final tCompany = Company(
      id: "id",
      name: "tolga company",
    );

    test(
        "should set state to [Loading, Authenticated] when login was successful",
        () async {
      notifier.state =
          const AuthStateEditing(username: "test", password: "test");

      when(
        () => authRepo.signInWithEmailAndPassword(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Right(tCompany));

      await notifier.login(FakeL10n());

      final state = container.read(authStateProvider);
      expect(state, isA<AuthStateAuthenticated>());
      expect((state as AuthStateAuthenticated).company, equals(tCompany));
    });

    test("should set state to [Error] when login was unsuccessful", () async {
      notifier.state =
          const AuthStateEditing(username: "test", password: "test");

      when(
        () => authRepo.signInWithEmailAndPassword(
          username: any(named: 'username'),
          password: any(named: 'password'),
        ),
      ).thenAnswer(
        (_) async => Left(ServerFailure(message: "dummy-error-message")),
      );

      await notifier.login(FakeL10n());

      final state = container.read(authStateProvider);
      expect(state, isA<AuthStateError>());
      expect(
        (state as AuthStateError).message,
        contains("dummy-error-message"),
      );
    });
  });

  group('init', () {
    late MockRef mockRef;
    final tCompany = Company(
      id: "id",
      name: "tolga company",
    );

    setUp(() {
      mockRef = MockRef();
    });

    test(
        "should set the status to [AuthStateAuthenticated] if a company exists",
        () async {
      when(() => mockRef.read(companyProvider.future))
          .thenAnswer((_) async => tCompany);

      final initNotifier = AuthNotifier(
        const AuthStateLoading(),
        ref: mockRef,
        urlLauncherService: urlLauncherService,
      );

      await initNotifier.init();

      expect(initNotifier.state, isA<AuthStateAuthenticated>());
      expect(
        (initNotifier.state as AuthStateAuthenticated).company,
        equals(tCompany),
      );

      verify(() => mockRef.read(companyProvider.future)).called(2);
    });

    test("should set the status to AuthStateEditing if no company exists",
        () async {
      when(() => mockRef.read(companyProvider.future))
          .thenAnswer((_) async => null);

      final initNotifier = AuthNotifier(
        const AuthStateLoading(),
        ref: mockRef,
        urlLauncherService: urlLauncherService,
      );

      await initNotifier.init();

      expect(initNotifier.state, isA<AuthStateEditing>());

      verify(() => mockRef.read(companyProvider.future)).called(2);
    });

    test(
        "should set the status to [AuthStateError] and then to [AuthStateEditing] if an exception occurs",
        () async {
      when(() => mockRef.read(companyProvider.future))
          .thenThrow(Exception('genereller test'));

      final states = <AuthState>[];

      final initNotifier = AuthNotifier(
        const AuthStateLoading(),
        ref: mockRef,
        urlLauncherService: urlLauncherService,
      );

      initNotifier.addListener(states.add);

      await initNotifier.init();
      expect(
        states.length,
        3,
        reason: 'three states should be emitted',
      );

      expect(
        states[1],
        isA<AuthStateError>(),
        reason: 'second state should be AuthStateError',
      );
      expect(
        (states[1] as AuthStateError).message,
        contains('genereller test'),
        reason: 'error message should contain the exception message',
      );

      expect(
        states[2],
        isA<AuthStateEditing>(),
        reason: 'third state should be AuthStateEditing',
      );

      verify(() => mockRef.read(companyProvider.future)).called(2);
    });
  });

  group('signOut', () {
    test(
        'should call authRepo.signOut with correct parameter (deleteAccount=false)',
        () async {
      when(() => authRepo.signOut(any()))
          .thenAnswer((_) async => Future.value(Right(null)));

      await notifier.signOut(false);

      verify(() => authRepo.signOut(false)).called(1);
      final state = container.read(authStateProvider);
      expect(state, isA<AuthStateEditing>());
      expect((state as AuthStateEditing).username, isEmpty);
      expect(state.password, isEmpty);
    });

    test(
        'should call authRepo.signOut with correct parameter (deleteAccount=true)',
        () async {
      when(() => authRepo.signOut(any()))
          .thenAnswer((_) async => Future.value(Right(null)));

      await notifier.signOut(true);

      verify(() => authRepo.signOut(true)).called(1);
      final state = container.read(authStateProvider);
      expect(state, isA<AuthStateEditing>());
      expect((state as AuthStateEditing).username, isEmpty);
      expect(state.password, isEmpty);
    });

    test('should set state to AuthStateError when signOut throws an exception',
        () async {
      final states = <AuthState>[];
      final sub = container.listen<AuthState>(
        authStateProvider,
        (_, next) => states.add(next),
        fireImmediately: false,
      );
      when(() => authRepo.signOut(any())).thenThrow(Exception('signout-error'));

      await notifier.signOut(false);
      sub.close();

      final errorState = states.whereType<AuthStateError>().firstOrNull;
      expect(errorState, isNotNull);
      expect(errorState?.message, contains('signout-error'));
      final finalState = container.read(authStateProvider);
      expect(finalState, isA<AuthStateEditing>());
    });
  });
}
