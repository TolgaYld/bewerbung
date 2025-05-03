import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/spacing.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

class HeaderPart extends HookConsumerWidget {
  const HeaderPart({
    super.key,
    required this.name,
    required this.position,
    this.address,
    this.date,
    this.imageUrl,
  });

  final String name;
  final String position;
  final String? date;
  final String? address;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    name,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const VSpace.xxs(),
                  AutoSizeText(
                    position,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (address case final addr?) ...[
                    const VSpace.s(),
                    AutoSizeText(
                      addr,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (imageUrl case final url?) ...[
              const HSpace.s(),
              Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Spacers.m),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                    errorWidget: (context, _, __) => Container(
                      width: 80,
                      height: 80,
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      child: Icon(
                        Icons.business_rounded,
                        size: 40,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: AutoSizeText(
            date ?? '',
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }
}
