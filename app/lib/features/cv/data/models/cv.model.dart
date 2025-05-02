import 'package:pleasehiretolga/features/cv/data/models/cv_step.model.dart';
import 'package:pleasehiretolga/features/cv/domain/entities/cv.dart';

class CvModel {
  CvModel({
    required this.educations,
    required this.sideJobs,
    required this.jobs,
    this.drivingLicence,
  });

  factory CvModel.empty() => CvModel(
        educations: [CvStepModel.empty()],
        sideJobs: [],
        jobs: [
          CvStepModel.empty(),
          CvStepModel.empty(),
        ],
      );

  factory CvModel.fromMap(Map<String, dynamic> map) => CvModel(
        educations: (map['educations'] as List<dynamic>)
            .map((e) => CvStepModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        sideJobs: (map['sideJobs'] as List<dynamic>)
            .map((e) => CvStepModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        jobs: (map['jobs'] as List<dynamic>)
            .map((e) => CvStepModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        drivingLicence: switch (map['drivingLicence']) {
          final licence? => List<String>.from(licence),
          null => null,
        },
      );

  final List<CvStepModel> educations;
  final List<CvStepModel> sideJobs;
  final List<CvStepModel> jobs;
  final List<String>? drivingLicence;

  Cv toEntity() => Cv(
        educations: educations.map((e) => e.toEntity()).toList(),
        sideJobs: sideJobs.map((e) => e.toEntity()).toList(),
        jobs: jobs.map((e) => e.toEntity()).toList(),
        drivingLicence: drivingLicence,
      );

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{
      'drivingLicence': drivingLicence,
    };

    // Erstellen der educations als Map statt Liste
    if (educations.isNotEmpty) {
      final educationsMap = <String, dynamic>{};
      for (int i = 0; i < educations.length; i++) {
        final key =
            i == 0 ? 'ausbildung' : 'edu$i'; // Erster Eintrag ist "ausbildung"
        educationsMap[key] = educations[i].toMap();
      }
      result['educations'] = educationsMap;
    } else {
      result['educations'] = <String, dynamic>{};
    }

    // Erstellen der sideJobs als Map statt Liste
    if (sideJobs.isNotEmpty) {
      final sideJobsMap = <String, dynamic>{};
      for (int i = 0; i < sideJobs.length; i++) {
        sideJobsMap['side$i'] = sideJobs[i].toMap();
      }
      result['sideJobs'] = sideJobsMap;
    } else {
      result['sideJobs'] = <String, dynamic>{};
    }

    // Erstellen der jobs als Map statt Liste
    if (jobs.isNotEmpty) {
      final jobsMap = <String, dynamic>{};
      for (int i = 0; i < jobs.length; i++) {
        // Erste zwei Einträge sind "fos" und ein weiterer Eintrag
        final key = i == 0 ? 'fos' : (i == 1 ? 'job0' : 'job${i - 1}');
        jobsMap[key] = jobs[i].toMap();
      }
      result['jobs'] = jobsMap;
    } else {
      result['jobs'] = <String, dynamic>{};
    }

    return result;
  }
}
