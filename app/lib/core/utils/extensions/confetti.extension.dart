import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

extension ConfettiExtension on BuildContext {
  void showConfetti({
    required ConfettiController confettiController,
    Alignment alignment = Alignment.topCenter,
    double emissionFrequency = 0.05,
    int numberOfParticles = 50,
    double maxBlastForce = 5,
    double minBlastForce = 2,
    double gravity = 0.2,
    List<Color>? colors,
  }) {
    final theme = Theme.of(this);
    final defaultColors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.pink,
      Colors.purple,
      Colors.yellow,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.cyan,
      Colors.lime,
      Colors.indigo,
    ];

    final entry = OverlayEntry(
      builder: (context) => IgnorePointer(
        child: Material(
          type: MaterialType.transparency,
          child: Align(
            alignment: alignment,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              emissionFrequency: emissionFrequency,
              numberOfParticles: numberOfParticles,
              maxBlastForce: maxBlastForce,
              minBlastForce: minBlastForce,
              gravity: gravity,
              colors: colors ?? defaultColors,
            ),
          ),
        ),
      ),
    );

    Overlay.of(this, rootOverlay: true).insert(entry);
    confettiController.play();

    Future.delayed(Duration(seconds: 9), () {
      if (entry.mounted) {
        entry.remove();
      }
    });
  }
}
