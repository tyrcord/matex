import 'package:matex_dart/matex_dart.dart';

import 'package:tbloc/tbloc.dart';

/// The state of the `MatexInstrumentBloc`.
class MatexCurrencyBlocState extends BlocState {
  /// The list of currencies.
  final List<MatexInstrumentMetadata> currencies;

  /// Creates a new `MatexInstrumentBlocState`.
  ///
  /// [currencies] is an optional parameter that defaults to an empty list.
  MatexCurrencyBlocState({
    List<MatexInstrumentMetadata>? currencies,
    super.isInitializing = false,
    super.isInitialized = false,
  }) : currencies = currencies ?? const [];

  @override
  MatexCurrencyBlocState copyWith({
    List<MatexInstrumentMetadata>? currencies,
    bool? isInitializing,
    bool? isInitialized,
  }) {
    return MatexCurrencyBlocState(
      currencies: currencies ?? this.currencies,
      isInitialized: isInitialized ?? this.isInitialized,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }

  @override
  MatexCurrencyBlocState clone() => copyWith();

  @override
  MatexCurrencyBlocState merge(covariant MatexCurrencyBlocState model) {
    return copyWith(
      currencies: model.currencies,
      isInitialized: model.isInitialized,
      isInitializing: model.isInitializing,
    );
  }

  @override
  List<Object> get props => [
        currencies,
        isInitializing,
        isInitialized,
      ];
}
