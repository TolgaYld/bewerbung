import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/utils/extensions/confetti.extension.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/action_button.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/swiper/decision_card.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/status_badge.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/dialogs/status_overlay.dialog.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/swiper/swiper.widget.dart';

class DecisionPageMobile extends HookConsumerWidget {
  const DecisionPageMobile({
    super.key,
    required this.confettiController,
    required this.showBadge,
    required this.company,
  });

  final ConfettiController confettiController;
  final bool showBadge;
  final Company company;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();

    final swiperController = useMemoized(() => SwiperController(), []);
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Spacers.m),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Spacers.s),
                    child: AutoSizeText(
                      l10n.mobileSwipeHeadline,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const VSpace.xs(),
                  AutoSizeText(
                    l10n.mobileSwipeInstruction,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const VSpace.xs(),
                  AnimatedSwitcher(
                    duration: Durations.medium3,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.1),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: showBadge
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                key: const ValueKey(true),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: Spacers.m),
                                  child: DecisionStatusBadge(
                                    company: company,
                                    onTap: () async =>
                                        StatusOverlayDialog(company: company)
                                            .show(context),
                                  ),
                                ),
                              ),
                              if (height > 640) const VSpace.xs(),
                            ],
                          )
                        : const SizedBox(key: ValueKey(false)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  const minCardWidth = 320.0;
                  const minCardHeight = minCardWidth * 4 / 3;
                  const minButtonScale = 0.7;
                  const buttonBaseHeight = 56.0;
                  const verticalSpacing = 12.0;
                  final maxWidth = constraints.maxWidth;
                  final maxHeight = constraints.maxHeight;
                  final minButtonHeight = buttonBaseHeight * minButtonScale;
                  final availCardHeight =
                      maxHeight - minButtonHeight - verticalSpacing;
                  final widthByHeight = availCardHeight * 3 / 4;
                  final widthByScreen = maxWidth * 0.9;
                  double cardWidth = math.max(
                    minCardWidth,
                    math.min(widthByHeight, widthByScreen),
                  );
                  double cardHeight =
                      math.max(minCardHeight, cardWidth * 4 / 3);
                  final buttonScale =
                      (cardWidth / 400).clamp(minButtonScale, 1.0);
                  final buttonHeight = buttonBaseHeight * buttonScale;
                  final totalNeed = cardHeight + verticalSpacing + buttonHeight;
                  if (totalNeed > maxHeight) {
                    final shrink = maxHeight / totalNeed;
                    cardWidth = math.max(minCardWidth, cardWidth * shrink);
                    cardHeight = math.max(minCardHeight, cardHeight * shrink);
                  }
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: cardWidth,
                            height: cardHeight,
                            child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Swiper(
                                companyId: company.id,
                                controller: swiperController,
                                onRightSwipe: () => context.showConfetti(
                                  confettiController: confettiController,
                                ),
                                child: DecisionCard(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: buttonScale * Spacers.xs),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Transform.scale(
                          scale: buttonScale,
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: buttonScale *
                                  (height > 640 ? Spacers.s : Spacers.xs),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ActionButton(
                                  onTap: swiperController.swipeLeft,
                                  icon: Icons.close,
                                  color: Colors.red,
                                ),
                                SizedBox(width: 60 * buttonScale),
                                ActionButton(
                                  onTap: swiperController.swipeRight,
                                  icon: Icons.check,
                                  color: Colors.green,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(
          duration: Durations.medium3,
          curve: Curves.easeIn,
        );
  }
}
