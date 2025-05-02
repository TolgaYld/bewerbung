// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cv.dart';

class CvMapper extends ClassMapperBase<Cv> {
  CvMapper._();

  static CvMapper? _instance;
  static CvMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CvMapper._());
      CvStepMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Cv';

  static List<CvStep> _$educations(Cv v) => v.educations;
  static const Field<Cv, List<CvStep>> _f$educations =
      Field('educations', _$educations);
  static List<CvStep> _$sideJobs(Cv v) => v.sideJobs;
  static const Field<Cv, List<CvStep>> _f$sideJobs =
      Field('sideJobs', _$sideJobs);
  static List<CvStep> _$jobs(Cv v) => v.jobs;
  static const Field<Cv, List<CvStep>> _f$jobs = Field('jobs', _$jobs);
  static List<String>? _$drivingLicence(Cv v) => v.drivingLicence;
  static const Field<Cv, List<String>> _f$drivingLicence =
      Field('drivingLicence', _$drivingLicence, opt: true);

  @override
  final MappableFields<Cv> fields = const {
    #educations: _f$educations,
    #sideJobs: _f$sideJobs,
    #jobs: _f$jobs,
    #drivingLicence: _f$drivingLicence,
  };

  static Cv _instantiate(DecodingData data) {
    return Cv(
        educations: data.dec(_f$educations),
        sideJobs: data.dec(_f$sideJobs),
        jobs: data.dec(_f$jobs),
        drivingLicence: data.dec(_f$drivingLicence));
  }

  @override
  final Function instantiate = _instantiate;

  static Cv fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Cv>(map);
  }

  static Cv fromJson(String json) {
    return ensureInitialized().decodeJson<Cv>(json);
  }
}

mixin CvMappable {
  String toJson() {
    return CvMapper.ensureInitialized().encodeJson<Cv>(this as Cv);
  }

  Map<String, dynamic> toMap() {
    return CvMapper.ensureInitialized().encodeMap<Cv>(this as Cv);
  }

  CvCopyWith<Cv, Cv, Cv> get copyWith =>
      _CvCopyWithImpl<Cv, Cv>(this as Cv, $identity, $identity);
  @override
  String toString() {
    return CvMapper.ensureInitialized().stringifyValue(this as Cv);
  }

  @override
  bool operator ==(Object other) {
    return CvMapper.ensureInitialized().equalsValue(this as Cv, other);
  }

  @override
  int get hashCode {
    return CvMapper.ensureInitialized().hashValue(this as Cv);
  }
}

extension CvValueCopy<$R, $Out> on ObjectCopyWith<$R, Cv, $Out> {
  CvCopyWith<$R, Cv, $Out> get $asCv =>
      $base.as((v, t, t2) => _CvCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CvCopyWith<$R, $In extends Cv, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, CvStep, CvStepCopyWith<$R, CvStep, CvStep>> get educations;
  ListCopyWith<$R, CvStep, CvStepCopyWith<$R, CvStep, CvStep>> get sideJobs;
  ListCopyWith<$R, CvStep, CvStepCopyWith<$R, CvStep, CvStep>> get jobs;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get drivingLicence;
  $R call(
      {List<CvStep>? educations,
      List<CvStep>? sideJobs,
      List<CvStep>? jobs,
      List<String>? drivingLicence});
  CvCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CvCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Cv, $Out>
    implements CvCopyWith<$R, Cv, $Out> {
  _CvCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Cv> $mapper = CvMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CvStep, CvStepCopyWith<$R, CvStep, CvStep>> get educations =>
      ListCopyWith($value.educations, (v, t) => v.copyWith.$chain(t),
          (v) => call(educations: v));
  @override
  ListCopyWith<$R, CvStep, CvStepCopyWith<$R, CvStep, CvStep>> get sideJobs =>
      ListCopyWith($value.sideJobs, (v, t) => v.copyWith.$chain(t),
          (v) => call(sideJobs: v));
  @override
  ListCopyWith<$R, CvStep, CvStepCopyWith<$R, CvStep, CvStep>> get jobs =>
      ListCopyWith(
          $value.jobs, (v, t) => v.copyWith.$chain(t), (v) => call(jobs: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
      get drivingLicence => $value.drivingLicence != null
          ? ListCopyWith(
              $value.drivingLicence!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(drivingLicence: v))
          : null;
  @override
  $R call(
          {List<CvStep>? educations,
          List<CvStep>? sideJobs,
          List<CvStep>? jobs,
          Object? drivingLicence = $none}) =>
      $apply(FieldCopyWithData({
        if (educations != null) #educations: educations,
        if (sideJobs != null) #sideJobs: sideJobs,
        if (jobs != null) #jobs: jobs,
        if (drivingLicence != $none) #drivingLicence: drivingLicence
      }));
  @override
  Cv $make(CopyWithData data) => Cv(
      educations: data.get(#educations, or: $value.educations),
      sideJobs: data.get(#sideJobs, or: $value.sideJobs),
      jobs: data.get(#jobs, or: $value.jobs),
      drivingLicence: data.get(#drivingLicence, or: $value.drivingLicence));

  @override
  CvCopyWith<$R2, Cv, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CvCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
