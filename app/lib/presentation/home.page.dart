import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/features/cover_letter/provider/cover_letter.provider.dart';
import 'package:pleasehiretolga/core/presentation/widgets/language_switcher.widget.dart';
import 'package:pleasehiretolga/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:pleasehiretolga/presentation/widgets/sign_out.dialog.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({
    super.key,
    required this.navigationShell,
  });
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final company = ref.watch(companyProvider).valueOrNull;
    final coverLetter = ref.watch(coverLetterProvider).valueOrNull;
    final notifier = ref.watch(authStateProvider.notifier);

    final navItems = [
      (icon: Icons.account_circle, label: l10n.aboutMe),
      (icon: Icons.description, label: l10n.cv),
      if (coverLetter != null || kReleaseMode == false)
        (icon: Icons.article, label: l10n.coverLetter),
      (icon: Icons.question_mark_rounded, label: l10n.invite),
    ];

    void onTabSelected(int index) {
      int branchIndex = index;
      if ((coverLetter == null && kReleaseMode) && index >= 2) {
        branchIndex = index + 1;
      }

      navigationShell.goBranch(
        branchIndex,
        initialLocation: branchIndex == navigationShell.currentIndex,
      );
    }

    int getVisualIndex(int branchIndex) {
      if ((coverLetter == null && kReleaseMode) && branchIndex > 2) {
        return branchIndex - 1;
      }
      return branchIndex;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.applicationToCompany(company?.name ?? '')),
        centerTitle: false,
        actions: [
          LanguageSwitcher(),
          const HSpace.xs(),
          IconButton(
            onPressed: () async {
              final result = await SignOutDialog().show(context);
              if (result == true) {
                await notifier.signOut(true);
              } else if (result == false) {
                await notifier.signOut(false);
              }
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: getVisualIndex(navigationShell.currentIndex),
        onTap: onTabSelected,
        items: navItems,
      ),
    );
  }
}
