import 'package:auto_size_text/auto_size_text.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/utils/extensions/confetti.extension.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/action_button.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/swiper/decision_card.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/dialogs/status_overlay.dialog.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/status_badge.widget.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/swiper/swiper.widget.dart';

class DecisionPageWeb extends HookConsumerWidget {
  const DecisionPageWeb({
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

    final screenSize = MediaQuery.sizeOf(context);
    final swiperController = useMemoized(() => SwiperController(), []);

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Spacers.m),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacers.s),
                child: AutoSizeText(
                  l10n.webButtonHeadline,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const VSpace.xs(),
              AutoSizeText(
                l10n.webButtonInstruction,
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
                              padding: const EdgeInsets.only(right: Spacers.m),
                              child: DecisionStatusBadge(
                                company: company,
                                onTap: () async =>
                                    StatusOverlayDialog(company: company)
                                        .show(context),
                              ),
                            ),
                          ),
                          const VSpace.xs(),
                        ],
                      )
                    : const SizedBox(key: ValueKey(false)),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 300,
                  maxWidth: 600,
                  maxHeight: screenSize.height * 0.6,
                ),
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
    );
  }
}
