import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/auth/data/repo/auth.repo.impl.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';
import 'package:pleasehiretolga/core/features/auth/utils/url_launcher_service.dart';
import 'package:pleasehiretolga/core/localization/localizations.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref: ref,
    urlLauncherService: ref.watch(urlLauncherServiceProvider),
    AuthStateLoading(),
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(
    super.state, {
    required this.ref,
    required this.urlLauncherService,
  }) {
    init();
  }

  final Ref ref;
  final UrlLauncherService urlLauncherService;

  Future<void> init() async {
    try {
      final company = await ref.read(companyProvider.future);
      if (company != null) {
        state = AuthStateAuthenticated(company: company);
      } else {
        state = const AuthStateEditing(
          username: '',
          password: '',
        );
      }
    } catch (e) {
      state = AuthStateError(e.toString());
      state = const AuthStateEditing(
        username: '',
        password: '',
      );
    }
  }

  void updateFields({
    required String username,
    required String password,
  }) {
    if (state case AuthStateEditing(:final copyWith)) {
      state = copyWith(username: username, password: password);
    }
  }

  Future<void> sendMailTo() async {
    if (state case AuthStateEditing(:final copyWith)) {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: "tolga@ty-software.dev",
        query: encodeQueryParameters(<String, String>{
          'subject': 'Need Help',
        }),
      );

      try {
        final canLaunch = await urlLauncherService.canLaunch(emailLaunchUri);
        if (canLaunch == false) throw Exception("Cannot launch URL");

        await urlLauncherService.launch(emailLaunchUri);

        state = copyWith(showEmail: false);
      } catch (_) {
        state = copyWith(showEmail: true);
      }
    }
  }

  String? encodeQueryParameters(Map<String, String> params) => params.entries
      .map(
        (MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
      )
      .join('&');

  void toggleQrMode() {
    if (state case AuthStateEditing(:final qrMode, :final copyWith)) {
      state = copyWith(qrMode: !qrMode);
    }
  }

  Future<void> signOut(bool deleteAccount) async {
    try {
      final authRepo = ref.read(authRepoProvider);
      await authRepo.signOut(deleteAccount);
      state = const AuthStateEditing(
        username: '',
        password: '',
      );
    } catch (e) {
      state = AuthStateError(e.toString());
    }
    ref.invalidate(companyProvider);
  }

  Future<void> login(L10n l10n) async {
    if (state
        case AuthStateEditing(
          :final username?,
          :final password?,
        )) {
      state = const AuthStateLoading();
      try {
        final authRepo = ref.read(authRepoProvider);
        final result = await authRepo.signInWithEmailAndPassword(
          username: username,
          password: password,
        );
        state = switch (result) {
          Right(:final value) => AuthStateAuthenticated(company: value),
          Left(:final failure) => AuthStateError(failure.message),
        };
        ref.invalidate(companyProvider);
      } on Exception {
        state = AuthStateError(l10n.oopsSomethingWentWrongPleaseTryAgain);
      }
    }
  }
}
