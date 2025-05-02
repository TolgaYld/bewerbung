import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/widgets/mobile/qr_button.widget.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_responsive.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

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
    final l10n = useL10n();
    final colorScheme = useColorScheme();
    final responsive = useResponsive();
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final obscurePw = useState(true);
    return switch ((responsive.type, state)) {
      (
        DeviceType.mobile || DeviceType.tablet,
        final AuthStateEditing editingState
      )
          when editingState.qrMode =>
        QrButton(state: editingState, notifier: notifier),
      _ => IgnorePointer(
          ignoring: state is AuthStateLoading,
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
                onChanged: (value) => notifier.updateFields(
                  username: value,
                  password: passwordController.text,
                ),
                decoration: InputDecoration(
                  labelText: l10n.username,
                  hintText: l10n.username,
                ),
              ),
              const VSpace.s(),
              TextFormField(
                controller: passwordController,
                onChanged: (value) => notifier.updateFields(
                  username: usernameController.text,
                  password: value,
                ),
                decoration: InputDecoration(
                  labelText: l10n.password,
                  hintText: l10n.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      color: colorScheme.primary,
                      obscurePw.value ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => obscurePw.value = !obscurePw.value,
                  ),
                ),
                obscureText: obscurePw.value,
              ),
              const VSpace.x2l(),
              ElevatedButton.icon(
                onPressed: () async => notifier.login(l10n),
                icon: state is AuthStateLoading
                    ? const SizedBox.shrink()
                    : const Icon(Icons.login),
                label: switch (state) {
                  AuthStateLoading() => SizedBox(
                      width: Spacers.xl,
                      height: Spacers.xl,
                      child: CircularProgressIndicator(
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  _ => AutoSizeText(l10n.login),
                },
              ),
            ],
          ),
        ),
    };
  }
}
