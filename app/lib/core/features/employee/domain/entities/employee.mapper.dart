// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'employee.dart';

class EmployeeMapper extends ClassMapperBase<Employee> {
  EmployeeMapper._();

  static EmployeeMapper? _instance;
  static EmployeeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = EmployeeMapper._());
      PersonMapper.ensureInitialized();
      CvMapper.ensureInitialized();
      SkillMapper.ensureInitialized();
      DocumentMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Employee';

  static String _$id(Employee v) => v.id;
  static const Field<Employee, String> _f$id = Field('id', _$id);
  static Person _$person(Employee v) => v.person;
  static const Field<Employee, Person> _f$person = Field('person', _$person);
  static Cv _$cv(Employee v) => v.cv;
  static const Field<Employee, Cv> _f$cv = Field('cv', _$cv);
  static Map<String, String> _$_aboutMe(Employee v) => v._aboutMe;
  static const Field<Employee, Map<String, String>> _f$_aboutMe =
      Field('_aboutMe', _$_aboutMe, key: r'aboutMe');
  static Map<String, String>? _$_jobTitle(Employee v) => v._jobTitle;
  static const Field<Employee, Map<String, String>> _f$_jobTitle =
      Field('_jobTitle', _$_jobTitle, key: r'jobTitle', opt: true);
  static List<Skill>? _$generalSkills(Employee v) => v.generalSkills;
  static const Field<Employee, List<Skill>> _f$generalSkills =
      Field('generalSkills', _$generalSkills);
  static List<Skill> _$programmingLanguages(Employee v) =>
      v.programmingLanguages;
  static const Field<Employee, List<Skill>> _f$programmingLanguages =
      Field('programmingLanguages', _$programmingLanguages);
  static List<Skill> _$languages(Employee v) => v.languages;
  static const Field<Employee, List<Skill>> _f$languages =
      Field('languages', _$languages);
  static List<Document>? _$documents(Employee v) => v.documents;
  static const Field<Employee, List<Document>> _f$documents =
      Field('documents', _$documents);

  @override
  final MappableFields<Employee> fields = const {
    #id: _f$id,
    #person: _f$person,
    #cv: _f$cv,
    #_aboutMe: _f$_aboutMe,
    #_jobTitle: _f$_jobTitle,
    #generalSkills: _f$generalSkills,
    #programmingLanguages: _f$programmingLanguages,
    #languages: _f$languages,
    #documents: _f$documents,
  };

  static Employee _instantiate(DecodingData data) {
    return Employee(
        id: data.dec(_f$id),
        person: data.dec(_f$person),
        cv: data.dec(_f$cv),
        aboutMe: data.dec(_f$_aboutMe),
        jobTitle: data.dec(_f$_jobTitle),
        generalSkills: data.dec(_f$generalSkills),
        programmingLanguages: data.dec(_f$programmingLanguages),
        languages: data.dec(_f$languages),
        documents: data.dec(_f$documents));
  }

  @override
  final Function instantiate = _instantiate;

  static Employee fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Employee>(map);
  }

  static Employee fromJson(String json) {
    return ensureInitialized().decodeJson<Employee>(json);
  }
}

mixin EmployeeMappable {
  String toJson() {
    return EmployeeMapper.ensureInitialized()
        .encodeJson<Employee>(this as Employee);
  }

  Map<String, dynamic> toMap() {
    return EmployeeMapper.ensureInitialized()
        .encodeMap<Employee>(this as Employee);
  }

  EmployeeCopyWith<Employee, Employee, Employee> get copyWith =>
      _EmployeeCopyWithImpl<Employee, Employee>(
          this as Employee, $identity, $identity);
  @override
  String toString() {
    return EmployeeMapper.ensureInitialized().stringifyValue(this as Employee);
  }

  @override
  bool operator ==(Object other) {
    return EmployeeMapper.ensureInitialized()
        .equalsValue(this as Employee, other);
  }

  @override
  int get hashCode {
    return EmployeeMapper.ensureInitialized().hashValue(this as Employee);
  }
}

extension EmployeeValueCopy<$R, $Out> on ObjectCopyWith<$R, Employee, $Out> {
  EmployeeCopyWith<$R, Employee, $Out> get $asEmployee =>
      $base.as((v, t, t2) => _EmployeeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class EmployeeCopyWith<$R, $In extends Employee, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PersonCopyWith<$R, Person, Person> get person;
  CvCopyWith<$R, Cv, Cv> get cv;
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get _aboutMe;
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
      get _jobTitle;
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>>? get generalSkills;
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>>
      get programmingLanguages;
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>> get languages;
  ListCopyWith<$R, Document, DocumentCopyWith<$R, Document, Document>>?
      get documents;
  $R call(
      {String? id,
      Person? person,
      Cv? cv,
      Map<String, String>? aboutMe,
      Map<String, String>? jobTitle,
      List<Skill>? generalSkills,
      List<Skill>? programmingLanguages,
      List<Skill>? languages,
      List<Document>? documents});
  EmployeeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _EmployeeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Employee, $Out>
    implements EmployeeCopyWith<$R, Employee, $Out> {
  _EmployeeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Employee> $mapper =
      EmployeeMapper.ensureInitialized();
  @override
  PersonCopyWith<$R, Person, Person> get person =>
      $value.person.copyWith.$chain((v) => call(person: v));
  @override
  CvCopyWith<$R, Cv, Cv> get cv =>
      $value.cv.copyWith.$chain((v) => call(cv: v));
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>
      get _aboutMe => MapCopyWith($value._aboutMe,
          (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(aboutMe: v));
  @override
  MapCopyWith<$R, String, String, ObjectCopyWith<$R, String, String>>?
      get _jobTitle => $value._jobTitle != null
          ? MapCopyWith(
              $value._jobTitle!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(jobTitle: v))
          : null;
  @override
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>>? get generalSkills =>
      $value.generalSkills != null
          ? ListCopyWith($value.generalSkills!, (v, t) => v.copyWith.$chain(t),
              (v) => call(generalSkills: v))
          : null;
  @override
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>>
      get programmingLanguages => ListCopyWith($value.programmingLanguages,
          (v, t) => v.copyWith.$chain(t), (v) => call(programmingLanguages: v));
  @override
  ListCopyWith<$R, Skill, SkillCopyWith<$R, Skill, Skill>> get languages =>
      ListCopyWith($value.languages, (v, t) => v.copyWith.$chain(t),
          (v) => call(languages: v));
  @override
  ListCopyWith<$R, Document, DocumentCopyWith<$R, Document, Document>>?
      get documents => $value.documents != null
          ? ListCopyWith($value.documents!, (v, t) => v.copyWith.$chain(t),
              (v) => call(documents: v))
          : null;
  @override
  $R call(
          {String? id,
          Person? person,
          Cv? cv,
          Map<String, String>? aboutMe,
          Object? jobTitle = $none,
          Object? generalSkills = $none,
          List<Skill>? programmingLanguages,
          List<Skill>? languages,
          Object? documents = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (person != null) #person: person,
        if (cv != null) #cv: cv,
        if (aboutMe != null) #aboutMe: aboutMe,
        if (jobTitle != $none) #jobTitle: jobTitle,
        if (generalSkills != $none) #generalSkills: generalSkills,
        if (programmingLanguages != null)
          #programmingLanguages: programmingLanguages,
        if (languages != null) #languages: languages,
        if (documents != $none) #documents: documents
      }));
  @override
  Employee $make(CopyWithData data) => Employee(
      id: data.get(#id, or: $value.id),
      person: data.get(#person, or: $value.person),
      cv: data.get(#cv, or: $value.cv),
      aboutMe: data.get(#aboutMe, or: $value._aboutMe),
      jobTitle: data.get(#jobTitle, or: $value._jobTitle),
      generalSkills: data.get(#generalSkills, or: $value.generalSkills),
      programmingLanguages:
          data.get(#programmingLanguages, or: $value.programmingLanguages),
      languages: data.get(#languages, or: $value.languages),
      documents: data.get(#documents, or: $value.documents));

  @override
  EmployeeCopyWith<$R2, Employee, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _EmployeeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
