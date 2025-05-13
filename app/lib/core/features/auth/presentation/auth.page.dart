import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

    final isQrMode = switch (state) {
      final AuthStateEditing s when s.qrMode && kIsWeb == false => true,
      _ => false
    };

    const animDuration = Durations.medium4;
    const baseDelay = Durations.short1;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: AutoSizeText(l10n.welcomeToTheApp)
              .animate()
              .fadeIn(duration: animDuration, delay: baseDelay),
          centerTitle: true,
          actions: [
            LanguageSwitcher().animate().fadeIn(
                  duration: animDuration,
                  delay: baseDelay * 2,
                ),
            const HSpace.xs(),
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacers.s),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const VSpace.x3l(),
                        if (kIsWeb)
                          Padding(
                            padding: const EdgeInsets.only(top: Spacers.l),
                            child: Text(
                              l10n.enterYourLoginInformation,
                              style: textTheme.bodyLarge,
                            ),
                          ).animate().fadeIn(
                                duration: animDuration,
                                delay: baseDelay * 3,
                              ),
                        if (kIsWeb == false) ...[
                          Text(
                            l10n.howDoYouWantToLogin,
                            style: textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.primary
                                  .withValues(alpha: 0.7),
                            ),
                            textAlign: TextAlign.center,
                          ).animate().fadeIn(
                                duration: animDuration,
                                delay: baseDelay * 3,
                              ),
                          const VSpace.s(),
                          ToggleButtons(
                            onPressed: (int index) {
                              if ((index == 0 && isQrMode == false) ||
                                  (index == 1 && isQrMode)) {
                                notifier.toggleQrMode();
                              }
                            },
                            borderRadius: BorderRadius.circular(Spacers.s),
                            selectedBorderColor: theme.colorScheme.primary,
                            selectedColor: theme.colorScheme.primary,
                            fillColor: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                            constraints: const BoxConstraints(
                              minHeight: 36.0,
                              minWidth: 60.0,
                            ),
                            isSelected: [isQrMode, isQrMode == false],
                            children: const [
                              Icon(Icons.qr_code_scanner_rounded),
                              Icon(Icons.key_rounded),
                            ],
                          ).animate().fadeIn(
                                duration: animDuration,
                                delay: baseDelay * 5,
                              ),
                        ],
                        const VSpace.xl(),
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: width > 600 ? 600 : width,
                            ),
                            child: LoginSwitchWidget(
                              state: state,
                              notifier: notifier,
                            ),
                          ),
                        ).animate().fadeIn(
                              duration: animDuration,
                              delay: baseDelay * (kIsWeb ? 5 : 7),
                            ),
                        const VSpace.xl(),
                        Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: Card(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.grey.withValues(alpha: 0.5),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(Spacers.s),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(Spacers.xs),
                              child: AutoSizeText.rich(
                                TextSpan(
                                  text: '${l10n.youNeedHelp} ',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color:
                                        theme.colorScheme.onSurface.withValues(
                                      alpha: 0.7,
                                    ),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: l10n.clickHere,
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.7),
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async =>
                                            notifier.sendMailTo(email),
                                    ),
                                    TextSpan(
                                      text: switch (state) {
                                        AuthStateEditing(showEmail: true) =>
                                          '\n$email',
                                        _ => "",
                                      },
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ).animate().fadeIn(
                              duration: animDuration,
                              delay: baseDelay * 9,
                            ),
                      ],
                    ),
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
              ).animate().fadeIn(
                    duration: animDuration,
                    delay: baseDelay * 6,
                  ),
          ],
        ),
      ),
    );
  }
}
