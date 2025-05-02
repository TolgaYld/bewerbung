// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'document.dart';

class DocumentMapper extends ClassMapperBase<Document> {
  DocumentMapper._();

  static DocumentMapper? _instance;
  static DocumentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DocumentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Document';

  static String? _$title(Document v) => v.title;
  static const Field<Document, String> _f$title =
      Field('title', _$title, opt: true);
  static String? _$description(Document v) => v.description;
  static const Field<Document, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$emoji(Document v) => v.emoji;
  static const Field<Document, String> _f$emoji =
      Field('emoji', _$emoji, opt: true);
  static String? _$url(Document v) => v.url;
  static const Field<Document, String> _f$url = Field('url', _$url, opt: true);

  @override
  final MappableFields<Document> fields = const {
    #title: _f$title,
    #description: _f$description,
    #emoji: _f$emoji,
    #url: _f$url,
  };

  static Document _instantiate(DecodingData data) {
    return Document(
        title: data.dec(_f$title),
        description: data.dec(_f$description),
        emoji: data.dec(_f$emoji),
        url: data.dec(_f$url));
  }

  @override
  final Function instantiate = _instantiate;

  static Document fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Document>(map);
  }

  static Document fromJson(String json) {
    return ensureInitialized().decodeJson<Document>(json);
  }
}

mixin DocumentMappable {
  String toJson() {
    return DocumentMapper.ensureInitialized()
        .encodeJson<Document>(this as Document);
  }

  Map<String, dynamic> toMap() {
    return DocumentMapper.ensureInitialized()
        .encodeMap<Document>(this as Document);
  }

  DocumentCopyWith<Document, Document, Document> get copyWith =>
      _DocumentCopyWithImpl<Document, Document>(
          this as Document, $identity, $identity);
  @override
  String toString() {
    return DocumentMapper.ensureInitialized().stringifyValue(this as Document);
  }

  @override
  bool operator ==(Object other) {
    return DocumentMapper.ensureInitialized()
        .equalsValue(this as Document, other);
  }

  @override
  int get hashCode {
    return DocumentMapper.ensureInitialized().hashValue(this as Document);
  }
}

extension DocumentValueCopy<$R, $Out> on ObjectCopyWith<$R, Document, $Out> {
  DocumentCopyWith<$R, Document, $Out> get $asDocument =>
      $base.as((v, t, t2) => _DocumentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DocumentCopyWith<$R, $In extends Document, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? description, String? emoji, String? url});
  DocumentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DocumentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Document, $Out>
    implements DocumentCopyWith<$R, Document, $Out> {
  _DocumentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Document> $mapper =
      DocumentMapper.ensureInitialized();
  @override
  $R call(
          {Object? title = $none,
          Object? description = $none,
          Object? emoji = $none,
          Object? url = $none}) =>
      $apply(FieldCopyWithData({
        if (title != $none) #title: title,
        if (description != $none) #description: description,
        if (emoji != $none) #emoji: emoji,
        if (url != $none) #url: url
      }));
  @override
  Document $make(CopyWithData data) => Document(
      title: data.get(#title, or: $value.title),
      description: data.get(#description, or: $value.description),
      emoji: data.get(#emoji, or: $value.emoji),
      url: data.get(#url, or: $value.url));

  @override
  DocumentCopyWith<$R2, Document, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DocumentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
