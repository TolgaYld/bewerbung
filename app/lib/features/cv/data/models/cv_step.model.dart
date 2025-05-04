import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/document.model.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/skill.model.dart';
import 'package:pleasehiretolga/features/cv/domain/entities/cv_step.dart';

class CvStepModel {
  CvStepModel({
    required this.titles,
    required this.startDate,
    required this.skills,
    this.descriptions,
    this.responsibilities,
    this.references,
    this.imageUrl,
    this.link,
    this.passed,
    this.grade,
    this.endDate,
  });

  factory CvStepModel.empty() => CvStepModel(
        titles: {},
        startDate: DateTime.now(),
        passed: true,
        skills: [],
        references: {},
      );

  factory CvStepModel.fromMap(Map<String, dynamic> map) {
    final titles = <String, String>{};
    final descriptions = <String, String>{};
    final responsibilities = <String, List<String>>{};
    final references = <String, List<DocumentModel>>{};

    map.forEach((langCode, value) {
      if (value is Map<String, dynamic>) {
        if (value['title'] != null) {
          titles[langCode] = value['title'] as String;
        }

        if (value['desc'] != null) {
          descriptions[langCode] = value['desc'] as String;
        }

        if (value['responsibilities'] != null) {
          responsibilities[langCode] =
              List<String>.from(value['responsibilities'] as List);
        }

        if (value['references'] != null) {
          references[langCode] = (value['references'] as List<dynamic>)
              .map((e) => DocumentModel.fromMap(e as Map<String, dynamic>))
              .toList();
        }
      }
    });

    return CvStepModel(
      titles: titles,
      descriptions: descriptions,
      responsibilities: responsibilities,
      references: references,
      startDate: (map['startDate'] as Timestamp? ?? Timestamp.now()).toDate(),
      endDate: (map['endDate'] as Timestamp?)?.toDate(),
      passed: map['passed'] as bool?,
      grade: (map['grade'] as num?)?.toDouble(),
      skills: map['skills'] != null
          ? (map['skills'] as List<dynamic>)
              .map((e) => SkillModel.fromMap(e as Map<String, dynamic>))
              .toList()
          : [],
      imageUrl: map['imageUrl'] as String?,
      link: map['link'] as String?,
    );
  }

  final Map<String, String> titles;
  final Map<String, String>? descriptions;
  final Map<String, List<String>>? responsibilities;
  final Map<String, List<DocumentModel>>? references;
  final String? imageUrl;
  final String? link;
  final DateTime startDate;
  final DateTime? endDate;
  final double? grade;
  final bool? passed;
  final List<SkillModel>? skills;

  CvStep toEntity() => CvStep(
        titles: titles,
        descriptions: descriptions,
        responsibilities: responsibilities,
        references: references?.map(
          (langCode, docModels) => MapEntry(
            langCode,
            docModels.map((model) => model.toEntity()).toList(),
          ),
        ),
        imageUrl: imageUrl,
        link: link,
        passed: passed,
        grade: grade,
        startDate: startDate,
        endDate: endDate,
        skills: skills?.map((e) => e.toEntity()).toList(),
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      'startDate': Timestamp.fromDate(startDate),
      'passed': passed,
      'grade': grade,
      'imageUrl': imageUrl,
      'link': link,
    };

    if (endDate case final endDate?) {
      result['endDate'] = Timestamp.fromDate(endDate);
    }

    if (titles.isNotEmpty) {
      for (final entry in titles.entries) {
        final langCode = entry.key;

        if (result.containsKey(langCode) == false) {
          result[langCode] = <String, dynamic>{};
        }

        (result[langCode] as Map<String, dynamic>)['title'] = entry.value;
      }
    }

    if (descriptions case final descriptions? when descriptions.isNotEmpty) {
      for (final entry in descriptions.entries) {
        final langCode = entry.key;
        if (result.containsKey(langCode) == false) {
          result[langCode] = <String, dynamic>{};
        }
        (result[langCode] as Map<String, dynamic>)['desc'] = entry.value;
      }
    }

    if (responsibilities case final responsibilities?
        when responsibilities.isNotEmpty) {
      for (final entry in responsibilities.entries) {
        final langCode = entry.key;

        if (result.containsKey(langCode) == false) {
          result[langCode] = <String, dynamic>{};
        }
        (result[langCode] as Map<String, dynamic>)['responsibilities'] =
            entry.value;
      }
    }

    if (references case final references? when references.isNotEmpty) {
      for (final entry in references.entries) {
        final langCode = entry.key;

        if (result.containsKey(langCode) == false) {
          result[langCode] = <String, dynamic>{};
        }
        (result[langCode] as Map<String, dynamic>)['references'] =
            entry.value.map((doc) => doc.toMap()).toList();
      }
    }

    if (skills case final skills? when skills.isNotEmpty) {
      result['skills'] = skills.map((e) => e.toMap()).toList();
    } else {
      result['skills'] = [];
    }

    return result;
  }
}
