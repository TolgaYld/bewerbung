import 'package:dart_mappable/dart_mappable.dart';

part 'document.mapper.dart';

@MappableClass()
class Document with DocumentMappable {
  const Document({
    this.title,
    this.description,
    this.emoji,
    this.url,
  });

  final String? title;
  final String? description;
  final String? url;
  final String? emoji;
}
