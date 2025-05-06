import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/enums/decision_status.enum.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_confetti.hook.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/mobile/decision_page_mobile.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/web/decision_page_web.widget.dart';

class DecisionPage extends HookConsumerWidget {
  const DecisionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(companyProvider).valueOrNull;
    final confettiController =
        useConfettiController(duration: Durations.extralong1);

    final showBadge =
        company != null && company.decisionStatus != DecisionStatus.pending;

    return Scaffold(
      body: SafeArea(
        child: switch ((kIsWeb, company)) {
          (true, final company?) => DecisionPageWeb(
              confettiController: confettiController,
              showBadge: showBadge,
              company: company,
            ),
          (false, final company?) => DecisionPageMobile(
              confettiController: confettiController,
              company: company,
              showBadge: showBadge,
            ),
          _ => SizedBox()
        },
      ),
    ).animate().fadeIn(
          duration: Durations.medium3,
          curve: Curves.easeIn,
        );
  }
}
