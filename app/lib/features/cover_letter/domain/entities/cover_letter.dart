import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';

part 'cover_letter.mapper.dart';

@MappableClass()
class CoverLetter with CoverLetterMappable {
  const CoverLetter({
    this.date,
    this.signature,
    this.translations,
    this.imageUrl,
    this.address,
  });

  final DateTime? date;
  final String? signature;
  final String? imageUrl;
  final String? address;

  @protected
  final Map<String, CoverLetterTranslation>? translations;

  CoverLetterTranslation? getTranslation(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return translations?[languageCode];
  }
}

@MappableClass()
class CoverLetterTranslation with CoverLetterTranslationMappable {
  const CoverLetterTranslation({
    required this.subject,
    required this.content,
    this.position,
    this.city,
  });

  final String? position;
  final String subject;
  final String content;
  final String? city;
}
