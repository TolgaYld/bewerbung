// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cv_step.dart';

class CvStepMapper extends ClassMapperBase<CvStep> {
  CvStepMapper._();

  static CvStepMapper? _instance;
  static CvStepMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CvStepMapper._());
      SkillMapper.ensureInitialized();
      DocumentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CvStep';

  static Map<String, String> _$_titles(CvStep v) => v._titles;
  static const Field<CvStep, Map<String, String>> _f$_titles =
      Field('_titles', _$_titles, key: r'titles');
  static DateTime _$startDate(CvStep v) => v.startDate;
  static const Field<CvStep, DateTime> _f$startDate =
      Field('startDate', _$startDate);
  static List<Skill>? _$skills(CvStep v) => v.skills;
  static const Field<CvStep, List<Skill>> _f$skills = Field('skills', _$skills);
  static Map<String, String>? _$_descriptions(CvStep v) => v._descriptions;
  static const Field<CvStep, Map<String, String>> _f$_descriptions =
      Field('_descriptions', _$_descriptions, key: r'descriptions', opt: true);
  static Map<String, List<String>>? _$_responsibilities(CvStep v) =>
      v._responsibilities;
  static const Field<CvStep, Map<String, List<String>>> _f$_responsibilities =
      Field('_responsibilities', _$_responsibilities,
          key: r'responsibilities', opt: true);
  static Map<String, List<Document>>? _$_references(CvStep v) => v._references;
  static const Field<CvStep, Map<String, List<Document>>> _f$_references =
      Field('_references', _$_references, key: r'references', opt: true);
  static bool? _$passed(CvStep v) => v.passed;
  static const Field<CvStep, bool> _f$passed =
      Field('passed', _$passed, opt: true);
  static double? _$grade(CvStep v) => v.grade;
  static const Field<CvStep, double> _f$grade =
      Field('grade', _$grade, opt: true);
  static String? _$imageUrl(CvStep v) => v.imageUrl;
  static const Field<CvStep, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, opt: true);
  static String? _$link(CvStep v) => v.link;
  static const Field<CvStep, String> _f$link = Field('link', _$link, opt: true);
  static DateTime? _$endDate(CvStep v) => v.endDate;
  static const Field<CvStep, DateTime> _f$endDate =
      Field('endDate', _$endDate, opt: true);

  @override
  final MappableFields<CvStep> fields = const {
    #_titles: _f$_titles,
    #startDate: _f$startDate,
    #skills: _f$skills,
    #_descriptions: _f$_descriptions,
    #_responsibilities: _f$_responsibilities,
    #_references: _f$_references,
    #passed: _f$passed,
    #grade: _f$grade,
    #imageUrl: _f$imageUrl,
    #link: _f$link,
    #endDate: _f$endDate,
  };

  static CvStep _instantiate(DecodingData data) {
    return CvStep(
        titles: data.dec(_f$_titles),
        startDate: data.dec(_f$startDate),
        skills: data.dec(_f$skills),
        descriptions: data.dec(_f$_descriptions),
        responsibilities: data.dec(_f$_responsibilities),
        references: data.dec(_f$_references),
        passed: data.dec(_f$passed),
        grade: data.dec(_f$grade),
        imageUrl: data.dec(_f$imageUrl),
        link: data.dec(_f$link),
        endDate: data.dec(_f$endDate));
  }

  @override
  final Function instantiate = _instantiate;

  static CvStep fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CvStep>(map);
  }

  static CvStep fromJson(String json) {
    return ensureInitialized().decodeJson<CvStep>(json);
  }
}

mixin CvStepMappable {
  String toJson() {
    return CvStepMapper.ensureInitialized().encodeJson<CvStep>(this as CvStep);
  }

  Map<String, dynamic> toMap() {
    return CvStepMapper.ensureInitialized().encodeMap<CvStep>(this as CvStep);
  }

  CvStepCopyWith<CvStep, CvStep, CvStep> get copyWith =>
      _CvStepCopyWithImpl<CvStep, CvStep>(this as CvStep, $identity, $identity);
  @override
  String toString() {
    return CvStepMapper.ensureInitialized().stringifyValue(this as CvStep);
  }

  @override
  bool operator ==(Object other) {
    return CvStepMapper.ensureInitialized().equalsValue(this as CvStep, other);
  }

  @override
  int get hashCode {
    return CvStepMapper.ensureInitialized().hashValue(this as CvStep);
  }
}

extension CvStepValueCopy<$R, $Out> on ObjectCopyWith<$R, CvStep, $Out> {
  CvStepCopyWith<$R, CvStep, $Out> get $asCvStep =>
      $base.as((v, t, t2) => _CvStepCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CvStepCopyWith<$R, $In extends CvStep, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get _titles;
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>>? get skills;
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
      get _descriptions;
  MapCopyWith<$R, String, List<String>,
      ObjectCopyWith<$R, List<String>, List<String>>>? get _responsibilities;
  MapCopyWith<$R, String, List<Document>,
      ObjectCopyWith<$R, List<Document>, List<Document>>>? get _references;
  $R call(
      {Map<String, String>? titles,
      DateTime? startDate,
      List<Skill>? skills,
      Map<String, String>? descriptions,
      Map<String, List<String>>? responsibilities,
      Map<String, List<Document>>? references,
      bool? passed,
      double? grade,
      String? imageUrl,
      String? link,
      DateTime? endDate});
  CvStepCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CvStepCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, CvStep, $Out>
    implements CvStepCopyWith<$R, CvStep, $Out> {
  _CvStepCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CvStep> $mapper = CvStepMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get _titles => MapCopyWith($value._titles,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(titles: v));
  @override
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>>? get skills =>
      $value.skills != null
          ? ListCopyWith($value.skills!, (v, t) => v.copyWith.$chain(t),
              (v) => call(skills: v))
          : null;
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
      get _descriptions => $value._descriptions != null
          ? MapCopyWith(
              $value._descriptions!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(descriptions: v))
          : null;
  @override
  MapCopyWith<$R, String, List<String>,
          ObjectCopyWith<$R, List<String>, List<String>>>?
      get _responsibilities => $value._responsibilities != null
          ? MapCopyWith(
              $value._responsibilities!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(responsibilities: v))
          : null;
  @override
  MapCopyWith<$R, String, List<Document>,
          ObjectCopyWith<$R, List<Document>, List<Document>>>?
      get _references => $value._references != null
          ? MapCopyWith(
              $value._references!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(references: v))
          : null;
  @override
  $R call(
          {Map<String, String>? titles,
          DateTime? startDate,
          Object? skills = $none,
          Object? descriptions = $none,
          Object? responsibilities = $none,
          Object? references = $none,
          Object? passed = $none,
          Object? grade = $none,
          Object? imageUrl = $none,
          Object? link = $none,
          Object? endDate = $none}) =>
      $apply(FieldCopyWithData({
        if (titles != null) #titles: titles,
        if (startDate != null) #startDate: startDate,
        if (skills != $none) #skills: skills,
        if (descriptions != $none) #descriptions: descriptions,
        if (responsibilities != $none) #responsibilities: responsibilities,
        if (references != $none) #references: references,
        if (passed != $none) #passed: passed,
        if (grade != $none) #grade: grade,
        if (imageUrl != $none) #imageUrl: imageUrl,
        if (link != $none) #link: link,
        if (endDate != $none) #endDate: endDate
      }));
  @override
  CvStep $make(CopyWithData data) => CvStep(
      titles: data.get(#titles, or: $value._titles),
      startDate: data.get(#startDate, or: $value.startDate),
      skills: data.get(#skills, or: $value.skills),
      descriptions: data.get(#descriptions, or: $value._descriptions),
      responsibilities:
          data.get(#responsibilities, or: $value._responsibilities),
      references: data.get(#references, or: $value._references),
      passed: data.get(#passed, or: $value.passed),
      grade: data.get(#grade, or: $value.grade),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      link: data.get(#link, or: $value.link),
      endDate: data.get(#endDate, or: $value.endDate));

  @override
  CvStepCopyWith<$R2, CvStep, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CvStepCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
