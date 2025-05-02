import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pleasehiretolga/features/cover_letter/domain/entities/cover_letter.dart';

class CoverLetterModel {
  CoverLetterModel({
    required this.translations,
    this.date,
    this.signature,
    this.imageUrl,
    this.address,
  });

  factory CoverLetterModel.empty() => CoverLetterModel(
        date: Timestamp.now(),
        signature: 'tolgii',
        imageUrl: 'https://example.com/image.png',
        address: "Blabla straße 123, 12345 blablastadt",
        translations: {
          'de': {
            'position': 'kingkong',
            'subject': 'Betreff',
            'content': 'der inhalt',
            'city': 'Minga',
          },
          'en': {
            'position': 'Position',
            'subject': 'Subject',
            'content': 'Cover letter content',
            'city': 'Munich',
          },
        },
      );

  factory CoverLetterModel.fromMap(Map<String, dynamic> map) {
    Map<String, Map<String, String>>? translations;

    if (map['translations'] case final Map<String, dynamic> translationsMap) {
      final translate = <String, Map<String, String>>{};

      translationsMap.forEach((langCode, langData) {
        if (langData is Map) {
          final langMap = langData as Map<String, dynamic>;
          final langTranslation = <String, String>{};

          if (langMap['position'] is String) {
            langTranslation['position'] = langMap['position'] as String;
          }
          if (langMap['subject'] is String) {
            langTranslation['subject'] = langMap['subject'] as String;
          }
          if (langMap['content'] is String) {
            langTranslation['content'] = langMap['content'] as String;
          }
          if (langMap['city'] is String) {
            langTranslation['city'] = langMap['city'] as String;
          }

          if (langTranslation.isNotEmpty) {
            translate[langCode] = langTranslation;
          }
        }
      });

      if (translate.isNotEmpty) {
        translations = translate;
      }
    }

    return CoverLetterModel(
      date: map['date'] as Timestamp?,
      signature: map['signature'] as String?,
      imageUrl: map['imageUrl'] as String?,
      address: map['address'] as String?,
      translations: translations,
    );
  }

  final Timestamp? date;
  final String? signature;
  final String? imageUrl;
  final String? address;
  final Map<String, Map<String, String>>? translations;

  CoverLetter toEntity() {
    final entityTranslations = translations?.map(
      (langCode, langData) => MapEntry(
        langCode,
        CoverLetterTranslation(
          position: langData['position'] ?? '',
          subject: langData['subject'] ?? '',
          content: langData['content'] ?? '',
          city: langData['city'] ?? '',
        ),
      ),
    );

    return CoverLetter(
      date: date?.toDate(),
      signature: signature,
      imageUrl: imageUrl,
      address: address,
      translations: entityTranslations,
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      if (date != null) 'date': date,
      if (signature != null) 'signature': signature,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (address != null) 'address': address,
    };

    translations?.forEach((key, value) {
      map[key] = value;
    });

    return map;
  }
}
