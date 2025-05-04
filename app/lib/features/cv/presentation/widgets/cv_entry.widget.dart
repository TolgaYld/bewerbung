import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/document.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';
import 'package:url_launcher/url_launcher.dart';

class CvEntry extends HookConsumerWidget {
  const CvEntry({
    super.key,
    required this.title,
    required this.subtitle,
    required this.monthYear,
    this.references,
    this.description,
    this.completed,
    this.pictureUri,
    this.link,
  });

  final String title;
  final String subtitle;
  final String monthYear;
  final List<Document>? references;
  final bool? completed;
  final String? description;
  final String? pictureUri;
  final String? link;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    final l10n = useL10n();
    final isExpanded = useState<bool>(false);

    final enableCollapseMode = switch (description) {
      final desc? => '\n\n'.allMatches(desc).length + 1,
      _ => 0
    };
    final shouldExpandCollapse = enableCollapseMode > 2;

    return Padding(
      padding: EdgeInsets.only(bottom: Spacers.s),
      child: Card(
        child: InkWell(
          splashFactory: InkSplash.splashFactory,
          borderRadius: BorderRadius.circular(Spacers.s),
          onTap: shouldExpandCollapse
              ? () => isExpanded.value = !isExpanded.value
              : null,
          child: Padding(
            padding: const EdgeInsets.all(Spacers.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(
                                  title,
                                  softWrap: true,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                AutoSizeText(
                                  softWrap: false,
                                  monthYear,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (pictureUri case final uri?) ...[
                            const HSpace.s(),
                            Card(
                              color: theme.colorScheme.primary
                                  .withValues(alpha: 0.45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Spacers.xs),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Spacers.xs),
                                child: CachedNetworkImage(
                                  imageUrl: uri,
                                  width: 40,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ],
                          if (link case final url?) ...[
                            const HSpace.xs(),
                            IconButton(
                              constraints: const BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.link,
                                color: theme.colorScheme.primary,
                                size: 20,
                              ),
                              onPressed: () async =>
                                  await launchUrl(Uri.parse(url)),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (shouldExpandCollapse)
                      AnimatedRotation(
                        turns: isExpanded.value ? 0.5 : 0,
                        duration: Durations.short3,
                        curve: Curves.easeInOut,
                        child: Icon(
                          Icons.expand_more,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                  ],
                ),
                const VSpace.xs(),
                AutoSizeText(
                  "$subtitle${completed == false ? " - ${l10n.noDegree}" : ""}",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                if (description case final desc? when desc.isNotEmpty) ...[
                  const VSpace.s(),
                  Builder(
                    builder: (context) {
                      final enableCollapseMode =
                          '\n\n'.allMatches(desc).length + 1;
                      if (enableCollapseMode <= 2) {
                        return AutoSizeText(
                          desc,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                          softWrap: true,
                        );
                      }
                      return AnimatedCrossFade(
                        firstChild: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: switch (kIsWeb) {
                            true => AutoSizeText(
                                (() {
                                  final paragraphs = desc.split('\n\n');
                                  return paragraphs.length > 2
                                      ? paragraphs.take(2).join('\n\n')
                                      : desc;
                                })(),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                                softWrap: true,
                              ),
                            false => ShaderMask(
                                shaderCallback: (Rect bounds) {
                                  return LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      theme.colorScheme.primary,
                                      Colors.transparent,
                                    ],
                                  ).createShader(bounds);
                                },
                                blendMode: BlendMode.dstIn,
                                child: AutoSizeText(
                                  desc,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurface,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                          },
                        ),
                        secondChild: AutoSizeText(
                          desc,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ),
                          softWrap: true,
                        ),
                        crossFadeState: isExpanded.value
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Durations.short3,
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
