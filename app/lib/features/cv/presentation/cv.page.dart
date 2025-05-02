import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/datetime_formatter.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/employee.dart';
import 'package:pleasehiretolga/core/features/employee/provider/employee.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/molecules/section_header.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';
import 'package:pleasehiretolga/features/cv/presentation/widgets/cv_entry.widget.dart';

class CvPage extends HookConsumerWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final theme = useTheme();
    final empl = ref.watch(employeeProvider).valueOrNull;
    final locale = ref.watch(localeProvider);
    String formatDate(DateTime date) =>
        DateTimeFormatter.formatMonthYear(date, locale: locale?.languageCode);

    final languages = switch (empl) {
      Employee(:final programmingLanguages)
          when programmingLanguages.isNotEmpty =>
        [
          for (final language in programmingLanguages)
            (
              name: language.getTitle(locale),
              rating: language.rating,
              emoji: language.emoji
            ),
        ]..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0)),
      _ => [],
    };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: Spacers.s),
          physics: const BouncingScrollPhysics(),
          child: switch (empl) {
            final employee? => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VSpace.l(),
                  SectionHeader(title: l10n.education),
                  const VSpace.m(),
                  for (final education in employee.cv.sortedEducations(
                      descending: locale?.languageCode != "en")) ...[
                    CvEntry(
                      title: education.getTitle(locale),
                      subtitle: education.getDescription(locale) ?? "",
                      monthYear:
                          "${formatDate(education.startDate)} - ${switch (education.endDate) {
                        final date? => formatDate(date),
                        null => l10n.present,
                      }}",
                      description: education
                          .getResponsibilities(locale)
                          .map((e) => "• $e")
                          .join('\n\n'),
                      completed: education.passed,
                    ),
                  ],
                  const VSpace.l(),
                  SectionHeader(title: l10n.jobExperience),
                  const VSpace.m(),
                  for (final experience in employee.cv.sortedJobs(
                      descending: locale?.languageCode != "en")) ...[
                    CvEntry(
                      title: experience.getTitle(locale),
                      subtitle: experience.getDescription(locale) ?? "",
                      monthYear:
                          "${formatDate(experience.startDate)} - ${switch (experience.endDate) {
                        final date? => formatDate(date),
                        null => l10n.present,
                      }}",
                      description: experience
                          .getResponsibilities(locale)
                          .map((e) => "• $e")
                          .join('\n\n'),
                      completed: experience.passed,
                      pictureUri: experience.imageUrl,
                      link: experience.link,
                    ),
                  ],
                  const VSpace.l(),
                  SectionHeader(title: l10n.sideJobs),
                  const VSpace.m(),
                  for (final sideJob in employee.cv.sortedSideJobs(
                      descending: locale?.languageCode != "en")) ...[
                    CvEntry(
                      title: sideJob.getTitle(locale),
                      subtitle: sideJob.getDescription(locale) ?? "",
                      monthYear:
                          "${formatDate(sideJob.startDate)} - ${switch (sideJob.endDate) {
                        final date? => formatDate(date),
                        null => l10n.present,
                      }}",
                      description: sideJob
                          .getResponsibilities(locale)
                          .map((e) => "• $e")
                          .join('\n\n'),
                      completed: sideJob.passed,
                    ),
                  ],
                  const VSpace.l(),
                  SectionHeader(title: l10n.programmingLanguages),
                  const VSpace.m(),
                  ...languages.map(
                    (skill) => Padding(
                      padding: EdgeInsets.only(bottom: Spacers.m),
                      child: Column(
                        spacing: Spacers.xs,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                "${skill.emoji} ${skill.name}",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              AutoSizeText(
                                "${(skill.rating * 100).toInt()}%",
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                          LinearProgressIndicator(
                            value: skill.rating,
                            backgroundColor: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(Spacers.xs),
                            minHeight: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const VSpace.l(),
                  if (employee.cv.drivingLicence
                      case final drivingLicences?) ...[
                    SectionHeader(title: l10n.drivingLicenseClasses),
                    const VSpace.m(),
                    AutoSizeText(
                      drivingLicences.map((e) => e).join(", "),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const VSpace.l(),
                  ],
                ],
              ).animate().fadeIn(
                    duration: Durations.medium3,
                    curve: Curves.easeIn,
                  ),
            _ => SizedBox(),
          },
        ),
      ),
    );
  }
}
