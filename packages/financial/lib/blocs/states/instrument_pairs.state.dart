// Package imports:
import 'package:matex_dart/matex_dart.dart' show MatexPairMetadata;
import 'package:tbloc/tbloc.dart';

/// The state of the `MatexInstrumentBloc`.
class MatexInstrumentPairsBlocState extends BlocState {
  /// The list of instrument pairs.
  final List<MatexPairMetadata> instrumentPairs;

  /// Creates a new `MatexInstrumentBlocState`.
  ///
  /// [instruments] is an optional parameter that defaults to an empty list.
  MatexInstrumentPairsBlocState({
    List<MatexPairMetadata>? instrumentPairs,
    super.isInitializing = false,
    super.isInitialized = false,
  }) : instrumentPairs = instrumentPairs ?? const [];

  @override
  MatexInstrumentPairsBlocState copyWith({
    List<MatexPairMetadata>? instrumentPairs,
    bool? isInitializing,
    bool? isInitialized,
  }) {
    return MatexInstrumentPairsBlocState(
      instrumentPairs: instrumentPairs ?? this.instrumentPairs,
      isInitialized: isInitialized ?? this.isInitialized,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }

  @override
  MatexInstrumentPairsBlocState clone() => copyWith();

  @override
  MatexInstrumentPairsBlocState merge(
      covariant MatexInstrumentPairsBlocState model) {
    return copyWith(
      instrumentPairs: model.instrumentPairs,
      isInitialized: model.isInitialized,
      isInitializing: model.isInitializing,
    );
  }

  @override
  List<Object> get props => [
        instrumentPairs,
        isInitializing,
        isInitialized,
      ];
}
