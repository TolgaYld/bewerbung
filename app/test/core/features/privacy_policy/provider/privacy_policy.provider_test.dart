import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/data/repo/privacy_policy.repo.impl.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/domain/entity/privacy_policy.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/domain/repo/privacy_policy.repo.dart';
import 'package:pleasehiretolga/core/features/privacy_policy/provider/privacy_policy.provider.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

class MockPrivacyPolicyRepository extends Mock
    implements PrivacyPolicyRepository {}

void main() {
  late MockPrivacyPolicyRepository mockPrivacyPolicyRepository;
  late ProviderContainer container;
  late PrivacyPolicy tPrivacyPolicy;

  setUp(() {
    mockPrivacyPolicyRepository = MockPrivacyPolicyRepository();

    tPrivacyPolicy = PrivacyPolicy(
      content: {
        'de': 'Datenschutzerklärung mit wichtigen Informationen...',
        'en': 'Privacy policy with important information...',
      },
    );

    container = ProviderContainer(
      overrides: [
        privacyPolicyRepositoryProvider
            .overrideWithValue(mockPrivacyPolicyRepository),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('privacyPolicyProvider', () {
    test(
      'should emit loading state initially',
      () async {
        when(() => mockPrivacyPolicyRepository.watchPrivacyPolicy()).thenAnswer(
          (_) => Stream.value(Right(tPrivacyPolicy)),
        );

        expect(
          container.read(privacyPolicyProvider),
          const AsyncValue<PrivacyPolicy?>.loading(),
        );
      },
    );

    test(
      'should emit PrivacyPolicy data when repository returns [Right(PrivacyPolicy)]',
      () async {
        when(() => mockPrivacyPolicyRepository.watchPrivacyPolicy()).thenAnswer(
          (_) => Stream.value(Right(tPrivacyPolicy)),
        );

        await container.read(privacyPolicyProvider.future);

        expect(
          container.read(privacyPolicyProvider).value,
          equals(tPrivacyPolicy),
        );
      },
    );

    test(
      'should emit null when repository returns [Right(null)]',
      () async {
        when(() => mockPrivacyPolicyRepository.watchPrivacyPolicy()).thenAnswer(
          (_) => Stream.value(const Right(null)),
        );

        await container.read(privacyPolicyProvider.future);

        expect(
          container.read(privacyPolicyProvider).value,
          isNull,
        );
      },
    );

    test(
      'should emit null when repository returns [Left(Failure)]',
      () async {
        final failure = ServerFailure(
          message: 'Server error',
          statusCode: 500,
        );

        when(() => mockPrivacyPolicyRepository.watchPrivacyPolicy()).thenAnswer(
          (_) => Stream.value(Left(failure)),
        );

        await container.read(privacyPolicyProvider.future);

        expect(
          container.read(privacyPolicyProvider).value,
          isNull,
        );
      },
    );

    test(
      'should emit new values when repository stream emits new values',
      () async {
        final controller = StreamController<Either<Failure, PrivacyPolicy?>>();

        when(() => mockPrivacyPolicyRepository.watchPrivacyPolicy()).thenAnswer(
          (_) => controller.stream,
        );

        container.listen(
          privacyPolicyProvider,
          (_, __) {},
          fireImmediately: true,
        );

        controller.add(Right(tPrivacyPolicy));
        await Future.delayed(Duration.zero);

        expect(
          container.read(privacyPolicyProvider).value,
          equals(tPrivacyPolicy),
        );

        final updatedPrivacyPolicy = PrivacyPolicy(
          content: {
            'de': 'Aktualisierte Datenschutzerklärung',
            'fr': 'Politique de confidentialité mise à jour',
          },
        );

        controller.add(Right(updatedPrivacyPolicy));
        await Future.delayed(Duration.zero);

        expect(
          container.read(privacyPolicyProvider).value,
          equals(updatedPrivacyPolicy),
        );
        await controller.close();
      },
    );
  });
}
