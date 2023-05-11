import 'package:flutter/foundation.dart';
import 'package:matex_core/core.dart';

abstract class MatexCalculator<S extends MatexCalculatorState, R> {
  @protected
  late S state;
  @protected
  late S defaultState;
  @protected
  R? result;
  @protected
  bool isStateValid = true;

  @protected
  List<MatexCalculatorValidator>? validators;

  bool get isValid => isStateValid;

  bool get isDirty => state != defaultState;

  MatexCalculator({
    S? state,
    S? defaultState,
    this.validators,
  }) {
    if (state != null) {
      this.state = state;
    } else {
      this.state = initializeState();
    }

    if (defaultState != null) {
      this.defaultState = defaultState;
    } else {
      this.defaultState = initializeDefaultState();
    }
  }

  S initializeDefaultState() => throw UnimplementedError();

  S initializeState() => throw UnimplementedError();

  R value();

  void setState(S newState) {
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
