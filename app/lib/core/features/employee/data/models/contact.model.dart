import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/contact.dart';

class ContactModel {
  ContactModel({
    this.street,
    this.postalCode,
    this.city,
    this.country,
    this.phoneNumber,
    this.email,
    this.coordinates,
  });

  factory ContactModel.empty() => ContactModel(
        coordinates: GeoPoint(
          52.520008,
          13.404954,
        ),
        street: "Blabla Street",
        postalCode: "12345",
        city: {
          "de": "Berlin",
          "en": "Berlin",
        },
        country: {
          "de": "Deutschland",
          "en": "Germany",
        },
        phoneNumber: "+49 123 1234567",
        email: null,
      );

  factory ContactModel.fromMap(Map<String, dynamic> map) {
    GeoPoint? geoPoint;

    if (map['coordinates'] != null) {
      final coordsRaw = map['coordinates'].toString();

      final RegExp latRegex = RegExp(r'([0-9]+\.[0-9]+)°\s*N');
      final RegExp lngRegex = RegExp(r'([0-9]+\.[0-9]+)°\s*E');

      final latMatch = latRegex.firstMatch(coordsRaw);
      final lngMatch = lngRegex.firstMatch(coordsRaw);

      if ((latMatch?.group(1), lngMatch?.group(1))
          case (final latitudeM?, final longitudeM?)) {
        final double lat = double.parse(latitudeM);
        final double lng = double.parse(longitudeM);
        geoPoint = GeoPoint(lat, lng);
      }
    }

    final localizedData = Map<String, dynamic>.from(map)
      ..removeWhere(
        (key, _) => [
          'coordinates',
          'street',
          'postalCode',
          'phoneNumber',
          'email',
        ].contains(key),
      );

    final Map<String, String> city = {};
    final Map<String, String> country = {};

    for (final MapEntry(:key, :value) in localizedData.entries) {
      if (value case {'city': final cityName?, 'country': final countryName?}) {
        city[key] = cityName;
        country[key] = countryName;
      } else if (value case {'city': final cityName?}) {
        city[key] = cityName;
      } else if (value case {'country': final countryName?}) {
        country[key] = countryName;
      }
    }

    return ContactModel(
      coordinates: geoPoint,
      street: map['street'] as String?,
      postalCode: map['postalCode'] as String?,
      city: city,
      country: country,
      phoneNumber: map['phoneNumber'] as String?,
      email: map['email'] as String?,
    );
  }

  final GeoPoint? coordinates;
  final String? street;
  final String? postalCode;
  final Map<String, String>? city;
  final Map<String, String>? country;
  final String? phoneNumber;
  final String? email;

  Contact toEntity() => Contact(
        street: street,
        postalCode: postalCode,
        city: city,
        country: country,
        phoneNumber: phoneNumber,
        email: email,
      );

  Map<String, dynamic> toMap() => {
        'street': street,
        'postalCode': postalCode,
        'city': city,
        'country': country,
        'phoneNumber': phoneNumber,
        'email': email,
      };
}
