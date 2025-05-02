import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/state/auth.state.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/routing/router.dart';

class QrButton extends HookConsumerWidget {
  const QrButton({
    super.key,
    required this.state,
    required this.notifier,
  });

  final AuthStateEditing state;
  final AuthNotifier notifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () async {
          final result = await context.pushNamed<String>(RoutePath.qrPage.name);
          if (result != null) {
            final username = result.split(' ').first.trim();
            final password = result.split(' ').last.trim();
            notifier.updateFields(username: username, password: password);
            await notifier.login(l10n);
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(Spacers.s),
          child: Icon(Icons.qr_code_scanner, size: 200),
        ),
      ),
    );
  }
}
