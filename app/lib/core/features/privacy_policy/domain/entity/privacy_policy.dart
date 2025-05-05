import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';

part 'privacy_policy.mapper.dart';

@MappableClass()
class PrivacyPolicy with PrivacyPolicyMappable {
  const PrivacyPolicy({
    required Map<String, String> content,
  }) : _content = content;

  final Map<String, String> _content;

  String getContent(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _content[languageCode] ?? _content['de'] ?? '';
  }
}
