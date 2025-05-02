import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:pleasehiretolga/core/localization/localizations.dart';

part 'decision_status.enum.mapper.dart';

@MappableEnum()
enum DecisionStatus {
  pending(
    colorValue: 0xFF9E9E9E,
    icon: Icons.hourglass_empty_rounded,
  ),
  invited(
    colorValue: 0xFF4CAF50,
    icon: Icons.check_circle_rounded,
  ),
  rejected(
    colorValue: 0xFFF44336,
    icon: Icons.cancel_rounded,
  );

  const DecisionStatus({
    required this.colorValue,
    required this.icon,
  });

  final int colorValue;
  final IconData icon;

  Color get color => Color(colorValue);

  String getLocalizedLabel(L10n l10n) => switch (this) {
        DecisionStatus.pending => l10n.pending,
        DecisionStatus.invited => l10n.invited,
        DecisionStatus.rejected => l10n.rejected,
      };
}
