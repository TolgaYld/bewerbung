import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

class SectionHeader extends HookConsumerWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.icon,
  });
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();

    return Row(
      spacing: Spacers.s,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(
            icon,
            color: theme.colorScheme.primary,
          ),
        AutoSizeText(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            height: 1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withValues(alpha: 0.8),
                  theme.colorScheme.primary.withValues(alpha: 0.01),
                ],
              ),
              borderRadius: BorderRadius.circular(Spacers.xxs),
            ),
          ),
        ),
      ],
    );
  }
}
