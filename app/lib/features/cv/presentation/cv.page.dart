import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/datetime_formatter.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/employee.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/skill.dart';
import 'package:pleasehiretolga/core/features/employee/provider/employee.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/molecules/section_header.dart';
import 'package:pleasehiretolga/core/presentation/widgets/progress_card.widget.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';
import 'package:pleasehiretolga/features/cv/presentation/widgets/cv_entry.widget.dart';

class CvPage extends HookConsumerWidget {
  const CvPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final empl = ref.watch(employeeProvider).valueOrNull;
    final locale = ref.watch(localeProvider);
    String formatDate(DateTime date) =>
        DateTimeFormatter.formatMonthYear(date, locale: locale?.languageCode);

    final languages = switch (empl) {
      Employee(:final programmingLanguages)
          when programmingLanguages.isNotEmpty =>
        [...programmingLanguages]
          ..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0)),
      _ => <Skill>[],
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
                  SectionHeader(
                    title: l10n.education,
                    icon: Icons.school_rounded,
                  ),
                  const VSpace.m(),
                  for (final education in employee.cv.sortedEducations(
                    descending: locale?.languageCode != "en",
                  )) ...[
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
                      link: education.link,
                      references: education.getReferences(locale),
                    ),
                  ],
                  const VSpace.l(),
                  SectionHeader(
                    title: l10n.jobExperience,
                    icon: Icons.work_rounded,
                  ),
                  const VSpace.m(),
                  for (final experience in employee.cv.sortedJobs(
                    descending: locale?.languageCode != "en",
                  )) ...[
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
                      references: experience.getReferences(locale),
                    ),
                  ],
                  const VSpace.l(),
                  SectionHeader(
                    title: l10n.sideJobs,
                    icon: Icons.laptop_mac_rounded,
                  ),
                  const VSpace.m(),
                  for (final sideJob in employee.cv.sortedSideJobs(
                    descending: locale?.languageCode != "en",
                  )) ...[
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
                      pictureUri: sideJob.imageUrl,
                      link: sideJob.link,
                      references: sideJob.getReferences(locale),
                    ),
                  ],
                  const VSpace.l(),
                  SectionHeader(
                    title: l10n.programmingLanguages,
                    icon: Icons.code_rounded,
                  ),
                  const VSpace.m(),
                  if (languages.isNotEmpty) ...[
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: languages.length,
                      separatorBuilder: (_, __) => const VSpace.m(),
                      itemBuilder: (context, index) {
                        final language = languages[index];
                        return ProgressCard(
                          title: language.getTitle(locale),
                          index: index,
                          percentage: language.rating ?? 0,
                          description: language.getDescription(locale),
                          emoji: language.emoji,
                        );
                      },
                    ),
                  ],
                  const VSpace.l(),
                  if (employee.cv.drivingLicence
                      case final drivingLicences?) ...[
                    SectionHeader(
                      title: l10n.drivingLicenseClasses,
                      icon: Icons.badge_rounded,
                    ),
                    const VSpace.m(),
                    Wrap(
                      spacing: Spacers.s,
                      runSpacing: Spacers.s,
                      children: [
                        for (final licence in drivingLicences)
                          _DrivingLicenceChip(
                            icon: switch (licence) {
                              "L" => Icons.agriculture_rounded,
                              "AM" => Icons.motorcycle_rounded,
                              "B" => Icons.directions_car_rounded,
                              _ => Icons.badge_rounded,
                            },
                            label: licence,
                          ),
                      ],
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

class _DrivingLicenceChip extends HookConsumerWidget {
  const _DrivingLicenceChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    return Chip(
      backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      avatar: Icon(icon, size: 20),
      label: Text(
        label,
        style: theme.textTheme.bodySmall,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacers.s),
        side: BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacers.s,
        vertical: Spacers.xxs,
      ),
    );
  }
}
