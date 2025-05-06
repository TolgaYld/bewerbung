import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/hooks/use_theme.hook.dart';

class LoadNetworkImage extends HookConsumerWidget {
  const LoadNetworkImage({
    super.key,
    this.imageUrl,
    this.iconSize,
  });

  final String? imageUrl;
  final double? iconSize;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = useTheme();
    return switch (imageUrl) {
      final url? => Hero(
          tag: 'profile_image',
          child: CachedNetworkImage(
            alignment: Alignment.topCenter,
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[300],
              child: Icon(
                Icons.person,
                size: iconSize ?? 48,
                color: Colors.grey,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[300],
              child: Icon(
                Icons.error_outline,
                size: iconSize ?? 80,
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ),
      _ => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.3),
                theme.colorScheme.primary.withValues(alpha: 0.7),
              ],
            ),
          ),
          child: Icon(
            Icons.person,
            size: iconSize ?? 80,
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.7),
          ),
        ),
    };
  }
}
