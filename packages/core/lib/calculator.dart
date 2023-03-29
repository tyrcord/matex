import 'package:flutter/foundation.dart';
import 'package:matex_core/core.dart';

abstract class MatexCalculator<S extends MatexCalculatorState, R> {
  @protected
  S state;
  @protected
  S defaultState;
  @protected
  R? result;
  @protected
  bool isStateValid = true;

  @protected
  List<MatexCalculatorValidator>? validators;

  bool get isValid => isStateValid;

  bool get isDirty => state != defaultState;

  MatexCalculator({
    required this.defaultState,
    required this.state,
    this.validators,
  });

  R value();

  @protected
  void updateState(S newState) {
    state = newState;
    checkValidity();
  }

  @protected
  bool checkValidity() {
    var validity = true;

    if (validators != null) {
      validity = validators!.every((validator) => validator(state));
    }

    isStateValid = validity;

    return validity;
  }
}
