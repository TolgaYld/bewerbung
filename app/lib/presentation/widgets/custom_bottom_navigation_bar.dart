import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

typedef BottomNavItem = ({IconData icon, String label});

class CustomBottomNavBar extends HookConsumerWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final void Function(int) onTap;
  final List<BottomNavItem> items;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final animationController = useAnimationController(
      duration: Durations.short3,
      lowerBound: 0,
      upperBound: items.length.toDouble() - 1,
      initialValue: currentIndex.toDouble(),
    );

    useEffect(
      () {
        animationController.animateTo(
          currentIndex.toDouble(),
          curve: Curves.easeInOut,
        );
        return null;
      },
      [currentIndex],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / items.length;
        final indicatorWidth = itemWidth * 0.7;

        return Container(
          decoration: BoxDecoration(
            color: theme.bottomNavigationBarTheme.backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: SafeArea(
            child: SizedBox(
              height: 45,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, _) {
                      return Positioned(
                        top: 0,
                        left: (itemWidth - indicatorWidth) / 2 +
                            (animationController.value * itemWidth),
                        child: Container(
                          height: 3,
                          width: indicatorWidth,
                          decoration: BoxDecoration(
                            color: theme
                                .bottomNavigationBarTheme.selectedItemColor,
                            borderRadius: BorderRadius.circular(Spacers.xs),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (final (index, item) in items.indexed)
                        Expanded(
                          child: InkWell(
                            onTap: () => onTap(index),
                            child: Column(
                              children: [
                                const VSpace.xs(),
                                Icon(
                                  item.icon,
                                  color: switch (index == currentIndex) {
                                    true => theme.bottomNavigationBarTheme
                                        .selectedItemColor,
                                    false => theme.bottomNavigationBarTheme
                                        .unselectedItemColor,
                                  },
                                  size: 24,
                                ),
                                Text(
                                  item.label,
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: switch (index == currentIndex) {
                                      true => theme.bottomNavigationBarTheme
                                          .selectedItemColor,
                                      false => theme.bottomNavigationBarTheme
                                          .unselectedItemColor,
                                    },
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
