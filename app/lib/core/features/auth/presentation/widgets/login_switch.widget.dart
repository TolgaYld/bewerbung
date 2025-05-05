import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/widgets/qr_mode/qr_button.widget.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/widgets/text_login/text_login_fields.widget.dart';
import 'package:pleasehiretolga/core/hooks/use_responsive.hook.dart';

class LoginSwitchWidget extends HookConsumerWidget {
  const LoginSwitchWidget({
    super.key,
    required this.state,
    required this.notifier,
  });

  final AuthState state;
  final AuthNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final responsive = useResponsive();
    final isQrMode = switch (state) {
      final AuthStateEditing s
          when s.qrMode &&
              (responsive.type == DeviceType.mobile ||
                  responsive.type == DeviceType.tablet) =>
        true,
      _ => false
    };
    const cardWidth = 400.0;
    const cardHeight = 280.0;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        key: ValueKey(isQrMode ? 'qr_mode' : 'login_card'),
        child: Padding(
          padding: EdgeInsets.all(Spacers.m),
          child: switch (isQrMode) {
            false => TextLoginFields(
                state: state,
                notifier: notifier,
              ),
            true => QrButton(
                state: state,
                notifier: notifier,
              ),
          },
        ),
      ).animate().scale(
            duration: Durations.medium4,
            curve: Curves.easeOutBack,
            begin: const Offset(0.95, 0.95),
            end: const Offset(1.0, 1.0),
          ),
    );
  }
}
