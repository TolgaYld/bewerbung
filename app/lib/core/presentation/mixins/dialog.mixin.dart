import 'package:flutter/material.dart';

mixin ShowableDialogMixin<T> on Widget {
  Future<T?> show(
    BuildContext context, {
    bool useAnimation = true,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        customTransitionBuilder,
  }) {
    if (useAnimation == false) {
      return showDialog<T>(
        context: context,
        builder: (context) => this,
      );
    }

    return showGeneralDialog<T>(
      context: context,
      barrierLabel: 'Dialog',
      barrierDismissible: true,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: Durations.medium4,
      pageBuilder: (context, anim1, anim2) => this,
      transitionBuilder: customTransitionBuilder ??
          (context, anim1, anim2, child) {
            final curvedAnim = CurvedAnimation(
              parent: anim1,
              curve: Curves.easeOutExpo,
            );

            return FadeTransition(
              opacity: curvedAnim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1.0),
                  end: Offset.zero,
                ).animate(curvedAnim),
                child: child,
              ),
            );
          },
    );
  }

  Future<T?> showBarrierDisabled(
    BuildContext context, {
    bool useAnimation = false,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        customTransitionBuilder,
  }) {
    if (useAnimation == false) {
      return showDialog<T>(
        context: context,
        builder: (context) => this,
        barrierDismissible: false,
      );
    }

    return showGeneralDialog<T>(
      context: context,
      barrierLabel: 'Dialog',
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      transitionDuration: Durations.medium4,
      pageBuilder: (context, anim1, anim2) => this,
      transitionBuilder: customTransitionBuilder ??
          (context, anim1, anim2, child) {
            final curvedAnim = CurvedAnimation(
              parent: anim1,
              curve: Curves.easeOutExpo,
            );

            return FadeTransition(
              opacity: curvedAnim,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1.0),
                  end: Offset.zero,
                ).animate(curvedAnim),
                child: child,
              ),
            );
          },
    );
  }

  void pop(BuildContext context, T value) {
    Navigator.pop<T>(context, value);
  }
}
