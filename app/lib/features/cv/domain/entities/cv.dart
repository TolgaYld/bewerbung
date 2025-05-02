import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pleasehiretolga/features/cv/domain/entities/cv_step.dart';

part 'cv.mapper.dart';

@MappableClass()
class Cv with CvMappable {
  const Cv({
    required this.educations,
    required this.sideJobs,
    required this.jobs,
    this.drivingLicence,
  });

  @protected
  final List<CvStep> educations;
  @protected
  final List<CvStep> sideJobs;
  @protected
  final List<CvStep> jobs;
  final List<String>? drivingLicence;

  bool get hasDrivingLicence => switch (drivingLicence) {
        final licence? => licence.isNotEmpty,
        null => false,
      };

  List<CvStep> sortedEducations({bool descending = false}) =>
      _sortSteps(educations, descending);
  List<CvStep> sortedJobs({bool descending = false}) =>
      _sortSteps(jobs, descending);
  List<CvStep> sortedSideJobs({bool descending = false}) =>
      _sortSteps(sideJobs, descending);

  List<CvStep> _sortSteps(List<CvStep> steps, bool descending) {
    final sortedList = List.of(steps)
      ..sort((a, b) => a.startDate.compareTo(b.startDate));
    return descending ? sortedList.reversed.toList() : sortedList;
  }
}
