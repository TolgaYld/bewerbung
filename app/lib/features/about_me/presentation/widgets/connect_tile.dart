import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

class ConnectTile extends HookConsumerWidget {
  const ConnectTile({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
  });

  final VoidCallback onTap;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    return Padding(
      padding: EdgeInsets.only(bottom: Spacers.m),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Spacers.s),
        child: Padding(
          padding: EdgeInsets.all(Spacers.s),
          child: Row(
            children: [
              Icon(
                icon,
                color: theme.colorScheme.primary,
              ),
              const HSpace.s(),
              AutoSizeText(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface,
                  decoration: TextDecoration.underline,
                  decorationColor:
                      theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
