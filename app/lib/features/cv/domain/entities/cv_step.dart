import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/document.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/skill.dart';

part 'cv_step.mapper.dart';

@MappableClass()
class CvStep with CvStepMappable {
  const CvStep({
    required Map<String, String> titles,
    required this.startDate,
    required this.skills,
    Map<String, String>? descriptions,
    Map<String, List<String>>? responsibilities,
    Map<String, List<Document>>? references,
    this.passed,
    this.grade,
    this.imageUrl,
    this.link,
    this.endDate,
  })  : _titles = titles,
        _descriptions = descriptions,
        _responsibilities = responsibilities,
        _references = references;

  final Map<String, String> _titles;
  final Map<String, String>? _descriptions;
  final Map<String, List<String>>? _responsibilities;
  final Map<String, List<Document>>? _references;
  final String? imageUrl;
  final String? link;
  final DateTime startDate;
  final DateTime? endDate;
  final bool? passed;
  final double? grade;
  final List<Skill>? skills;

  String getTitle(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _titles[languageCode] ?? _titles['de'] ?? '';
  }

  String? getDescription(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _descriptions?[languageCode] ?? _descriptions?['de'];
  }

  List<String> getResponsibilities(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _responsibilities?[languageCode] ?? _responsibilities?['de'] ?? [];
  }

  List<Document> getReferences(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _references?[languageCode] ?? _references?['de'] ?? [];
  }
}
