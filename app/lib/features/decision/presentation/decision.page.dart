import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';
import 'package:pleasehiretolga/core/features/employee/provider/employee.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_confetti.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_responsive.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/action_button.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/skill_chip.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/status_badge.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/dialogs/status_overlay.dialog.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/swiper.widget.dart';

class DecisionPage extends HookConsumerWidget {
  const DecisionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final screenSize = MediaQuery.sizeOf(context);
    final employee = ref.watch(employeeProvider).valueOrNull;
    final company = ref.watch(companyProvider).valueOrNull;
    final locale = ref.watch(localeProvider);
    final responsive = useResponsive();

    final swiperController = useMemoized(() => SwiperController(), []);
    final confettiController =
        useConfettiController(duration: Durations.extralong1);

    final showBadge =
        company != null && company.decisionStatus != DecisionStatus.pending;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Spacers.m),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacers.s),
                    child: AutoSizeText(
                      responsive.isDesktop
                          ? l10n.webButtonHeadline
                          : l10n.mobileSwipeHeadline,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const VSpace.xs(),
                  AutoSizeText(
                    responsive.isDesktop
                        ? l10n.webButtonInstruction
                        : l10n.mobileSwipeInstruction,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const VSpace.xs(),
                  if (showBadge) ...[
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(right: Spacers.m),
                        child: DecisionStatusBadge(
                          company: company,
                          onTap: () async =>
                              StatusOverlayDialog(company: company)
                                  .show(context),
                        ),
                      ),
                    ),
                  ],
                  const VSpace.l(),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: 300,
                      maxWidth: switch (kIsWeb) {
                        true => 600,
                        false => 400,
                      },
                      maxHeight: switch ((kIsWeb, showBadge)) {
                        (true, _) => screenSize.height * 0.6,
                        (false, true) => screenSize.height * 0.42,
                        (false, false) => screenSize.height * 0.49,
                      },
                    ),
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: Swiper(
                        companyId: company?.id,
                        controller: swiperController,
                        onRightSwipe: () {
                          final entry = OverlayEntry(
                            builder: (context) => IgnorePointer(
                              child: Material(
                                type: MaterialType.transparency,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: ConfettiWidget(
                                    confettiController: confettiController,
                                    blastDirectionality:
                                        BlastDirectionality.explosive,
                                    emissionFrequency: 0.05,
                                    numberOfParticles: 50,
                                    maxBlastForce: 5,
                                    minBlastForce: 2,
                                    gravity: 0.2,
                                    colors: [
                                      theme.colorScheme.primary,
                                      theme.colorScheme.secondary,
                                      Colors.green,
                                      Colors.blue,
                                      Colors.orange,
                                      Colors.pink,
                                      Colors.purple,
                                      Colors.yellow,
                                      Colors.red,
                                      Colors.teal,
                                      Colors.amber,
                                      Colors.cyan,
                                      Colors.lime,
                                      Colors.indigo,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );

                          final overlay =
                              Overlay.of(context, rootOverlay: true);
                          overlay.insert(entry);

                          confettiController.play();
                        },
                        child: Card(
                          shadowColor:
                              theme.colorScheme.primary.withValues(alpha: 0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: theme.colorScheme.primary
                                  .withValues(alpha: 0.2),
                              width: 1.5,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox.expand(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                switch (employee) {
                                  final empl? when empl.imageUrls.isNotEmpty =>
                                    Hero(
                                      tag: 'profile_image',
                                      child: CachedNetworkImage(
                                        alignment: Alignment.topCenter,
                                        imageUrl: empl.imageUrls.last,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                          color: Colors.grey[300],
                                          child: Icon(
                                            Icons.person,
                                            size: 48,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          color: Colors.grey[300],
                                          child: Icon(
                                            Icons.error_outline,
                                            size: 80,
                                            color: theme.colorScheme.error,
                                          ),
                                        ),
                                      ),
                                    ),
                                  _ => Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            theme.colorScheme.primary
                                                .withValues(alpha: 0.3),
                                            theme.colorScheme.primary
                                                .withValues(alpha: 0.7),
                                          ],
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        size: 120,
                                        color: theme.colorScheme.onPrimary
                                            .withValues(alpha: 0.7),
                                      ),
                                    ),
                                },
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.5, 0.9],
                                      colors: [
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.8),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(Spacers.m),
                                      child: Column(
                                        spacing: Spacers.xs,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          AutoSizeText(
                                            employee?.person.fullName ?? "",
                                            style: theme.textTheme.displaySmall
                                                ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.7),
                                                  offset: const Offset(0, 1),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                          AutoSizeText(
                                            employee?.getJobTitleText(locale) ??
                                                "",
                                            style: theme.textTheme.titleLarge
                                                ?.copyWith(
                                              color: Colors.white
                                                  .withValues(alpha: 0.9),
                                              shadows: [
                                                Shadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.7),
                                                  offset: const Offset(0, 1),
                                                  blurRadius: 4,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: Spacers.m),
                                        child: Row(
                                          spacing: Spacers.xs,
                                          children: [
                                            const HSpace.xs(),
                                            SkillChip(
                                              icon: Icons.code,
                                              label: "Flutter",
                                            ),
                                            SkillChip(
                                              icon: Icons.cloud_outlined,
                                              label: "Node.js",
                                            ),
                                            SkillChip(
                                              icon: Icons.storage_outlined,
                                              label: "Firebase",
                                            ),
                                            SkillChip(
                                              icon: Icons.dns_outlined,
                                              label: "Docker",
                                            ),
                                            SkillChip(
                                              icon: Icons.cloud_sync_outlined,
                                              label: "Kubernetes",
                                            ),
                                            SkillChip(
                                              icon: Icons.layers_outlined,
                                              label: "Solid",
                                            ),
                                            SkillChip(
                                              icon: Icons.api_outlined,
                                              label: "REST",
                                            ),
                                            SkillChip(
                                              icon: Icons.lock_outline,
                                              label: "OAuth",
                                            ),
                                            SkillChip(
                                              icon: Icons.storage,
                                              label: "SQL",
                                            ),
                                            SkillChip(
                                              icon: Icons.graphic_eq_outlined,
                                              label: "GraphQL",
                                            ),
                                            const HSpace.xs(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VSpace.l(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButton(
                        onTap: swiperController.swipeLeft,
                        icon: Icons.close,
                        color: Colors.red,
                      ),
                      const HSpace.xl(),
                      ActionButton(
                        onTap: swiperController.swipeRight,
                        icon: Icons.check,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(
          duration: Durations.medium3,
          curve: Curves.easeIn,
        );
  }
}
