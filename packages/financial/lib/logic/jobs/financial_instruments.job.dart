// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_core/fastyle_core.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

class MatexFinancialInstrumentsJob extends FastJob {
  static const MatexFinancialInstrumentsJob _singleton =
      MatexFinancialInstrumentsJob._();

  factory MatexFinancialInstrumentsJob() => _singleton;

  const MatexFinancialInstrumentsJob._()
      : super(debugLabel: 'MatexFinancialInstrumentsJob');

  @override
  Future<void> initialize(
    BuildContext context, {
    IFastErrorReporter? errorReporter,
  }) async {
    final bloc = MatexFinancialInstrumentsBloc.instance;

    bloc.addEvent(const MatexFinancialInstrumentsBlocEvent.init());

    final blocState = await RaceStream([
      bloc.onError,
      bloc.onData.where((state) => state.isInitialized),
    ]).first;

    if (blocState is! MatexFinancialInstrumentsBlocState) {
      throw blocState;
    }
  }
}
