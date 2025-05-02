import 'package:pleasehiretolga/core/features/employee/domain/entities/disability.dart';

class DisabilityModel {
  DisabilityModel({
    required this.type,
    required this.percentage,
    this.description,
    this.url,
  });

  factory DisabilityModel.empty() => DisabilityModel(
        type: 'ICP',
        percentage: 0.8,
        description: "Description of the disability und so..",
      );

  DisabilityModel.fromEntity(Disability disability)
      : type = disability.type,
        description = disability.description,
        url = disability.url,
        percentage = disability.percentage;

  factory DisabilityModel.fromMap(Map<String, dynamic> map) => DisabilityModel(
        type: map['type'] as String,
        description: map['description'] as String?,
        url: map['url'] as String?,
        percentage: (map['percentage'] as num).toDouble(),
      );

  final String type;
  final String? description;
  final double percentage;
  final String? url;

  Disability toEntity() => Disability(
        type: type,
        description: description,
        url: url,
        percentage: percentage,
      );

  Map<String, dynamic> toMap() => {
        'type': type,
        'description': description,
        'url': url,
        'percentage': percentage,
      };
}
