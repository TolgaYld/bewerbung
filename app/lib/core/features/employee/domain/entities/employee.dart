import 'dart:ui';

import 'package:dart_mappable/dart_mappable.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/document.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/person.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/skill.dart';
import 'package:pleasehiretolga/features/cv/domain/entities/cv.dart';

part 'employee.mapper.dart';

@MappableClass()
class Employee with EmployeeMappable {
  const Employee({
    required this.id,
    required this.person,
    required this.cv,
    required Map<String, String> aboutMe,
    Map<String, String>? jobTitle,
    required this.generalSkills,
    required this.programmingLanguages,
    required this.languages,
    required this.documents,
  })  : _aboutMe = aboutMe,
        _jobTitle = jobTitle;

  final String id;

  final Cv cv;
  final Person person;
  final List<Skill>? generalSkills;
  final List<Skill> programmingLanguages;
  final List<Skill> languages;
  final List<Document>? documents;
  final Map<String, String> _aboutMe;
  final Map<String, String>? _jobTitle;

  List<String> get imageUrls => person.imageUrls ?? [];

  String? getAboutMeText(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _aboutMe[languageCode] ?? _aboutMe['de'];
  }

  String? getJobTitleText(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _jobTitle?[languageCode] ?? _jobTitle?['de'];
  }
}
