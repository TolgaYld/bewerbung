import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/widgets/login_switch.widget.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/imprint/provider/imprint.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
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
    final width = MediaQuery.sizeOf(context).width;
    final imprint = ref.watch(imprintProvider).valueOrNull;
    final contact = imprint?.getContact(Locale("de"));
    final email = (RegExp(r'E-Mail: ([\w\.-]+@[\w\.-]+\.\w+)')
                .firstMatch(contact ?? '')
                ?.group(1) ??
            '')
        .trim();

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
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: AutoSizeText(l10n.welcomeToPleaseHireTolga),
          centerTitle: true,
          actions: [
            LanguageSwitcher(),
            const HSpace.xs(),
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacers.s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const VSpace.x2l(),
                      ResponsiveWidget(
                        mobile: Column(
                          mainAxisSize: MainAxisSize.min,
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
                          ],
                        ),
                        tablet: null,
                        desktop: const SizedBox(),
                      ),
                      const VSpace.l(),
                      Expanded(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: width > 600 ? 600 : width,
                            ),
                            child: LoginSwitchWidget(
                              state: state,
                              notifier: notifier,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Spacers.x6l),
                        child: AutoSizeText.rich(
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
                                  ..onTap =
                                      () async => notifier.sendMailTo(email),
                              ),
                              TextSpan(
                                text: switch (state) {
                                  AuthStateEditing(showEmail: true) =>
                                    '\n$email',
                                  _ => "",
                                },
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
    );
  }
}
