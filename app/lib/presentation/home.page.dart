import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
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
    final theme = useTheme();
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

    final tabController = useTabController(
      initialLength: navItems.length,
      initialIndex: navigationShell.currentIndex < navItems.length
          ? navigationShell.currentIndex
          : 0,
    );

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

    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.applicationToCompany(company?.name ?? '')),
          centerTitle: kIsWeb,
          bottom: TabBar(
            controller: tabController,
            tabs: [
              for (final item in navItems)
                Tab(
                  icon: Icon(item.icon),
                  text: item.label,
                ),
            ],
            onTap: onTabSelected,
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: theme.colorScheme.surface,
            unselectedLabelColor: theme.colorScheme.surface,
            indicatorColor: theme.colorScheme.surface,
          ),
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
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 800,
                    minHeight: 600,
                    maxWidth:
                        constraints.maxWidth < 800 ? 800 : constraints.maxWidth,
                    maxHeight: constraints.maxHeight < 600
                        ? 600
                        : constraints.maxHeight,
                  ),
                  child: Center(
                    child: SizedBox(
                      width: getVisualIndex(navigationShell.currentIndex) == 3
                          ? double.infinity
                          : 1200,
                      height: constraints.maxHeight,
                      child: navigationShell,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
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
            icon: const Icon(Icons.logout),
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
