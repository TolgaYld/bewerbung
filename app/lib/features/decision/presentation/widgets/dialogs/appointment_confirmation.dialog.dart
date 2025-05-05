import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/mixins/dialog.mixin.dart';

class AppointmentConfirmationDialog extends HookConsumerWidget
    with ShowableDialogMixin {
  const AppointmentConfirmationDialog({
    super.key,
    this.formattedDate,
    this.explanation,
  });
  final String? formattedDate;
  final String? explanation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    return AlertDialog(
      title: Text(
        l10n.inviteIsSent,
        style: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.7,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Spacers.s,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 64,
              color: Colors.green,
            ).animate().scale(
                  duration: Durations.medium2,
                  curve: Curves.easeOutBack,
                ),
            Text(
              l10n.inviteIsSentContent,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (formattedDate case final date?)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacers.m,
                  vertical: Spacers.s,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(Spacers.s),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  spacing: Spacers.xs,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 20,
                      color: theme.colorScheme.primary,
                    ),
                    Expanded(
                      child: Text(
                        date,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: Durations.medium1,
                  )
                  .slideY(
                    begin: 0.2,
                    end: 0,
                    curve: Curves.easeOutBack,
                  ),
            if (explanation case final explanationText?)
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacers.m,
                    vertical: Spacers.s,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Spacers.s),
                    border: Border.all(
                      color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    spacing: Spacers.s,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.description,
                        size: 20,
                        color: theme.colorScheme.primary,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            explanationText,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: Durations.medium2,
                  )
                  .slideY(
                    begin: 0.2,
                    end: 0,
                    curve: Curves.easeOutBack,
                  ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacers.s),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            l10n.close,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
