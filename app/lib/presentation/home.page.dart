import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/auth/presentation/auth.notifier.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';
import 'package:pleasehiretolga/core/features/employee/provider/employee.provider.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:pleasehiretolga/core/routing/router.dart';
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
    final employee = ref.watch(employeeProvider).valueOrNull;
    final coverLetter = ref.watch(coverLetterProvider).valueOrNull;
    final notifier = ref.watch(authStateProvider.notifier);
    final bool showCoverLetter = coverLetter != null || kReleaseMode == false;

    final navItems = [
      (icon: Icons.account_circle, label: l10n.aboutMe),
      (icon: Icons.description, label: l10n.cv),
      if (showCoverLetter) (icon: Icons.article, label: l10n.coverLetter),
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
      if (showCoverLetter == false && index >= 2) {
        branchIndex = index + 1;
      }

      navigationShell.goBranch(
        branchIndex,
        initialLocation: branchIndex == navigationShell.currentIndex,
      );
    }

    int getVisualIndex(int branchIndex) {
      if (showCoverLetter == false && branchIndex >= 2) {
        return branchIndex - 1;
      }
      return branchIndex;
    }

    useEffect(
      () {
        if (showCoverLetter == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(RoutePath.aboutMe.path);
          });
        }
        return null;
      },
      [showCoverLetter],
    );

    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.applicationToCompany(company?.name ?? '')),
          centerTitle: kIsWeb,
          bottom: TabBar(
            key: ValueKey(navItems.length),
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
            indicatorColor: theme.colorScheme.secondary,
            indicatorWeight: 7,
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
        body: Column(
          children: [
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: SizedBox.expand(
                    child: navigationShell,
                  ),
                ),
              ),
            ),
            const Divider(height: 1),
            Container(
              width: double.infinity,
              color: theme.colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.all(Spacers.xs),
                child: GestureDetector(
                  onTap: () => context.go('/impressum'),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        l10n.imprint,
                        style: theme.textTheme.bodySmall?.copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: theme.colorScheme.surface,
                          color: theme.colorScheme.surface,
                        ),
                      ),
                      Text(
                        l10n.copyright(employee?.person.fullName ?? ''),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.surface,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
        key: ValueKey(navItems.length),
        currentIndex: getVisualIndex(navigationShell.currentIndex),
        onTap: onTabSelected,
        items: navItems,
      ),
    );
  }
}
