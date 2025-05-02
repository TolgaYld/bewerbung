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
    this.imageUrl,
    this.link,
    this.documents,
    this.passed,
    this.grade,
    this.endDate,
  });

  factory CvStepModel.empty() => CvStepModel(
        titles: {},
        startDate: DateTime.now(),
        passed: true,
        skills: [],
      );

  factory CvStepModel.fromMap(Map<String, dynamic> map) {
    final titles = <String, String>{};
    final descriptions = <String, String>{};
    final responsibilities = <String, List<String>>{};

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
      }
    });

    return CvStepModel(
      titles: titles,
      descriptions: descriptions,
      responsibilities: responsibilities,
      startDate: (map['startDate'] as Timestamp? ?? Timestamp.now()).toDate(),
      endDate: (map['endDate'] as Timestamp?)?.toDate(),
      passed: map['passed'] as bool?,
      grade: (map['grade'] as num?)?.toDouble(),
      skills: map['skills'] != null
          ? (map['skills'] as List<dynamic>)
              .map((e) => SkillModel.fromMap(e as Map<String, dynamic>))
              .toList()
          : [],
      documents: map['documents'] != null
          ? (map['documents'] as List<dynamic>)
              .map((e) => DocumentModel.fromMap(e as Map<String, dynamic>))
              .toList()
          : [],
      imageUrl: map['imageUrl'] as String?,
      link: map['link'] as String?,
    );
  }

  final Map<String, String> titles;
  final Map<String, String>? descriptions;
  final Map<String, List<String>>? responsibilities;
  final String? imageUrl;
  final String? link;
  final DateTime startDate;
  final DateTime? endDate;
  final List<DocumentModel>? documents;
  final double? grade;
  final bool? passed;
  final List<SkillModel>? skills;

  CvStep toEntity() => CvStep(
        titles: titles,
        descriptions: descriptions,
        responsibilities: responsibilities,
        imageUrl: imageUrl,
        link: link,
        passed: passed,
        documents: documents?.map((e) => e.toEntity()).toList(),
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

    // Enddate hinzufügen, falls vorhanden
    if (endDate != null) {
      result['endDate'] = Timestamp.fromDate(endDate!);
    }

    // Direkt Sprachschlüssel auf oberster Ebene hinzufügen
    if (titles.isNotEmpty) {
      for (final entry in titles.entries) {
        final langCode = entry.key;

        // Erstelle ein Map für den Sprachcode, falls es noch nicht existiert
        if (!result.containsKey(langCode)) {
          result[langCode] = <String, dynamic>{};
        }

        // Füge den Titel hinzu
        (result[langCode] as Map<String, dynamic>)['title'] = entry.value;
      }
    }

    // Beschreibungen hinzufügen
    if (descriptions != null && descriptions!.isNotEmpty) {
      for (final entry in descriptions!.entries) {
        final langCode = entry.key;

        // Erstelle ein Map für den Sprachcode, falls es noch nicht existiert
        if (!result.containsKey(langCode)) {
          result[langCode] = <String, dynamic>{};
        }

        // Füge die Beschreibung hinzu
        (result[langCode] as Map<String, dynamic>)['desc'] = entry.value;
      }
    }

    // Verantwortlichkeiten hinzufügen
    if (responsibilities != null && responsibilities!.isNotEmpty) {
      for (final entry in responsibilities!.entries) {
        final langCode = entry.key;

        // Erstelle ein Map für den Sprachcode, falls es noch nicht existiert
        if (!result.containsKey(langCode)) {
          result[langCode] = <String, dynamic>{};
        }

        // Füge die Verantwortlichkeiten hinzu
        (result[langCode] as Map<String, dynamic>)['responsibilities'] =
            entry.value;
      }
    }

    // Skills und Dokumente als Listen hinzufügen
    if (skills != null && skills!.isNotEmpty) {
      result['skills'] = skills!.map((e) => e.toMap()).toList();
    } else {
      result['skills'] = [];
    }

    if (documents != null && documents!.isNotEmpty) {
      result['documents'] = documents!.map((e) => e.toMap()).toList();
    }

    return result;
  }
}
