import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pleasehiretolga/core/errors/failure.dart';
import 'package:pleasehiretolga/core/features/imprint/data/repo/imprint.repo.impl.dart';
import 'package:pleasehiretolga/core/features/imprint/domain/entity/imprint.dart';
import 'package:pleasehiretolga/core/features/imprint/domain/repo/imprint.repo.dart';
import 'package:pleasehiretolga/core/features/imprint/provider/imprint.provider.dart';
import 'package:pleasehiretolga/core/utils/either.dart';

class MockImprintRepository extends Mock implements ImprintRepository {}

void main() {
  late MockImprintRepository mockImprintRepository;
  late ProviderContainer container;
  late Imprint tImprint;

  setUp(() {
    mockImprintRepository = MockImprintRepository();
    tImprint = Imprint(
      translations: {
        'de': {
          'contact': 'Telefon: +49 176 22658759 E-Mail: tolga@ty-software.dev',
          'imprint': 'Tolga Yıldırım Kolumbusstraße 36 81543 München',
        },
        'en': {
          'contact': 'Phone: +49 176 22658759 Email: tolga@ty-software.dev',
          'imprint': 'Tolga Yıldırım Kolumbusstraße 36 81543 Munich',
        },
      },
    );

    container = ProviderContainer(
      overrides: [
        imprintRepositoryProvider.overrideWithValue(mockImprintRepository),
      ],
    );

    registerFallbackValue(const Right<Failure, Imprint?>(null));
  });

  tearDown(() {
    container.dispose();
  });

  group('imprintProvider', () {
    test(
      'should emit loading state initially',
      () async {
        when(() => mockImprintRepository.watchImprint()).thenAnswer(
          (_) => Stream.value(Right(tImprint)),
        );

        expect(
          container.read(imprintProvider),
          const AsyncValue<Imprint?>.loading(),
        );
      },
    );

    test(
      'should emit Imprint data when repository returns [Right(Imprint)]',
      () async {
        when(() => mockImprintRepository.watchImprint()).thenAnswer(
          (_) => Stream.value(Right(tImprint)),
        );

        await container.read(imprintProvider.future);

        expect(
          container.read(imprintProvider).value,
          equals(tImprint),
        );
      },
    );

    test(
      'should emit null when repository returns [Right(null)]',
      () async {
        when(() => mockImprintRepository.watchImprint()).thenAnswer(
          (_) => Stream.value(const Right(null)),
        );

        await container.read(imprintProvider.future);

        expect(
          container.read(imprintProvider).value,
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

        when(() => mockImprintRepository.watchImprint()).thenAnswer(
          (_) => Stream.value(Left(failure)),
        );

        await container.read(imprintProvider.future);

        expect(
          container.read(imprintProvider).value,
          isNull,
        );
      },
    );

    test(
      'should emit new values when repository stream emits new values',
      () async {
        final controller = StreamController<Either<Failure, Imprint?>>();

        when(() => mockImprintRepository.watchImprint()).thenAnswer(
          (_) => controller.stream,
        );

        container.listen(
          imprintProvider,
          (_, __) {},
          fireImmediately: true,
        );

        controller.add(Right(tImprint));
        await Future.delayed(Duration.zero);

        expect(
          container.read(imprintProvider).value,
          equals(tImprint),
        );

        final updatedImprint = Imprint(
          translations: {
            'de': {
              'contact': 'Neue Telefonnummer',
              'imprint': 'Neue Adresse',
            },
          },
        );

        controller.add(Right(updatedImprint));
        await Future.delayed(Duration.zero);

        expect(
          container.read(imprintProvider).value,
          equals(updatedImprint),
        );

        await controller.close();
      },
    );
  });
}
