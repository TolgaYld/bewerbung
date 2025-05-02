import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

class DecisionStatusBadge extends HookConsumerWidget {
  const DecisionStatusBadge({
    super.key,
    required this.company,
    required this.onTap,
  });

  final Company company;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final isHovering = useState<bool>(false);

    return MouseRegion(
      onEnter: (_) => isHovering.value = true,
      onExit: (_) => isHovering.value = false,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacers.s,
            vertical: Spacers.xs,
          ),
          decoration: BoxDecoration(
            color: company.decisionStatus.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(Spacers.s),
            border: Border.all(
              color: company.decisionStatus.color.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: isHovering.value
                ? [
                    BoxShadow(
                      color:
                          company.decisionStatus.color.withValues(alpha: 0.3),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: Spacers.xs,
            children: [
              Icon(
                company.decisionStatus.icon,
                size: 16,
                color: company.decisionStatus.color,
              ),
              Text(
                company.decisionStatus.getLocalizedLabel(l10n),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: company.decisionStatus.color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.info_outline,
                size: 16,
                color: company.decisionStatus.color,
              ),
            ],
          ),
        ),
      ).animate(target: isHovering.value ? 1 : 0).scale(
            begin: const Offset(1, 1),
            end: const Offset(1.05, 1.05),
            duration: Durations.short2,
            curve: Curves.easeOut,
          ),
    )
        .animate()
        .fadeIn(
          duration: Durations.short4,
        )
        .slideY(
          begin: -0.2,
          end: 0,
          curve: Curves.easeOutBack,
        );
  }
}
