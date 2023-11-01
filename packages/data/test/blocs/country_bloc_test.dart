// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:matex_data/matex_data.dart';

void main() {
  const countries = [
    MatexCountryMetadata(
      id: 'us',
      currency: 'USD',
      code: 'US',
    ),
    MatexCountryMetadata(
      id: 'ca',
      currency: 'CAD',
      code: 'CA',
    ),
  ];

  group('MatexCountryBloc', () {
    // singleton instance, so keep in order
    final bloc = MatexCountryBloc(
      jsonData: '''{"us": { "currency": "USD", "code": "US" }, '''
          '''"ca": { "currency": "CAD", "code": "CA" }}''',
    );

    test('initial state is correct', () {
      expect(bloc.currentState, MatexCountryBlocState());
    });

    test('handleInitializedEvent does not set state if not initializing',
        () async {
      expect(bloc.currentState.isInitializing, false);
      expect(bloc.currentState.isInitialized, false);
      bloc.addEvent(MatexCountryBlocEvent.initialized(countries));

      await expectLater(
        bloc.onData,
        emitsInOrder([MatexCountryBlocState()]),
      );
    });

    test('handleInitEvent should init the bloc', () async {
      bloc.addEvent(MatexCountryBlocEvent.init());

      await expectLater(
        bloc.onData,
        emitsInOrder([
          MatexCountryBlocState(isInitializing: false),
          MatexCountryBlocState(isInitializing: true),
          MatexCountryBlocState(
            isInitializing: false,
            isInitialized: true,
            countries: countries,
          ),
        ]),
      );
    });

    test('handleInitializedEvent does not set state if already initialized',
        () async {
      expect(bloc.currentState.isInitialized, true);

      const countries2 = [
        MatexCountryMetadata(
          id: 'fr',
          currency: 'EUR',
          code: 'FR',
        ),
        MatexCountryMetadata(
          id: 'de',
          currency: 'EUR',
          code: 'DE',
        ),
      ];

      bloc.addEvent(MatexCountryBlocEvent.initialized(countries2));

      await expectLater(
        bloc.onData,
        emitsInOrder([
          MatexCountryBlocState(
            isInitializing: false,
            isInitialized: true,
            countries: countries,
          ),
        ]),
      );
    });

    group('findOneByCountryCode', () {
      test('returns correct country metadata for a given country code',
          () async {
        final result = await bloc.findOneByCountryCode('US');

        expect(result, isNotNull);
        expect(result?.id, 'us');
        expect(result?.currency, 'USD');
        expect(result?.code, 'US');
      });

      test('returns null if country code is not found', () async {
        // ZZ is not a valid country code.
        final result = await bloc.findOneByCountryCode('ZZ');

        expect(result, isNull);
      });

      test('handles case-insensitive country codes', () async {
        final resultUppercase = await bloc.findOneByCountryCode('US');
        final resultLowercase = await bloc.findOneByCountryCode('us');

        expect(resultUppercase?.id, 'us');
        expect(resultLowercase?.id, 'us');
        expect(resultUppercase?.id, resultLowercase?.id);
        expect(resultUppercase?.currency, resultLowercase?.currency);
        expect(resultUppercase?.code, resultLowercase?.code);
      });
    });
  });
}
