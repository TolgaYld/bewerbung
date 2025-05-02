import 'package:pleasehiretolga/core/features/employee/domain/entities/document.dart';

class DocumentModel {
  const DocumentModel({
    this.title,
    this.description,
    this.url,
    this.emoji,
  });

  factory DocumentModel.fromMap(Map<String, dynamic> json) {
    return DocumentModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      url: json['url'] as String?,
      emoji: json['emoji'] as String?,
    );
  }

  factory DocumentModel.empty() => DocumentModel(
        title: 'blabla document title',
        description: '',
        url: '',
        emoji: '',
      );

  factory DocumentModel.fromEntity(Document documents) {
    return DocumentModel(
      title: documents.title,
      description: documents.description,
      url: documents.url,
      emoji: documents.emoji,
    );
  }

  final String? title;
  final String? description;
  final String? url;
  final String? emoji;

  Document toEntity() => Document(
        title: title,
        description: description,
        url: url,
        emoji: emoji,
      );

  Map<String, dynamic> toMap() => {
        'title': title,
        'description': description,
        'url': url,
        'emoji': emoji,
      };
}
