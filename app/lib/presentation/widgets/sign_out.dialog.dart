import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/presentation/mixins/dialog.mixin.dart';

class SignOutDialog extends HookConsumerWidget with ShowableDialogMixin<bool?> {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final deleteAccount = useState<bool>(false);

    return Dialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacers.s),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacers.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              l10n.signOutDialogTitle,
              style: theme.textTheme.titleLarge,
            ),
            const VSpace.m(),
            AutoSizeText(
              l10n.signOutDialogContent,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
            const VSpace.s(),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => deleteAccount.value = !deleteAccount.value,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AutoSizeText(
                      l10n.deleteAccount,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.error,
                      ),
                    ),
                    Checkbox(
                      fillColor: WidgetStateProperty.fromMap(
                        {
                          WidgetState.selected: theme.colorScheme.error,
                        },
                      ),
                      side: BorderSide(
                        color: theme.colorScheme.error,
                        width: 1,
                      ),
                      value: deleteAccount.value,
                      onChanged: (_) =>
                          deleteAccount.value = !deleteAccount.value,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: Spacers.xs,
              children: [
                TextButton(
                  onPressed: () => pop(context, deleteAccount.value),
                  child: AutoSizeText(
                    l10n.signOut,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => pop(context, null),
                  child: AutoSizeText(
                    l10n.cancel,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
