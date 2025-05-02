import 'package:pleasehiretolga/features/cv/data/models/cv.model.dart';
import 'package:pleasehiretolga/features/cv/data/models/cv_step.model.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/person.model.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/skill.model.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/employee.dart';
import 'package:pleasehiretolga/core/interfaces/id_holder.dart';

class EmployeeModel implements IdHolder {
  EmployeeModel({
    required this.id,
    required this.person,
    required this.aboutMe,
    required this.cv,
    required this.jobTitle,
    required this.generalSkills,
    required this.programmingLanguages,
    required this.languages,
  });

  factory EmployeeModel.empty() => EmployeeModel(
        id: 'laksdjfdsafds',
        person: PersonModel.empty(),
        aboutMe: {},
        cv: CvModel.empty(),
        jobTitle: {},
        generalSkills: [SkillModel.empty()],
        programmingLanguages: [],
        languages: [],
      );

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    final cvData = map['cv'] as Map<String, dynamic>? ?? {};

    final cv = CvModel(
      educations: _parseCvSteps(cvData, 'educations'),
      sideJobs: _parseCvSteps(cvData, 'sideJobs'),
      jobs: _parseCvSteps(cvData, 'jobs'),
      drivingLicence: cvData['drivingLicence'] != null
          ? List<String>.from(cvData['drivingLicence'])
          : null,
    );

    List<SkillModel>? generalSkills;
    if (map['generalSkills'] != null && map['generalSkills'] is Map) {
      generalSkills =
          (map['generalSkills'] as Map<String, dynamic>).entries.map((entry) {
        final skillData = entry.value as Map<String, dynamic>;
        if (skillData['title'] == null) {
          skillData['title'] = entry.key;
        }
        return SkillModel.fromMap(skillData);
      }).toList();
    }

    return EmployeeModel(
      id: map['id'] as String,
      person: PersonModel.fromMap(map['person'] as Map<String, dynamic>),
      aboutMe: Map<String, String>.from(map['aboutMe'] as Map),
      jobTitle: map['jobTitle'] != null
          ? Map<String, String>.from(map['jobTitle'] as Map)
          : null,
      cv: cv,
      generalSkills: generalSkills,
      programmingLanguages:
          (map['programmingLanguages'] as Map<String, dynamic>)
              .values
              .map((e) => SkillModel.fromMap(e as Map<String, dynamic>))
              .toList(),
      languages: (map['languages'] as Map<String, dynamic>)
          .values
          .map((e) => SkillModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  static List<CvStepModel> _parseCvSteps(
    Map<String, dynamic> cvData,
    String key,
  ) {
    final steps = <CvStepModel>[];

    if (cvData[key] == null) return [];

    final stepsData = cvData[key] as Map<String, dynamic>;

    stepsData.forEach((stepKey, stepData) {
      if (stepData is Map<String, dynamic>) {
        steps.add(CvStepModel.fromMap(stepData));
      }
    });

    return steps;
  }

  @override
  final String id;
  final PersonModel person;
  final Map<String, String> aboutMe;
  final CvModel cv;
  final Map<String, String>? jobTitle;
  final List<SkillModel>? generalSkills;
  final List<SkillModel> programmingLanguages;
  final List<SkillModel> languages;

  Employee toEntity() => Employee(
        id: id,
        person: person.toEntity(),
        aboutMe: aboutMe,
        cv: cv.toEntity(),
        jobTitle: jobTitle,
        generalSkills: generalSkills?.map((e) => e.toEntity()).toList(),
        programmingLanguages:
            programmingLanguages.map((e) => e.toEntity()).toList(),
        documents: [],
        languages: languages.map((e) => e.toEntity()).toList(),
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      'id': id,
      'person': person.toMap(),
      'aboutMe': aboutMe,
      'jobTitle': jobTitle,
      'cv': cv.toMap(),
    };

    if (generalSkills case final generalSkills? when generalSkills.isNotEmpty) {
      final skillsMap = <String, dynamic>{};
      for (int i = 0; i < generalSkills.length; i++) {
        final skill = generalSkills[i];
        final key = skill.title.replaceAll(' ', '_').toLowerCase();
        skillsMap[key] = skill.toMap();
      }
      result['generalSkills'] = skillsMap;
    } else {
      result['generalSkills'] = <String, dynamic>{};
    }
    if (programmingLanguages.isNotEmpty) {
      final langMap = <String, dynamic>{};
      for (final lang in programmingLanguages) {
        final key = lang.title.replaceAll(' ', '_').toLowerCase();
        langMap[key] = lang.toMap();
      }
      result['programmingLanguages'] = langMap;
    } else {
      result['programmingLanguages'] = <String, dynamic>{};
    }

    if (languages.isNotEmpty) {
      final langMap = <String, dynamic>{};
      for (final lang in languages) {
        final key = lang.title.toLowerCase();
        langMap[key] = lang.toMap();
      }
      result['languages'] = langMap;
    } else {
      result['languages'] = <String, dynamic>{};
    }
    return result;
  }
}
