import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/provider/privacy_policy.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/presentation/loading_page.dart';
import 'package:pleasehiretolga/core/presentation/widgets/language_switcher.widget.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';

class PrivacyPolicyPage extends HookConsumerWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final privacyPolicy = ref.watch(privacyPolicyProvider).valueOrNull;
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.privacyPolicy),
        centerTitle: true,
        actions: [LanguageSwitcher(), const HSpace.xs()],
      ),
      body: switch (privacyPolicy) {
        final privacyPolicy? => Padding(
            padding: const EdgeInsets.all(Spacers.s),
            child: Markdown(data: privacyPolicy.getContent(locale)),
          ),
        _ => const LoadingPage(),
      },
    );
  }
}
