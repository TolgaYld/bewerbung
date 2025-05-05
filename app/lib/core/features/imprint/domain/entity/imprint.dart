import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';

part 'imprint.mapper.dart';

@MappableClass()
class Imprint with ImprintMappable {
  const Imprint({
    required this.translations,
  });

  final Map<String, Map<String, String>> translations;

  String getContact(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return translations[languageCode]?['contact'] ??
        translations['de']?['contact'] ??
        '';
  }

  String getAddress(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return translations[languageCode]?['imprint'] ??
        translations['de']?['imprint'] ??
        '';
  }
}
