import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.page.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/features/imprint/presentation/imprint.page.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/presentation/privacy_policy.page.dart';
import 'package:pleasehiretolga/core/features/qr/presentation/qr_scanner.page.dart';
import 'package:pleasehiretolga/core/features/settings/presentation/settings.page.dart';
import 'package:pleasehiretolga/core/presentation/loading_page.dart';
import 'package:pleasehiretolga/features/cover_letter/presentation/conver_letter.page.dart';
import 'package:pleasehiretolga/features/cv/presentation/cv.page.dart';
import 'package:pleasehiretolga/features/decision/presentation/decision.page.dart';
import 'package:pleasehiretolga/features/about_me/presentation/about_me.page.dart';
import 'package:pleasehiretolga/presentation/home.page.dart';

enum RoutePath {
  auth(path: '/auth'),
  home(path: '/home'),
  qrPage(path: 'qr-scan'),
  aboutMe(path: '/aboutMe'),
  cv(path: '/cv'),
  coverLetter(path: '/coverLetter'),
  decission(path: '/decission'),
  settings(path: '/settings'),
  imprint(path: '/imprint'),
  privacyPolicy(path: '/privacy-policy'),
  loading(path: '/loading');

  const RoutePath({required this.path});
  final String path;
}

final navigationManagerProvider = Provider<GoRouter>((ref) {
  final routerNotifier = RouterNotifier(ref);
  return GoRouter(
    initialLocation: RoutePath.auth.path,
    debugLogDiagnostics: kReleaseMode == false,
    refreshListenable: routerNotifier,
    routes: routerNotifier._routes,
    redirect: routerNotifier._redirect,
  );
});

class RouterNotifier extends ChangeNotifier {
  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (previous != next) notifyListeners();
    });
  }

  final Ref _ref;

  FutureOr<String?> _redirect(BuildContext context, GoRouterState state) {
    final authState = _ref.read(authStateProvider);
    final isAuthenticated = authState is AuthStateAuthenticated;
    final isInAuthFlow = state.matchedLocation.startsWith(RoutePath.auth.path);
    final isOnLoadingPage = state.matchedLocation == RoutePath.loading.path;

    final publicPaths = [
      RoutePath.imprint.path,
      RoutePath.privacyPolicy.path,
    ];
    final isPublicPath =
        publicPaths.any((path) => state.matchedLocation.startsWith(path));

    if (authState is AuthStateLoading && authState.showLoadingPage == true) {
      if (isOnLoadingPage == false) {
        return RoutePath.loading.path;
      }
      return null;
    }

    if (isAuthenticated && isOnLoadingPage) {
      return RoutePath.aboutMe.path;
    }

    if (isAuthenticated == false &&
        isInAuthFlow == false &&
        isPublicPath == false &&
        isOnLoadingPage == false) {
      return RoutePath.auth.path;
    }

    if (isAuthenticated && isInAuthFlow) {
      return RoutePath.aboutMe.path;
    }

    return null;
  }

  List<RouteBase> get _routes => [
        GoRoute(
          path: RoutePath.auth.path,
          name: RoutePath.auth.name,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: AuthPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
          routes: [
            GoRoute(
              path: 'qr-scan',
              name: RoutePath.qrPage.name,
              pageBuilder: (context, state) => CustomTransitionPage(
                child: const QrScannerPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              ),
            ),
          ],
        ),
        GoRoute(
          path: RoutePath.loading.path,
          name: RoutePath.loading.name,
          builder: (context, state) => LoadingPage(),
        ),
        GoRoute(
          path: RoutePath.imprint.path,
          name: RoutePath.imprint.name,
          builder: (context, state) => ImprintPage(),
        ),
        GoRoute(
          path: RoutePath.privacyPolicy.path,
          name: RoutePath.privacyPolicy.name,
          builder: (context, state) => PrivacyPolicyPage(),
        ),
        GoRoute(
          path: RoutePath.settings.path,
          name: RoutePath.settings.name,
          builder: (context, state) => SettingsPage(),
        ),
        StatefulShellRoute.indexedStack(
          pageBuilder: (context, state, shell) => CustomTransitionPage(
            child: HomePage(
              navigationShell: shell,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
          ),
          branches: [
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePath.aboutMe.path,
                  name: RoutePath.aboutMe.name,
                  builder: (context, state) => const AboutMePage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePath.cv.path,
                  name: RoutePath.cv.name,
                  builder: (context, state) => const CvPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePath.coverLetter.path,
                  name: RoutePath.coverLetter.name,
                  builder: (context, state) => const CoverLetterPage(),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: <RouteBase>[
                GoRoute(
                  path: RoutePath.decission.path,
                  name: RoutePath.decission.name,
                  builder: (context, state) => const DecisionPage(),
                ),
              ],
            ),
          ],
        ),
      ];
}
