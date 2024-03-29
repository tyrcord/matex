// Package imports:
import 'package:tbloc/tbloc.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

/// The state of the `MatexFinancialInstrumentBloc`.
class MatexFinancialInstrumentsBlocState extends BlocState {
  /// The list of financial instruments.
  final List<MatexPairMetadata> instruments;

  /// Creates a new `MatexInstrumentBlocState`.
  ///
  /// [instruments] is an optional parameter that defaults to an empty list.
  MatexFinancialInstrumentsBlocState({
    List<MatexPairMetadata>? instruments,
    super.isInitializing = false,
    super.isInitialized = false,
  }) : instruments = instruments ?? const [];

  @override
  MatexFinancialInstrumentsBlocState copyWith({
    List<MatexPairMetadata>? instruments,
    bool? isInitializing,
    bool? isInitialized,
  }) {
    return MatexFinancialInstrumentsBlocState(
      instruments: instruments ?? this.instruments,
      isInitialized: isInitialized ?? this.isInitialized,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }

  @override
  MatexFinancialInstrumentsBlocState clone() => copyWith();

  @override
  MatexFinancialInstrumentsBlocState merge(
    covariant MatexFinancialInstrumentsBlocState model,
  ) {
    return copyWith(
      instruments: model.instruments,
      isInitialized: model.isInitialized,
      isInitializing: model.isInitializing,
    );
  }

  @override
  List<Object> get props => [
        instruments,
        isInitializing,
        isInitialized,
      ];
}
