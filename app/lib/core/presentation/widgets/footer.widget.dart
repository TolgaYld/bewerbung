import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/routing/router.dart';

class Footer extends HookConsumerWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    return Container(
      width: double.infinity,
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(Spacers.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              child: Text(
                l10n.imprint,
                style: theme.textTheme.bodySmall?.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: theme.colorScheme.surface,
                  color: theme.colorScheme.surface,
                ),
              ),
              onPressed: () => context.go(RoutePath.imprint.path),
            ),
            TextButton(
              child: Text(
                l10n.privacyPolicy,
                style: theme.textTheme.bodySmall?.copyWith(
                  decoration: TextDecoration.underline,
                  decorationColor: theme.colorScheme.surface,
                  color: theme.colorScheme.surface,
                ),
              ),
              onPressed: () => context.go(RoutePath.privacyPolicy.path),
            ),
            Text(
              l10n.copyright(DateTime.now().year),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.surface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
