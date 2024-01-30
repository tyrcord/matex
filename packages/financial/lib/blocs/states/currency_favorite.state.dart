// Package imports:
import 'package:tbloc/tbloc.dart';

class MatexCurrencyFavoriteBlocState extends BlocState {
  final List<String> favorites;

  MatexCurrencyFavoriteBlocState({
    this.favorites = const [],
    super.isInitializing,
    super.isInitialized,
  });

  @override
  MatexCurrencyFavoriteBlocState copyWith({
    List<String>? favorites,
    bool? isInitializing,
    bool? isInitialized,
  }) {
    return MatexCurrencyFavoriteBlocState(
      favorites: favorites ?? this.favorites,
      isInitialized: isInitialized ?? this.isInitialized,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }

  @override
  List<Object> get props => [favorites, isInitializing, isInitialized];

  @override
  MatexCurrencyFavoriteBlocState clone() => copyWith();

  @override
  MatexCurrencyFavoriteBlocState merge(
    covariant MatexCurrencyFavoriteBlocState model,
  ) {
    return copyWith(
      favorites: model.favorites,
      isInitialized: model.isInitialized,
      isInitializing: model.isInitializing,
    );
  }
}
