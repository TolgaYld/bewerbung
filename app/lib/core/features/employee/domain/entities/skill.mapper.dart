// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'skill.dart';

class SkillMapper extends ClassMapperBase<Skill> {
  SkillMapper._();

  static SkillMapper? _instance;
  static SkillMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SkillMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Skill';

  static String _$_title(Skill v) => v._title;
  static const Field<Skill, String> _f$_title =
      Field('_title', _$_title, key: r'title');
  static Map<String, Map<String, String>>? _$translations(Skill v) =>
      v.translations;
  static const Field<Skill, Map<String, Map<String, String>>> _f$translations =
      Field('translations', _$translations);
  static String? _$_description(Skill v) => v._description;
  static const Field<Skill, String> _f$_description =
      Field('_description', _$_description, key: r'description');
  static String? _$emoji(Skill v) => v.emoji;
  static const Field<Skill, String> _f$emoji =
      Field('emoji', _$emoji, opt: true);
  static String? _$imageUrl(Skill v) => v.imageUrl;
  static const Field<Skill, String> _f$imageUrl =
      Field('imageUrl', _$imageUrl, opt: true);
  static double? _$rating(Skill v) => v.rating;
  static const Field<Skill, double> _f$rating =
      Field('rating', _$rating, opt: true);

  @override
  final MappableFields<Skill> fields = const {
    #_title: _f$_title,
    #translations: _f$translations,
    #_description: _f$_description,
    #emoji: _f$emoji,
    #imageUrl: _f$imageUrl,
    #rating: _f$rating,
  };

  static Skill _instantiate(DecodingData data) {
    return Skill(
        title: data.dec(_f$_title),
        translations: data.dec(_f$translations),
        description: data.dec(_f$_description),
        emoji: data.dec(_f$emoji),
        imageUrl: data.dec(_f$imageUrl),
        rating: data.dec(_f$rating));
  }

  @override
  final Function instantiate = _instantiate;

  static Skill fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Skill>(map);
  }

  static Skill fromJson(String json) {
    return ensureInitialized().decodeJson<Skill>(json);
  }
}

mixin SkillMappable {
  String toJson() {
    return SkillMapper.ensureInitialized().encodeJson<Skill>(this as Skill);
  }

  Map<String, dynamic> toMap() {
    return SkillMapper.ensureInitialized().encodeMap<Skill>(this as Skill);
  }

  SkillCopyWith<Skill, Skill, Skill> get copyWith =>
      _SkillCopyWithImpl<Skill, Skill>(this as Skill, $identity, $identity);
  @override
  String toString() {
    return SkillMapper.ensureInitialized().stringifyValue(this as Skill);
  }

  @override
  bool operator ==(Object other) {
    return SkillMapper.ensureInitialized().equalsValue(this as Skill, other);
  }

  @override
  int get hashCode {
    return SkillMapper.ensureInitialized().hashValue(this as Skill);
  }
}

extension SkillValueCopy<$R, $Out> on ObjectCopyWith<$R, Skill, $Out> {
  SkillCopyWith<$R, Skill, $Out> get $asSkill =>
      $base.as((v, t, t2) => _SkillCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SkillCopyWith<$R, $In extends Skill, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MapCopyWith<$R, String, Map<String, String>,
          ObjectCopyWith<$R, Map<String, String>, Map<String, String>>>?
      get translations;
  $R call(
      {String? title,
      Map<String, Map<String, String>>? translations,
      String? description,
      String? emoji,
      String? imageUrl,
      double? rating});
  SkillCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SkillCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Skill, $Out>
    implements SkillCopyWith<$R, Skill, $Out> {
  _SkillCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Skill> $mapper = SkillMapper.ensureInitialized();
  @override
  MapCopyWith<$R, String, Map<String, String>,
          ObjectCopyWith<$R, Map<String, String>, Map<String, String>>>?
      get translations => $value.translations != null
          ? MapCopyWith(
              $value.translations!,
              (v, t) => ObjectCopyWith(v, $identity, t),
              (v) => call(translations: v))
          : null;
  @override
  $R call(
          {String? title,
          Object? translations = $none,
          Object? description = $none,
          Object? emoji = $none,
          Object? imageUrl = $none,
          Object? rating = $none}) =>
      $apply(FieldCopyWithData({
        if (title != null) #title: title,
        if (translations != $none) #translations: translations,
        if (description != $none) #description: description,
        if (emoji != $none) #emoji: emoji,
        if (imageUrl != $none) #imageUrl: imageUrl,
        if (rating != $none) #rating: rating
      }));
  @override
  Skill $make(CopyWithData data) => Skill(
      title: data.get(#title, or: $value._title),
      translations: data.get(#translations, or: $value.translations),
      description: data.get(#description, or: $value._description),
      emoji: data.get(#emoji, or: $value.emoji),
      imageUrl: data.get(#imageUrl, or: $value.imageUrl),
      rating: data.get(#rating, or: $value.rating));

  @override
  SkillCopyWith<$R2, Skill, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SkillCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
