import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:url_launcher/url_launcher.dart';

class ProgressCard extends HookConsumerWidget {
  const ProgressCard({
    super.key,
    required this.title,
    required this.percentage,
    required this.index,
    this.emoji,
    this.description,
    this.urlTitle,
    this.url,
  });

  final String title;
  final int index;
  final String? description;
  final double percentage;
  final String? emoji;
  final String? urlTitle;
  final String? url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();

    return Card(
      elevation: 3,
      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Spacers.s),
      ),
      child: Padding(
        padding: const EdgeInsets.all(Spacers.s),
        child: Column(
          spacing: Spacers.xs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    spacing: Spacers.xs,
                    children: [
                      AutoSizeText(
                        emoji != null ? "$emoji $title" : title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if ((url, urlTitle) case (final url?, final urlTitle?))
                        TextButton.icon(
                          label: Text(urlTitle),
                          icon: Icon(Icons.link_outlined),
                          onPressed: () async {
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(
                                Uri.parse(url),
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ),
                AutoSizeText(
                  "${(percentage * 100).toInt()}%",
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            LinearProgressIndicator(
              value: percentage,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.1),
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(Spacers.xs),
              minHeight: 6,
            ),
            if (description case final desc?)
              AutoSizeText(
                desc,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                maxLines: null,
              ),
          ],
        ),
      ),
    ).animate().scale(
          duration: Durations.medium2,
          curve: Curves.easeOut,
          delay: Durations.short2 * index,
        );
  }
}
