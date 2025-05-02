import 'package:dart_mappable/dart_mappable.dart';

part 'disability.mapper.dart';

@MappableClass()
class Disability with DisabilityMappable {
  const Disability({
    required this.type,
    required this.percentage,
    this.description,
    this.url,
  });

  final String type;
  final String? description;
  final double percentage;
  final String? url;
}
