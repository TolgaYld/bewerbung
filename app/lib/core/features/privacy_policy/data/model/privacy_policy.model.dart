import 'package:pleasehiretolga/core/features/privacy_policy/domain/entity/privacy_policy.dart';

class PrivacyPolicyModel {
  PrivacyPolicyModel({required this.content});

  factory PrivacyPolicyModel.empty() => PrivacyPolicyModel(content: {});

  factory PrivacyPolicyModel.fromMap(Map<String, dynamic> map) {
    final content = <String, String>{};

    map.forEach((key, value) {
      if (value is String) {
        content[key] = value;
      }
    });

    return PrivacyPolicyModel(content: content);
  }

  final Map<String, String> content;

  PrivacyPolicy toEntity() => PrivacyPolicy(content: content);

  Map<String, dynamic> toMap() => content;
}
