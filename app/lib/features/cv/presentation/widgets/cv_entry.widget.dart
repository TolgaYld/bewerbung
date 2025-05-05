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
import 'package:pleasehiretolga/presentation/widgets/dialogs/external_link.dialog.dart';
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
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashFactory: InkSplash.splashFactory,
          borderRadius: BorderRadius.circular(Spacers.s),
          onTap: shouldExpandCollapse
              ? () => isExpanded.value = !isExpanded.value
              : null,
          child: Column(
            children: [
              Padding(
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
                                      style:
                                          theme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    Row(
                                      spacing: Spacers.xxs,
                                      children: [
                                        Icon(
                                          Icons.calendar_today_rounded,
                                          color: theme.colorScheme.onSurface
                                              .withValues(alpha: 0.5),
                                          size: 15,
                                        ),
                                        AutoSizeText(
                                          softWrap: false,
                                          monthYear,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: theme.colorScheme.onSurface
                                                .withValues(alpha: 0.5),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
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
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: Spacers.xs,
                      children: [
                        if (pictureUri case final uri?) ...[
                          Padding(
                            padding: const EdgeInsets.all(Spacers.xs),
                            child: CachedNetworkImage(
                              imageUrl: uri,
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                        if (link case final link?) ...[
                          IconButton(
                            style: IconButton.styleFrom(
                              foregroundColor: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                            iconSize: 20,
                            icon: const Icon(Icons.link_rounded),
                            onPressed: () async {
                              final result =
                                  await ExternalLinkDialog().show(context);
                              if (result == true) {
                                if (await canLaunchUrl(Uri.parse(link))) {
                                  await launchUrl(Uri.parse(link));
                                }
                              }
                            },
                          ),
                        ],
                        if (references case final refs?
                            when refs.isNotEmpty) ...[
                          for (final reference in refs) ...[
                            TextButton.icon(
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.5),
                                iconSize: 20,
                              ),
                              label: AutoSizeText(
                                reference.title ?? "",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              icon: const Icon(Icons.download_rounded),
                              onPressed: () async {
                                if (reference.url case final url?) {
                                  if (await canLaunchUrl(Uri.parse(url))) {
                                    await launchUrl(Uri.parse(url));
                                  }
                                }
                              },
                            ),
                          ],
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
