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
    this.passed,
    this.grade,
    this.imageUrl,
    this.link,
    this.documents,
    this.endDate,
  })  : _titles = titles,
        _descriptions = descriptions,
        _responsibilities = responsibilities;

  final Map<String, String> _titles;
  final Map<String, String>? _descriptions;
  final Map<String, List<String>>? _responsibilities;
  final String? imageUrl;
  final String? link;
  final DateTime startDate;
  final DateTime? endDate;
  final bool? passed;
  final double? grade;
  final List<Skill>? skills;
  final List<Document>? documents;

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
}
