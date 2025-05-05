import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/imprint/provider/imprint.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/loading_page.dart';
import 'package:pleasehiretolga/core/presentation/widgets/language_switcher.widget.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';

class ImprintPage extends HookConsumerWidget {
  const ImprintPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final imprint = ref.watch(imprintProvider).valueOrNull;
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.imprint),
        centerTitle: true,
        actions: [LanguageSwitcher(), const HSpace.xs()],
      ),
      body: switch (imprint) {
        final imprint? => Padding(
            padding: const EdgeInsets.all(Spacers.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.imprint,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  imprint.getAddress(locale),
                  style: theme.textTheme.bodyLarge,
                ),
                const VSpace.s(),
                Text(
                  l10n.contact,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  imprint.getContact(locale),
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        _ => const LoadingPage(),
      },
    );
  }
}
