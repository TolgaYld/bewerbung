import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/contact.model.dart';
import 'package:pleasehiretolga/core/features/employee/data/models/disability.model.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/person.dart';

class PersonModel {
  PersonModel({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    this.contact,
    this.disability,
    this.imageUrls,
  });

  factory PersonModel.empty() => PersonModel(
        gender: Gender.preferNotToSay,
        firstName: 'Mister',
        lastName: 'Mackey',
        birthDate: Timestamp.now(),
        contact: ContactModel.empty(),
        disability: DisabilityModel.empty(),
        imageUrls: [
          "https://static.wikia.nocookie.net/spsot/images/e/ed/Mr.Mackey_facebook_profile.png/revision/latest?cb=20141024134127",
        ],
      );

  factory PersonModel.fromMap(Map<String, dynamic> map) => PersonModel(
        firstName: map['firstName'] as String,
        lastName: map['lastName'] as String,
        contact: map['contact'] != null
            ? ContactModel.fromMap(map['contact'] as Map<String, dynamic>)
            : null,
        birthDate: map['birthDate'] as Timestamp,
        disability: map['disability'] != null
            ? DisabilityModel.fromMap(map['disability'] as Map<String, dynamic>)
            : null,
        imageUrls: map['imageUrls'] != null
            ? List<String>.from(map['imageUrls'] as List)
            : null,
        gender: _mapGender(map['gender'] as String),
      );

  final String firstName;
  final String lastName;
  final Timestamp birthDate;
  final DisabilityModel? disability;
  final ContactModel? contact;
  final List<String>? imageUrls;
  final Gender gender;

  Person toEntity() => Person(
        gender: gender,
        firstName: firstName,
        lastName: lastName,
        contact: contact?.toEntity(),
        birthDate: birthDate.toDate(),
        disability: disability?.toEntity(),
        imageUrls: imageUrls,
      );

  Map<String, dynamic> toMap() => {
        'firstName': firstName,
        'lastName': lastName,
        'birthDate': birthDate,
        'contact': contact?.toMap(),
        'disability': disability?.toMap(),
        'imageUrls': imageUrls,
        'gender': gender.toString().split('.').last,
      };

  static Gender _mapGender(String value) {
    return Gender.values.firstWhere(
      (element) => element.toString().split('.').last == value,
      orElse: () => Gender.preferNotToSay,
    );
  }
}
