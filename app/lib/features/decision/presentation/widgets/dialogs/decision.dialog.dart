import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/datetime_formatter.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/mixins/dialog.mixin.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';

typedef DecisionResult = ({
  DecisionStatus status,
  String? explanation,
  DateTime? appointmentDateTime,
});

class DecisionDialog extends HookConsumerWidget
    with ShowableDialogMixin<DecisionResult?> {
  const DecisionDialog({
    super.key,
    required this.invite,
    required this.title,
    required this.content,
  });

  final bool invite;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final locale = ref.watch(localeProvider);
    final explanationController = useTextEditingController();
    final selectedDate = useState<DateTime?>(null);
    final selectedTime = useState<TimeOfDay?>(null);
    final shouldShowDatePicker = useState<bool>(false);

    String formatDateTimeCombi(DateTime dateTime) =>
        DateTimeFormatter.formatDateTimeCombined(
          dateTime,
          locale: locale?.languageCode,
        );

    final formattedDateTime = useMemoized(
      () {
        if ((selectedDate.value, selectedTime.value)
            case (final date?, final time?)) {
          final dateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
          return formatDateTimeCombi(dateTime);
        }
        return null;
      },
      [
        selectedDate.value,
        selectedTime.value,
      ],
    );

    Future<void> pickDate() async {
      final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (context, child) {
          return Theme(
            data: theme.copyWith(
              colorScheme: theme.colorScheme.copyWith(
                primary: theme.colorScheme.primary,
              ),
            ),
            child: child ?? const SizedBox(),
          );
        },
      );

      if (pickedDate != null) {
        selectedDate.value = pickedDate;

        final pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          builder: (context, child) {
            return Theme(
              data: theme.copyWith(
                colorScheme: theme.colorScheme.copyWith(
                  primary: theme.colorScheme.primary,
                ),
              ),
              child: child ?? const SizedBox(),
            );
          },
        );

        if (pickedTime != null) {
          selectedTime.value = pickedTime;
          shouldShowDatePicker.value = false;
        }
      }
    }

    return AlertDialog(
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              invite
                  ? Icons.celebration_rounded
                  : Icons.sentiment_dissatisfied_rounded,
              size: 64,
              color: theme.colorScheme.primary,
            )
                .animate()
                .scale(
                  duration: Durations.medium2,
                  curve: Curves.easeOutBack,
                )
                .fadeIn(),
            const VSpace.s(),
            Text(
              content,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ).animate().fadeIn(
                  delay: Durations.short4,
                  duration: Durations.medium1,
                ),
            const VSpace.m(),
            TextField(
              controller: explanationController,
              decoration: InputDecoration(
                hintText: invite
                    ? l10n.inviteExplanationHint
                    : l10n.refuseExplanationHint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Spacers.s),
                  borderSide: BorderSide(color: theme.colorScheme.outline),
                ),
                contentPadding: EdgeInsets.all(Spacers.s),
              ),
              maxLines: 15,
              minLines: 3,
              style: theme.textTheme.bodyMedium,
            ).animate().fadeIn(
                  delay: Durations.short4,
                  duration: Durations.medium1,
                ),
            if (formattedDateTime != null) ...[
              const VSpace.m(),
              Container(
                padding: EdgeInsets.all(Spacers.s),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(Spacers.s),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        formattedDateTime,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: theme.colorScheme.onPrimaryContainer,
                            size: 18,
                          ),
                          onPressed: pickDate,
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          iconSize: 18,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: theme.colorScheme.onPrimaryContainer,
                            size: 18,
                          ),
                          onPressed: () {
                            selectedDate.value = null;
                            selectedTime.value = null;
                            shouldShowDatePicker.value = false;
                          },
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          iconSize: 18,
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(
                    duration: Durations.short3,
                  ),
              const VSpace.m(),
            ] else ...[
              if (invite) ...[
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: pickDate,
                    child: Text(
                      l10n.pickDate,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      actions: [
        if (invite) ...[
          TextButton(
            onPressed: () => pop(context, null),
            child: Text(
              l10n.cancel,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final dateTime =
                  switch ((selectedDate.value, selectedTime.value)) {
                (final date?, final time?) => DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  ),
                _ => null
              };
              pop(
                context,
                (
                  status: DecisionStatus.invited,
                  explanation: explanationController.text.isEmpty
                      ? null
                      : explanationController.text,
                  appointmentDateTime: dateTime,
                ),
              );
            },
            child: Text(
              l10n.invite,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ] else ...[
          TextButton(
            onPressed: () => pop(context, null),
            child: Text(
              l10n.close,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              pop(
                context,
                (
                  status: DecisionStatus.rejected,
                  explanation: explanationController.text.isEmpty
                      ? null
                      : explanationController.text,
                  appointmentDateTime: null,
                ),
              );
            },
            child: Text(
              l10n.refuse,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
