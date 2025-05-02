import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

class SectionHeader extends HookConsumerWidget {
  const SectionHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();

    return Row(
      children: [
        AutoSizeText(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const HSpace.s(),
        Expanded(
          child: Divider(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            thickness: 1.5,
          ),
        ),
      ],
    );
  }
}
