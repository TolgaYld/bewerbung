import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/routing/router.dart';

class QrButton extends HookConsumerWidget {
  const QrButton({
    super.key,
    required this.state,
    required this.notifier,
  });

  final AuthState state;
  final AuthNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final theme = useTheme();
    final colorScheme = theme.colorScheme;

    return Hero(
      tag: 'qr_login_card',
      child: GestureDetector(
        onTap: () async {
          final result = await context.pushNamed<String>(RoutePath.qrPage.name);
          if (result != null) {
            final username = result.split(' ').first.trim();
            final password = result.split(' ').last.trim();
            notifier.updateFields(
              username: username,
              password: password,
            );
            await notifier.login(l10n);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(Spacers.s),
              ),
              child: Icon(
                Icons.qr_code_scanner,
                size: 120,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(height: Spacers.m),
            Text(
              l10n.tapOnScanQrCodeToLogin,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Spacers.xs),
            Text(
              l10n.youWillBeAutomaticallyLoggedIn,
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(
          duration: Durations.long4,
          curve: Curves.easeIn,
        )
        .scale(
          duration: Durations.long3,
          curve: Curves.easeOutBack,
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
        );
  }
}
