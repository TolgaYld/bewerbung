import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/features/imprint/data/repo/imprint.repo.impl.dart';
import 'package:pleasehiretolga/core/features/imprint/domain/entity/imprint.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

final imprintProvider = StreamProvider.autoDispose<Imprint?>(
  (ref) {
    final imprintRepository = ref.watch(imprintRepositoryProvider);
    return imprintRepository.watchImprint().map((imprint) {
      return switch (imprint) {
        Right(:final value) => value,
        _ => null,
      };
    });
  },
);
