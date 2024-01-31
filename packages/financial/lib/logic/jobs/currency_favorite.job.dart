// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_core/fastyle_core.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexCurrencyFavoriteJob extends FastJob {
  static const MatexCurrencyFavoriteJob _singleton =
      MatexCurrencyFavoriteJob._();

  factory MatexCurrencyFavoriteJob() => _singleton;

  const MatexCurrencyFavoriteJob._()
      : super(debugLabel: 'MatexCurrencyFavoriteJob');

  @override
  Future<void> initialize(
    BuildContext context, {
    IFastErrorReporter? errorReporter,
  }) async {
    final bloc = MatexCurrencyFavoriteBloc.instance;

    bloc.addEvent(const MatexCurrencyFavoriteBlocEvent.init());

    final blocState = await RaceStream([
      bloc.onError,
      bloc.onData.where((state) => state.isInitialized),
    ]).first;

    if (blocState is! MatexCurrencyFavoriteBlocState) {
      throw blocState;
    }
  }
}
