import 'package:pleasehiretolga/core/features/privacy_policy/domain/entity/privacy_policy.dart';
import 'package:pleasehiretolga/core/utils/typedefs.dart';

abstract interface class PrivacyPolicyRepository {
  ResultStream<PrivacyPolicy?> watchPrivacyPolicy();
}
