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
import 'package:pleasehiretolga/core/features/employee/provider/employee.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/molecules/section_header.dart';
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
          for (final skill in generalSkills)
            (
              name: skill.getTitle(locale),
              rating: skill.rating,
              emoji: skill.emoji
            ),
        ]..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0)),
      _ => [],
    };

    final languages = switch (employee) {
      Employee(:final languages) when languages.isNotEmpty => [
          for (final language in languages)
            (
              name: language.getTitle(locale),
              rating: language.rating,
              emoji: language.emoji
            ),
        ]..sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0)),
      _ => [],
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
              SectionHeader(title: l10n.aboutMe),
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
              SectionHeader(title: l10n.mySkills),
              const VSpace.m(),
              ...skills.map(
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
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          AutoSizeText(
                            "${(skill.rating * 100).toInt()}%",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: skill.rating,
                        backgroundColor:
                            theme.colorScheme.primary.withValues(alpha: 0.1),
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(Spacers.s),
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
              ),
              const VSpace.l(),
              SectionHeader(title: l10n.languates),
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
                            "${skill.name}",
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
                        backgroundColor:
                            theme.colorScheme.primary.withValues(alpha: 0.1),
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(Spacers.s),
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
              ),
              const VSpace.l(),
              SectionHeader(title: l10n.disability),
              const VSpace.m(),
              if (disability != null)
                Padding(
                  padding: EdgeInsets.only(bottom: Spacers.m),
                  child: Column(
                    spacing: Spacers.xs,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AutoSizeText(
                                disability.type,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              if (disability.url case final url?)
                                IconButton(
                                  onPressed: () async => await launchUrl(
                                    Uri.parse(url),
                                    mode: LaunchMode.externalApplication,
                                  ),
                                  icon: Icon(
                                    Icons.open_in_new,
                                    color: theme.colorScheme.primary,
                                    size: 18,
                                  ),
                                  tooltip: l10n.showCopyOfDisabilityCard,
                                ),
                            ],
                          ),
                          AutoSizeText(
                            "${(disability.percentage * 100).toInt()}%",
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      LinearProgressIndicator(
                        value: disability.percentage,
                        backgroundColor:
                            theme.colorScheme.primary.withValues(alpha: 0.1),
                        color: theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(Spacers.xs),
                        minHeight: 6,
                      ),
                    ],
                  ),
                ),
              const VSpace.l(),
              SectionHeader(title: l10n.contact),
              const VSpace.m(),
              ...contactOptions.map(
                (option) => ConnectTile(
                  onTap: option.onTap,
                  icon: option.icon,
                  label: option.label,
                ),
              ),
              const VSpace.xs(),
              SectionHeader(title: l10n.letsConnect),
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
