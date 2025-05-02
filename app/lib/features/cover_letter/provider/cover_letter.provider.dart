import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/auth/domain/entities/company.dart';
import 'package:pleasehiretolga/core/features/auth/provider/company.provider.dart';
import 'package:pleasehiretolga/features/cover_letter/domain/entities/cover_letter.dart';

final coverLetterProvider = StreamProvider.autoDispose<CoverLetter?>((ref) {
  final company = ref.watch(companyProvider).valueOrNull;
  final coverLetterValue = switch (company) {
    Company(:final coverLetter) => coverLetter,
    _ => null,
  };
  return Stream.value(coverLetterValue);
});
