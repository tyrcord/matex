// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_core/fastyle_core.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexInstrumentFavoriteJob extends FastJob {
  static const MatexInstrumentFavoriteJob _singleton =
      MatexInstrumentFavoriteJob._();

  factory MatexInstrumentFavoriteJob() => _singleton;

  const MatexInstrumentFavoriteJob._()
      : super(debugLabel: 'MatexInstrumentFavoriteJob');

  @override
  Future<void> initialize(
    BuildContext context, {
    IFastErrorReporter? errorReporter,
  }) async {
    final bloc = MatexInstrumentFavoriteBloc.instance;

    bloc.addEvent(const MatexInstrumentFavoriteBlocEvent.init());

    final blocState = await RaceStream([
      bloc.onError,
      bloc.onData.where((state) => state.isInitialized),
    ]).first;

    if (blocState is! MatexInstrumentFavoriteBlocState) {
      throw blocState;
    }
  }
}
