import 'package:pleasehiretolga/core/features/employee/domain/entities/skill.dart';

class SkillModel {
  SkillModel({
    required this.title,
    required this.translations,
    this.description,
    this.emoji,
    this.imageUrl,
    this.rating,
  });

  factory SkillModel.empty() => SkillModel(
        title: 'Skill',
        translations: {
          'de': {
            'title': 'Fähigkeit und so',
            'desc': 'Beschreibung und so',
          },
          'en': {
            'title': 'Skill',
            'desc': 'Description ',
          },
        },
        rating: 1.0,
      );

  SkillModel.fromEntity(Skill skill)
      : title = skill.getTitle(null),
        translations = skill.translations,
        emoji = skill.emoji,
        description = skill.getDescription(null),
        imageUrl = skill.imageUrl,
        rating = skill.rating;

  factory SkillModel.fromMap(Map<String, dynamic> map) {
    final title = map['title'] as String? ?? 'Unknown Skill';
    Map<String, Map<String, String>>? translations;

    if (map['translations'] is Map) {
      translations =
          _parseTranslations(map['translations'] as Map<String, dynamic>);
    } else {
      final possibleTranslations = <String, Map<String, String>>{};

      for (final key in map.keys) {
        if (key.length == 2 && map[key] is Map) {
          final langMap = map[key] as Map<String, dynamic>;
          final langTranslation = <String, String>{};

          if (langMap['title'] is String) {
            langTranslation['title'] = langMap['title'] as String;
          }
          if (langMap['desc'] is String) {
            langTranslation['desc'] = langMap['desc'] as String;
          }

          if (langTranslation.isNotEmpty) {
            possibleTranslations[key] = langTranslation;
          }
        }
      }

      if (possibleTranslations.isNotEmpty) {
        translations = possibleTranslations;
      }
    }

    return SkillModel(
      title: title,
      translations: translations,
      description: map['description'] as String?,
      emoji: map['emoji'] as String?,
      imageUrl: map['imageUrl'] as String?,
      rating: (map['rating'] as num?)?.toDouble(),
    );
  }

  static Map<String, Map<String, String>>? _parseTranslations(
      Map<String, dynamic>? translationsData) {
    return switch (translationsData) {
      final Map translations => {
          for (final entry in translations.entries)
            if (entry
                case MapEntry(
                  key: final String langCode,
                  value: final Map langData
                ))
              langCode: {
                if (langData['title'] case final String title) 'title': title,
                if (langData['desc'] case final String desc) 'desc': desc,
              },
        },
      _ => null,
    };
  }

  final String title;
  final Map<String, Map<String, String>>? translations;
  final String? description;
  final String? emoji;
  final String? imageUrl;
  final double? rating;

  Skill toEntity() => Skill(
        title: title,
        description: description,
        translations: translations,
        emoji: emoji,
        imageUrl: imageUrl,
        rating: rating,
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      'title': title,
      'emoji': emoji,
      'imageUrl': imageUrl,
      'rating': rating,
    };

    // Wenn es eine Beschreibung gibt, aber keine Übersetzungen
    if (description != null && translations == null) {
      result['description'] = description;
    }

    // Die Übersetzungen direkt in die Hauptebene einfügen (konsistent mit fromMap)
    if (translations != null) {
      for (final entry in translations!.entries) {
        final langCode = entry.key;
        final langData = entry.value;

        // Erstelle ein Map für den Sprachcode, falls es noch nicht existiert
        result[langCode] = <String, dynamic>{};

        // Füge die Übersetzungen hinzu
        if (langData.containsKey('title')) {
          result[langCode]['title'] = langData['title'];
        }
        if (langData.containsKey('desc')) {
          result[langCode]['desc'] = langData['desc'];
        }
      }
    }

    return result;
  }
}
