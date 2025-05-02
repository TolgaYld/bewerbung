import 'package:dart_mappable/dart_mappable.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/contact.dart';
import 'package:pleasehiretolga/core/features/employee/domain/entities/disability.dart';

part 'person.mapper.dart';

@MappableEnum()
enum Gender {
  male,
  female,
  other,
  preferNotToSay,
}

@MappableClass()
class Person with PersonMappable {
  const Person({
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    this.contact,
    this.disability,
    this.imageUrls,
  });

  final Gender gender;
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final Contact? contact;
  final Disability? disability;
  final List<String>? imageUrls;

  String get fullName => '$firstName $lastName';
}
