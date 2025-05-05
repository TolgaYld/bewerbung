import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/widgets/language_switcher.widget.dart';
import 'package:pleasehiretolga/core/routing/router.dart';
import 'package:pleasehiretolga/presentation/widgets/sign_out.dialog.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final theme = useTheme();
    final notifier = ref.watch(authStateProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        centerTitle: true,
        actions: [
          LanguageSwitcher(),
          const HSpace.s(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                l10n.privacyPolicy,
                style: theme.textTheme.bodyLarge,
              ),
              trailing: Icon(
                Icons.policy_rounded,
                color: theme.colorScheme.primary,
              ),
              onTap: () => context.push(RoutePath.privacyPolicy.path),
            ),
            ListTile(
              title: Text(
                l10n.imprint,
                style: theme.textTheme.bodyLarge,
              ),
              trailing: Icon(
                Icons.account_box_rounded,
                color: theme.colorScheme.primary,
              ),
              onTap: () => context.push(RoutePath.imprint.path),
            ),
            const VSpace.m(),
            ListTile(
              title: Text(
                l10n.signOut,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.error,
                ),
              ),
              subtitle: Text(
                l10n.signOutSubtitle,
                maxLines: 1,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              trailing: Icon(
                Icons.logout_rounded,
                color: theme.colorScheme.error,
              ),
              onTap: () async {
                final result = await SignOutDialog().show(context);
                if (result == true) {
                  await notifier.signOut(true);
                } else if (result == false) {
                  await notifier.signOut(false);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
