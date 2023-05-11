import 'package:decimal/decimal.dart';
import 'package:fastyle_calculator/logic/logic.dart';
import 'package:flutter/foundation.dart';
import 'package:matex_core/core.dart';

abstract class MatexCalculatorBloc<
        C extends MatexCalculator,
        E extends FastCalculatorBlocEvent,
        S extends FastCalculatorBlocState,
        D extends FastCalculatorDocument,
        R extends FastCalculatorResults>
    extends HydratedFastCalculatorBloc<E, S, D, R> {
  @protected
  late final C calculator;

  @override
  Future<bool> isCalculatorStateValid() async => calculator.isValid;

  @protected
  Future<S> resetCalculatorBlocState(D document);

  @protected
  Future<void> resetCalculator(D document);

  MatexCalculatorBloc({
    required super.dataProvider,
    super.initialState,
    super.debouceComputeEvents = false,
    super.debugLabel,
  });

  @override
  @protected
  Future<S> initializeDefaultCalculatorState() async {
    return resetCalculatorBlocState(document);
  }

  @override
  @mustCallSuper
  Future<S> initializeCalculatorState() async {
    await resetCalculator(document);

    return super.initializeCalculatorState();
  }

  @override
  @mustCallSuper
  Future<S> clearCalculatorState() async {
    await super.clearCalculatorState();
    await resetCalculator(defaultDocument);

    return resetCalculatorBlocState(defaultDocument);
  }

  @override
  Future<void> handleComputeError(dynamic error) async {
    //TODO: handle compute error
  }

  double? parseStringToDouble(String? value) {
    if (value is String && value.isNotEmpty) {
      final dValue = Decimal.tryParse(value);

      return dValue?.toDouble();
    }

    return null;
  }
}
