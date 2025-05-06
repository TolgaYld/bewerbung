import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/features/decision/presentation/widgets/swiper/skill_chip.widget.dart';

class SkillChipList extends HookConsumerWidget {
  const SkillChipList({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      spacing: Spacers.xs,
      children: [
        const HSpace.xs(),
        SkillChip(
          icon: null,
          iconColor: const Color(0xFF02569B),
          label: "💙 Flutter",
        ),
        SkillChip(
          icon: Icons.cloud_outlined,
          label: "Node.js",
          iconColor: const Color(0xFF339933),
        ),
        SkillChip(
          icon: null,
          label: "🔥 Firebase",
          iconColor: Color(0xFFFFCA28),
        ),
        SkillChip(
          icon: Icons.eco,
          label: "MongoDB",
          iconColor: Color(0xFF47A248),
        ),
        SkillChip(
          icon: null,
          label: "🐘 PostgreSQL",
          iconColor: Color(0xFF336791),
        ),
        SkillChip(
          icon: Icons.table_chart_rounded,
          label: "MySQL",
          iconColor: Color(0xFF00758F),
        ),
        SkillChip(
          icon: null,
          label: "🐬 MariaDB",
          iconColor: Color(0xFF003545),
        ),
        SkillChip(
          icon: null,
          label: "🐳 Docker",
          iconColor: Color(0xFF0db7ed),
        ),
        SkillChip(
          icon: null,
          label: "🧭 Kubernetes",
          iconColor: Color(0xFF326ce5),
        ),
        SkillChip(
          icon: Icons.layers_outlined,
          label: "SOLID",
          iconColor: Color(0xFF6D4C41),
        ),
        SkillChip(
          icon: Icons.api_outlined,
          label: "REST",
          iconColor: Color(0xFF2196F3),
        ),
        SkillChip(
          icon: Icons.graphic_eq_rounded,
          label: "GraphQL",
          iconColor: Color(0xFFE535AB),
        ),
        SkillChip(
          icon: Icons.hub_rounded,
          label: "gRPC",
          iconColor: Color(0xFF4285F4),
        ),
        SkillChip(
          icon: Icons.data_object_rounded,
          label: "NoSQL",
          iconColor: Color(0xFF47A248),
        ),
        SkillChip(
          icon: Icons.view_column_rounded,
          label: "SQL",
          iconColor: Color(0xFF607D8B),
        ),
        const HSpace.xs(),
      ],
    );
  }
}
