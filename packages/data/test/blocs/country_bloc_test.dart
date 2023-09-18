import 'package:flutter_test/flutter_test.dart';
import 'package:matex_data/matex_data.dart';

void main() {
  const countries = [
    MatexCountryMetadata(
      id: 'us',
      currency: 'USD',
    ),
    MatexCountryMetadata(
      id: 'ca',
      currency: 'CAD',
    ),
  ];

  group('MatexCountryBloc', () {
    // singleton instance, so keep in order
    final bloc = MatexCountryBloc(
      jsonData: '{"us": { "currency": "USD" }, "ca": { "currency": "CAD" }}',
    );

    test('initial state is correct', () {
      expect(bloc.currentState, MatexCountryBlocState());
    });

    test('handleInitializedEvent does not set state if not initializing',
        () async {
      expect(bloc.currentState.isInitializing, false);
      expect(bloc.currentState.isInitialized, false);
      bloc.addEvent(const MatexCountryBlocEvent.initialized(countries));

      await expectLater(
        bloc.onData,
        emitsInOrder([MatexCountryBlocState()]),
      );
    });

    test('handleInitEvent should init the bloc', () async {
      bloc.addEvent(const MatexCountryBlocEvent.init());

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
        ),
        MatexCountryMetadata(
          id: 'de',
          currency: 'EUR',
        ),
      ];

      bloc.addEvent(const MatexCountryBlocEvent.initialized(countries2));

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
  });
}
