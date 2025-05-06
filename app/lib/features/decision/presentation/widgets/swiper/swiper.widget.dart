import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/constants/datetime_formatter.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';
import 'package:pleasehiretolga/features/decision/presentation/decision.notifier.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/dialogs/appointment_confirmation.dialog.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/dialogs/decision.dialog.dart';

class SwiperController {
  Function()? _swipeLeft;
  Function()? _swipeRight;

  void swipeLeft() => _swipeLeft?.call();
  void swipeRight() => _swipeRight?.call();

  void _attachFunctions(Function() left, Function() right) {
    _swipeLeft = left;
    _swipeRight = right;
  }
}

class Swiper extends HookConsumerWidget {
  const Swiper({
    super.key,
    required this.child,
    required this.companyId,
    this.onRightSwipe,
    this.controller,
  });

  final Widget child;
  final VoidCallback? onRightSwipe;
  final SwiperController? controller;
  final String? companyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final locale = ref.watch(localeProvider);
    final notifier = ref.watch(decisionStateProvider.notifier);
    final screenWidth = MediaQuery.sizeOf(context).width;

    final position = useState<Offset>(Offset.zero);
    final rotation = useState<double>(0.0);
    final isDragging = useState<bool>(false);

    final animationController =
        useAnimationController(duration: Durations.long4);
    final animationData = useState<Animation<Offset>?>(null);

    String formatDateTimeCombi(DateTime dateTime) =>
        DateTimeFormatter.formatDateTimeCombined(
          dateTime,
          locale: locale?.languageCode,
        );

    void listener() {
      final currentAnimation = animationData.value;
      if (currentAnimation != null) {
        position.value = currentAnimation.value;
        rotation.value = 0.002 * position.value.dx;
      }
    }

    Future<void> resetPosition() async {
      final animation = Tween<Offset>(
        begin: position.value,
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOutBack,
        ),
      );

      animationData.value = animation;
      await animationController.forward(from: 0);
    }

    Future<void> animateSwipe(double targetX) async {
      final endPosition = Offset(targetX, 0);
      final animation = Tween<Offset>(
        begin: position.value,
        end: endPosition,
      ).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOutExpo,
        ),
      );

      animationData.value = animation;
      await animationController.forward(from: 0);
    }

    Future<void> handleSwipe({required bool isInvite}) async {
      if (isInvite) {
        await animateSwipe(screenWidth * 1.5);
      } else {
        await animateSwipe(-screenWidth * 1.5);
      }
      if (context.mounted) {
        final result = await DecisionDialog(
          invite: isInvite,
          title: isInvite ? l10n.inviteDialogTitle : l10n.refuseDialogTitle,
          content:
              isInvite ? l10n.inviteDialogContent : l10n.refuseDialogContent,
        ).show(context);

        final status =
            isInvite ? DecisionStatus.invited : DecisionStatus.rejected;
        final explanation = result?.explanation;

        if (companyId case final id? when result != null) {
          final formattedDateTime = switch (result.appointmentDateTime) {
            final dateTime? when isInvite => formatDateTimeCombi(dateTime),
            _ => null,
          };

          await notifier.setDecisionOptions(
            employeeId: id,
            status: status,
            inviteDate: isInvite ? result.appointmentDateTime : null,
            decisionMessage: explanation,
            inviteDuration:
                null, // maybe to much inputs for companies (??)... and maybe i implement that in the future
          );

          if (isInvite) {
            onRightSwipe?.call();
            if (context.mounted) {
              await AppointmentConfirmationDialog(
                formattedDate: formattedDateTime,
                explanation: explanation,
              ).show(context);
            }
          }
        }

        await resetPosition();
      }
    }

    useEffect(
      () {
        animationController.addListener(listener);
        if (controller case final contr?) {
          contr._attachFunctions(
            () async => await handleSwipe(isInvite: false),
            () async => await handleSwipe(isInvite: true),
          );
        }
        return () => animationController.removeListener(listener);
      },
      [animationController, controller],
    );

    final likeOpacity =
        (position.value.dx / (screenWidth * (kIsWeb ? 0.12 : 0.5)))
            .clamp(0.0, 1.0);
    final dislikeOpacity =
        (-position.value.dx / (screenWidth * (kIsWeb ? 0.12 : 0.5)))
            .clamp(0.0, 1.0);

    return GestureDetector(
      onPanStart: (_) {
        isDragging.value = true;
        animationController.stop();
      },
      onPanUpdate: (DragUpdateDetails details) {
        position.value += details.delta;
        rotation.value = 0.002 * position.value.dx;
      },
      onPanEnd: (_) async {
        isDragging.value = false;
        const acceptSwipe = kIsWeb ? 0.2 : 0.5;

        switch (position.value.dx.abs() > screenWidth * acceptSwipe) {
          case true when position.value.dx > 0:
            await handleSwipe(isInvite: true);
            break;
          case true:
            await handleSwipe(isInvite: false);
            break;
          case false:
            await resetPosition();
            break;
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.translate(
            offset: position.value,
            child: Transform.rotate(
              angle: rotation.value,
              child: child,
            ),
          )
              .animate()
              .fadeIn(
                duration: Durations.medium3,
                curve: Curves.easeIn,
              )
              .scale(
                end: const Offset(1.0, 1.0),
                duration: Durations.medium3,
                curve: Curves.easeOutBack,
              ),
          Positioned(
            top: 40,
            right: 40,
            child: Transform.rotate(
              angle: -0.2,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacers.m,
                  vertical: Spacers.s,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(Spacers.s),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 24,
                    ),
                    const HSpace.xs(),
                    AutoSizeText(
                      l10n.invite.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: Durations.short2,
                  )
                  .custom(
                    builder: (context, value, child) => Opacity(
                      opacity: likeOpacity,
                      child: child,
                    ),
                  ),
            ),
          ),
          Positioned(
            top: 40,
            left: 40,
            child: Transform.rotate(
              angle: 0.2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Spacers.m,
                  vertical: Spacers.s,
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                    const HSpace.xs(),
                    AutoSizeText(
                      l10n.refuse.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
                  .animate()
                  .fadeIn(
                    duration: Durations.short2,
                  )
                  .custom(
                    builder: (context, value, child) => Opacity(
                      opacity: dislikeOpacity,
                      child: child,
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
