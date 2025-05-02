import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/datetime_formatter.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/employee/provider/employee.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';
import 'package:pleasehiretolga/features/cover_letter/presentation/widgets/header_part.widget.dart';
import 'package:pleasehiretolga/features/cover_letter/provider/cover_letter.provider.dart';

class CoverLetterPage extends HookConsumerWidget {
  const CoverLetterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final locale = ref.watch(localeProvider);

    final coverLetter = ref.watch(coverLetterProvider).valueOrNull;
    final employee = ref.watch(employeeProvider).valueOrNull;

    final infoDelay = useState<Duration>(Durations.short4);
    final contentDelay = useState<Duration>(Durations.long2);
    final signatureDelay = useState<Duration>(Durations.long4);

    final translation = coverLetter?.getTranslation(locale);
    final formatDate = switch (coverLetter?.date) {
      final date? => DateTimeFormatter.formatDateLong(
          date,
          locale: locale?.languageCode,
        ),
      _ => null,
    };

    return Scaffold(
      body: SafeArea(
        child: switch (coverLetter) {
          final converLetter? => SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: Spacers.m),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VSpace.l(),
                  switch (employee?.person) {
                    final prs? => HeaderPart(
                        name: switch (employee?.person) {
                          final prs? => prs.fullName,
                          _ => "",
                        },
                        position: employee?.getJobTitleText(locale) ?? "",
                        address: prs.contact?.getAddressForClFormat(locale),
                        imageUrl: converLetter.imageUrl,
                        date: formatDate,
                      ).animate().fadeIn(
                            duration: Durations.medium3,
                            curve: Curves.easeIn,
                          ),
                    _ => const SizedBox(),
                  },
                  const VSpace.s(),
                  Divider(
                    color: Colors.grey[700],
                  ).animate().fadeIn(
                        duration: Durations.medium3,
                        curve: Curves.easeIn,
                        delay: infoDelay.value,
                      ),
                  const VSpace.s(),
                  AutoSizeText(
                    translation?.subject ?? "",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ).animate().fadeIn(
                        duration: Durations.medium3,
                        curve: Curves.easeIn,
                        delay: infoDelay.value,
                      ),
                  const VSpace.xs(),
                  AutoSizeText(
                    translation?.content ?? "",
                    style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.5, letterSpacing: 0.3, color: Colors.black),
                  ).animate().fadeIn(
                        duration: Durations.medium3,
                        curve: Curves.easeIn,
                        delay: contentDelay.value,
                      ),
                  const VSpace.l(),
                  AutoSizeText(
                    switch (employee?.person) {
                      final prs? => prs.fullName,
                      _ => "",
                    },
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ).animate().fadeIn(
                        duration: Durations.medium3,
                        curve: Curves.easeIn,
                        delay: signatureDelay.value,
                      ),
                  const VSpace.xl(),
                ],
              ),
            ),
          null => Center(
              child: AutoSizeText(
                l10n.noDataAvailable,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        },
      ),
    );
  }
}
