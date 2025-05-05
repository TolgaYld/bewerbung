import 'package:pleasehiretolga/core/features/imprint/domain/entity/imprint.dart';

class ImprintModel {
  ImprintModel({required this.translations});

  factory ImprintModel.empty() => ImprintModel(
        translations: {},
      );

  factory ImprintModel.fromMap(Map<String, dynamic> map) {
    final translations = <String, Map<String, String>>{};

    if (map['translations'] is Map) {
      final translationsMap = map['translations'] as Map<String, dynamic>;

      translationsMap.forEach((langCode, value) {
        if (value is Map<String, dynamic>) {
          translations[langCode] = {};

          if (value['contact'] is String) {
            translations[langCode]?['contact'] = value['contact'] as String;
          }

          if (value['imprint'] is String) {
            translations[langCode]?['imprint'] = value['imprint'] as String;
          }
        }
      });
    }

    return ImprintModel(
      translations: translations,
    );
  }

  final Map<String, Map<String, String>> translations;

  Imprint toEntity() => Imprint(
        translations: translations,
      );

  Map<String, dynamic> toMap() {
    return {
      'translations': translations,
    };
  }
}
