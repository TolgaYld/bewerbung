import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';

part 'skill.mapper.dart';

@MappableClass()
class Skill with SkillMappable {
  const Skill({
    required String title,
    String? description,
    this.translations,
    this.emoji,
    this.imageUrl,
    this.rating,
  })  : _title = title,
        _description = description;

  final String _title;
  final Map<String, Map<String, String>>? translations;
  final String? _description;
  final String? imageUrl;
  final String? emoji;
  final double? rating;

  String getTitle(Locale? locale) {
    if (translations == null) {
      return _title;
    }

    final languageCode = locale?.languageCode ?? 'de';
    return translations?[languageCode]?['title'] ?? _title;
  }

  String? getDescription(Locale? locale) {
    if (translations == null) {
      return _description;
    }

    final languageCode = locale?.languageCode ?? 'de';
    return translations?[languageCode]?['desc'] ?? _description;
  }
}
