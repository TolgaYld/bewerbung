import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/contact.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/employee.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/person.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/skill.dart';
import 'package:pleasehiretolga/core/features/employee/provider/employee.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/molecules/section_header.dart';
import 'package:pleasehiretolga/core/presentation/widgets/progress_card.widget.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';
import 'package:pleasehiretolga/features/about_me/presentation/widgets/connect_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends HookConsumerWidget {
  const AboutMePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();

    final scrollController = useScrollController();
    final employee = ref.watch(employeeProvider).valueOrNull;
    final disability = ref.watch(disabilityProvider).valueOrNull;
    final locale = ref.watch(localeProvider);

    final skills = switch (employee) {
      Employee(:final generalSkills?) when generalSkills.isNotEmpty => [
          ...generalSkills,
        ]..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0)),
      _ => <Skill>[],
    };

    final contactOptions = switch (employee) {
      Employee(
        person: Person(
          contact: Contact(
            :final email?,
            :final phoneNumber?,
          )
        )
      ) =>
        [
          (
            icon: Icons.email_outlined,
            label: email,
            onTap: () => launchUrl(
                  Uri(
                    scheme: 'mailto',
                    path: email,
                  ),
                ),
          ),
          (
            icon: Icons.phone_outlined,
            label: phoneNumber,
            onTap: () => launchUrl(
                  Uri(
                    scheme: 'tel',
                    path: phoneNumber,
                  ),
                ),
          ),
        ],
      _ => [],
    };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: Spacers.s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const VSpace.l(),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Center(
                      child: switch (employee) {
                        Employee(person: Person(:final imageUrls?))
                            when imageUrls.isNotEmpty =>
                          GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierColor: Colors.black.withValues(alpha: 0.7),
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: EdgeInsets.zero,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => Navigator.of(context).pop(),
                                    child: Center(
                                      child: Hero(
                                        tag: 'picture_tolga',
                                        child: CachedNetworkImage(
                                          imageUrl: imageUrls.first,
                                          fit: BoxFit.contain,
                                          errorWidget: (_, __, ___) =>
                                              const Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            child: Hero(
                              tag: 'picture_tolga',
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: imageUrls.first,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter,
                                  placeholder: (context, url) => Icon(
                                    Icons.person,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        _ => Icon(
                            Icons.person,
                            size: 48,
                            color: Colors.grey,
                          ),
                      },
                    ),
                  ),
                  const HSpace.m(),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          employee?.person.fullName ?? "Tolga Yildirim",
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const VSpace.xs(),
                        AutoSizeText(
                          employee?.getJobTitleText(locale) ??
                              "Fullstack Software Engineer",
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const VSpace.xs(),
                        AutoSizeText(
                          switch (employee) {
                            Employee(person: Person(:final contact?)) =>
                              "${contact.getCityText(locale)}, ${contact.getCountryText(locale)}",
                            _ => "I love Dart 3",
                          },
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const VSpace.l(),
              SectionHeader(
                title: l10n.aboutMe,
                icon: Icons.person_rounded,
              ),
              const VSpace.m(),
              AutoSizeText(
                employee?.getAboutMeText(locale) ?? "",
                style: theme.textTheme.bodyMedium?.copyWith(
                  height: 1.5,
                  letterSpacing: 0.3,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const VSpace.l(),
              SectionHeader(
                title: l10n.mySkills,
                icon: Icons.fitness_center_rounded,
              ),
              if (skills.isNotEmpty) ...[
                const VSpace.m(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: skills.length,
                  separatorBuilder: (_, __) => const VSpace.m(),
                  itemBuilder: (context, index) {
                    final skill = skills[index];
                    return ProgressCard(
                      title: skill.getTitle(locale),
                      percentage: skill.rating ?? 0,
                      description: skill.getDescription(locale),
                      emoji: skill.emoji,
                      index: index,
                    );
                  },
                ),
              ],
              const VSpace.l(),
              SectionHeader(
                title: l10n.languates,
                icon: Icons.language,
              ),
              if (employee?.languages case final lngs?
                  when lngs.isNotEmpty) ...[
                const VSpace.m(),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lngs.length,
                  separatorBuilder: (_, __) => const VSpace.m(),
                  itemBuilder: (context, index) {
                    final language = lngs[index];
                    return ProgressCard(
                      title: language.getTitle(locale),
                      percentage: language.rating ?? 0,
                      description: language.getDescription(locale),
                      emoji: language.emoji,
                      index: index,
                    );
                  },
                ),
              ],
              const VSpace.l(),
              if (disability != null) ...[
                SectionHeader(
                  title: l10n.disability,
                  icon: Icons.directions_walk_rounded,
                ),
                const VSpace.m(),
                Padding(
                  padding: EdgeInsets.only(bottom: Spacers.m),
                  child: ProgressCard(
                    title: disability.type,
                    percentage: disability.percentage,
                    index: 0,
                  ),
                ),
                const VSpace.l(),
              ],
              SectionHeader(
                title: l10n.contact,
                icon: Icons.contact_phone_rounded,
              ),
              const VSpace.m(),
              ...contactOptions.map(
                (option) => ConnectTile(
                  onTap: option.onTap,
                  icon: option.icon,
                  label: option.label,
                ),
              ),
              const VSpace.xs(),
              SectionHeader(
                title: l10n.letsConnect,
                icon: Icons.link_rounded,
              ),
              const VSpace.m(),
              ConnectTile(
                onTap: () async => await launchUrl(
                  Uri.parse("https://github.com/TolgaYld"),
                ),
                icon: Icons.code_rounded,
                label: "GitHub",
              ),
              ConnectTile(
                onTap: () async => await launchUrl(
                  Uri.parse(
                      "https://www.linkedin.com/in/tolga-yildirim-73201a261/"),
                ),
                icon: Icons.business_rounded,
                label: "LinkedIn",
              ),
            ],
          ).animate().fadeIn(
                duration: Durations.medium3,
                curve: Curves.easeIn,
              ),
        ),
      ),
    );
  }
}
