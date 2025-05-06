import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/datetime_formatter.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/localization/localizations.dart';
import 'package:pleasehiretolga/core/presentation/mixins/dialog.mixin.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';
import 'package:pleasehiretolga/features/decision/presentation/decision.notifier.dart';

class StatusOverlayDialog extends HookConsumerWidget with ShowableDialogMixin {
  const StatusOverlayDialog({
    super.key,
    required this.company,
  });

  final Company company;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final notifier = ref.watch(decisionStateProvider.notifier);
    final locale = ref.watch(localeProvider);

    String formatDuration(Duration duration, L10n l10n) {
      final hours = duration.inHours;
      final minutes = duration.inMinutes.remainder(60);

      if (hours > 0) {
        return l10n.durationFormatted(
          hours,
          minutes,
        );
      } else {
        return l10n.durationFormattedMinutesOnly(minutes);
      }
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacers.s),
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(Spacers.m),
              decoration: BoxDecoration(
                color: company.decisionStatus.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Spacers.s),
                  topRight: Radius.circular(Spacers.s),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    company.decisionStatus.icon,
                    color: company.decisionStatus.color,
                    size: 24,
                  ),
                  const SizedBox(width: Spacers.s),
                  Expanded(
                    child: Text(
                      company.decisionStatus.getLocalizedLabel(l10n),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: company.decisionStatus.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Spacers.m),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _TitleSection(
                      icon: Icons.message_outlined,
                      title: company.decisionStatus == DecisionStatus.rejected
                          ? l10n.reasonForRejection
                          : l10n.message,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(Spacers.s),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(Spacers.xs),
                        border: Border.all(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.1),
                        ),
                      ),
                      child: Text(
                        switch (company.decisionMessage) {
                          final message? when message.isNotEmpty => message,
                          _ => l10n.noMessageWrittenToApplicant,
                        },
                        style: switch (company.decisionMessage) {
                          final message? when message.isNotEmpty =>
                            theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          _ => theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                              fontStyle: FontStyle.italic,
                            ),
                        },
                      ),
                    ),
                    if (company.decisionStatus == DecisionStatus.invited) ...[
                      const VSpace.m(),
                      if (company.inviteDate case final date?) ...[
                        _TitleSection(
                          icon: Icons.calendar_today,
                          title: l10n.appointment,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(Spacers.s),
                          decoration: BoxDecoration(
                            color: company.decisionStatus.color
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(Spacers.xs),
                            border: Border.all(
                              color: company.decisionStatus.color
                                  .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: Spacers.xs,
                                children: [
                                  Icon(
                                    Icons.event,
                                    color: company.decisionStatus.color,
                                    size: 18,
                                  ),
                                  Expanded(
                                    child: Text(
                                      DateTimeFormatter.formatDateTimeCombined(
                                        date,
                                        locale: locale?.languageCode,
                                      ),
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: company.decisionStatus.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (company.inviteDuration
                                  case final duration?) ...[
                                const VSpace.xs(),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      color: company.decisionStatus.color,
                                      size: 18,
                                    ),
                                    const SizedBox(width: Spacers.xs),
                                    Expanded(
                                      child: Text(
                                        "${l10n.duration}: ${formatDuration(duration, l10n)}",
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: company.decisionStatus.color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        const VSpace.s(),
                      ],
                      _TitleSection(
                        icon: Icons.person_outline,
                        title: l10n.responseOfApplicant,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(Spacers.s),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(Spacers.xs),
                          border: Border.all(
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          spacing: Spacers.s,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "${l10n.responseStatusFromApplicant}:",
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Icon(
                                  switch (company.employeeAcceptedInvite) {
                                    true => Icons.check_circle_rounded,
                                    false => Icons.cancel_rounded,
                                    null => Icons.hourglass_top_rounded,
                                  },
                                  color: switch (
                                      company.employeeAcceptedInvite) {
                                    true => Colors.green,
                                    false => Colors.red,
                                    null => Colors.grey,
                                  },
                                  size: 18,
                                ),
                              ],
                            ),
                            if (company.messageFromEmployee case final message?
                                when message.isNotEmpty) ...[
                              const Divider(height: 16),
                              Text(
                                "${l10n.message}:",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                message,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacers.m,
                vertical: Spacers.s,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (company.decisionStatus != DecisionStatus.pending)
                    TextButton.icon(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text(l10n.revokeDialogTitle),
                            content: Text(
                              l10n.revokeDialogContent,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: Text(
                                  l10n.cancel,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                style: TextButton.styleFrom(
                                  foregroundColor: theme.colorScheme.error,
                                ),
                                child: Text(l10n.revoke),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          await notifier.revertDecision(company.id);
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 18,
                      ),
                      label: Text(
                        l10n.revoke,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.deepOrange,
                      ),
                    ),
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
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(
          duration: Durations.medium2,
          curve: Curves.easeIn,
        );
  }
}

class _TitleSection extends HookConsumerWidget {
  const _TitleSection({
    required this.icon,
    required this.title,
  });

  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    return Padding(
      padding: const EdgeInsets.only(bottom: Spacers.xs),
      child: Row(
        spacing: Spacers.xs,
        children: [
          Icon(
            icon,
            size: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
