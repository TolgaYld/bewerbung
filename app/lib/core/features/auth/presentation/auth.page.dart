import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/widgets/login_mode.widget.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_responsive.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/loading_page.dart';
import 'package:pleasehiretolga/core/presentation/widgets/footer.widget.dart';
import 'package:pleasehiretolga/core/presentation/widgets/language_switcher.widget.dart';
import 'package:pleasehiretolga/core/utils/presentation/responsive.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final textTheme = useTextTheme();
    final state = ref.watch(authStateProvider);
    final notifier = ref.read(authStateProvider.notifier);
    final responsive = useResponsive();
    final width = MediaQuery.sizeOf(context).width;

    ref.listen(authStateProvider, (prev, next) {
      if (next is AuthStateError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AutoSizeText(next.message),
            backgroundColor: theme.colorScheme.error,
          ),
        );
      }
    });
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: switch (state) {
        AuthStateEditing() || AuthStateError() => Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: AutoSizeText(l10n.welcomeToPleaseHireTolga),
              centerTitle: responsive.isDesktop ? true : false,
              actions: [
                LanguageSwitcher(),
                const HSpace.xs(),
              ],
            ),
            body: Stack(
              children: [
                Positioned.fill(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: Spacers.s,
                      right: Spacers.s,
                      bottom: Spacers.xl,
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const VSpace.x4l(),
                          AutoSizeText(
                            switch (state) {
                              AuthStateEditing(qrMode: true)
                                  when responsive.isDesktop == false =>
                                l10n.tapOnScanQrCodeToLogin,
                              _ => l10n.enterYourLoginInformation,
                            },
                            style: textTheme.titleMedium,
                            textAlign: TextAlign.center,
                          ),
                          if (state case AuthStateEditing(qrMode: true)
                              when responsive.isDesktop == false) ...[
                            AutoSizeText(
                              l10n.youWillBeAutomaticallyLoggedIn,
                              style: textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.surface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const VSpace.xl(),
                          ] else
                            const VSpace.x2l(),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: width > 600 ? 600 : width,
                            ),
                            child: LoginSwitchWidget(
                              state: state,
                              notifier: notifier,
                            ),
                          ),
                          const VSpace.xl(),
                          ResponsiveWidget(
                            mobile: Column(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(
                                    text: switch (state) {
                                      AuthStateEditing(qrMode: true) =>
                                        '${l10n.dontWantLoginViaQrCode} ',
                                      _ => '${l10n.wantToLoginViaQrCode} ',
                                    },
                                    style: textTheme.bodyLarge,
                                    children: [
                                      TextSpan(
                                        text: l10n.clickHere,
                                        style: textTheme.bodyLarge?.copyWith(
                                          color: theme.colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = notifier.toggleQrMode,
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const VSpace.xl(),
                              ],
                            ),
                            tablet: null,
                            desktop: const SizedBox.shrink(),
                          ),
                          AutoSizeText.rich(
                            TextSpan(
                              text: '${l10n.youNeedHelp} ',
                              style: textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: l10n.clickHere,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async => notifier.sendMailTo(),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          switch (state) {
                            AuthStateEditing(showEmail: true) => AutoSizeText(
                                'tolga@ty-software.dev',
                                style: textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.surface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            _ => const SizedBox.shrink(),
                          },
                        ],
                      ),
                    ),
                  ),
                ),
                if (kIsWeb)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: const Footer(),
                  ),
              ],
            ),
          ),
        AuthStateLoading() => LoadingPage(),
        _ => SizedBox()
      },
    );
  }
}
