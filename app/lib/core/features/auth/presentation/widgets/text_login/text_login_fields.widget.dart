import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

class TextLoginFields extends HookConsumerWidget {
  const TextLoginFields({
    super.key,
    required this.state,
    required this.notifier,
  });
  final AuthState state;
  final AuthNotifier notifier;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final theme = useTheme();
    final colorScheme = theme.colorScheme;
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final usernameFocus = useFocusNode();
    final passwordFocus = useFocusNode();
    final obscurePw = useState(true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: usernameController,
          focusNode: usernameFocus,
          onChanged: (value) => notifier.updateFields(
            username: value,
            password: passwordController.text,
          ),
          onFieldSubmitted: (_) {
            usernameFocus.unfocus();
            FocusScope.of(context).requestFocus(passwordFocus);
          },
          decoration: InputDecoration(
            labelText: l10n.username,
            hintText: l10n.username,
            prefixIcon: Icon(
              Icons.person,
              color: colorScheme.primary,
            ),
          ),
        )
            .animate()
            .fadeIn(
              duration: Durations.medium4,
              curve: Curves.easeOutQuad,
            )
            .slideX(
              begin: -0.1,
              end: 0,
              duration: Durations.medium4,
              curve: Curves.easeOutQuad,
            ),
        const VSpace.m(),
        TextFormField(
          controller: passwordController,
          focusNode: passwordFocus,
          onChanged: (value) => notifier.updateFields(
            username: usernameController.text,
            password: value,
          ),
          decoration: InputDecoration(
            labelText: l10n.password,
            hintText: l10n.password,
            prefixIcon: Icon(Icons.lock, color: colorScheme.primary),
            suffixIcon: IconButton(
              icon: Icon(
                color: colorScheme.primary,
                obscurePw.value ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () => obscurePw.value = !obscurePw.value,
            ),
          ),
          onFieldSubmitted: (_) async {
            passwordFocus.unfocus();
            await notifier.login(l10n);
          },
          obscureText: obscurePw.value,
        )
            .animate()
            .fadeIn(
              delay: Durations.short2,
              duration: Durations.medium4,
              curve: Curves.easeOutQuad,
            )
            .slideX(
              begin: -0.1,
              end: 0,
              delay: Durations.short2,
              duration: Durations.medium4,
              curve: Curves.easeOutQuad,
            ),
        const VSpace.x2l(),
        ElevatedButton.icon(
          onPressed: switch (state) {
            AuthStateLoading() => null,
            _ => () async => notifier.login(l10n),
          },
          icon: switch (state) {
            AuthStateLoading() => const SizedBox(),
            _ => const Icon(Icons.login),
          },
          label: switch (state) {
            AuthStateLoading() => CircularProgressIndicator(
                color: theme.colorScheme.onPrimary,
              ),
            _ => AutoSizeText(
                l10n.login,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
          },
        )
            .animate()
            .fadeIn(
              delay: Durations.short4,
              duration: Durations.medium4,
              curve: Curves.easeOutQuad,
            )
            .slideY(
              begin: 0.3,
              end: 0,
              delay: Durations.short4,
              duration: Durations.long2,
              curve: Curves.easeOutBack,
            ),
      ],
    );
  }
}
