import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/repo/privacy_policy.repo.impl.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/domain/entity/privacy_policy.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

final privacyPolicyProvider = StreamProvider.autoDispose<PrivacyPolicy?>(
  (ref) {
    final privacyPolicyRepository = ref.watch(privacyPolicyRepositoryProvider);
    return privacyPolicyRepository.watchPrivacyPolicy().map((privacyPolicy) {
      return switch (privacyPolicy) {
        Right(:final value) => value,
        _ => null,
      };
    });
  },
);
