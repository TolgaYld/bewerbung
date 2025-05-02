import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/rendering.dart';
import 'package:meta/meta.dart';

part 'contact.mapper.dart';

@MappableClass()
class Contact with ContactMappable {
  const Contact({
    this.street,
    this.postalCode,
    Map<String, String>? city,
    Map<String, String>? country,
    this.phoneNumber,
    this.email,
  })  : _city = city,
        _country = country;

  final String? street;
  final String? postalCode;
  final Map<String, String>? _city;
  final Map<String, String>? _country;
  final String? phoneNumber;
  final String? email;

  @protected
  Map<String, String>? get city => _city;

  @protected
  Map<String, String>? get country => _country;

  String? getCityText(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _city?[languageCode] ?? _city?['de'];
  }

  String? getCountryText(Locale? locale) {
    final languageCode = locale?.languageCode ?? 'de';
    return _country?[languageCode] ?? _country?['de'];
  }

  String? getAddressForClFormat(Locale? locale) =>
      "$street\n$postalCode ${getCityText(locale)}\n${getCountryText(locale)}";
}
