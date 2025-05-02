import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/auth/data/repo/auth.repo.impl.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

final companyProvider = StreamProvider<Company?>((ref) {
  final repo = ref.watch(authRepoProvider);

  return repo.watchCompany().map((company) {
    if (company case Right(:final value)) {
      return value;
    } else {
      return null;
    }
  });
});
