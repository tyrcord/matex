// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'package:matex_core/core.dart';

/// An abstract class representing a calculator with a state of type [S] and a
/// result of type [R].
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

  /// Returns true if the current state is valid.
  bool get isValid => isStateValid;

  /// Returns true if the current state is different from the default state.
  bool get isDirty => state != defaultState;

  /// Creates a new instance of [MatexCalculator].
  ///
  /// [state] is the initial state of the calculator. If null, [initializeState]
  /// is called to create the initial state.
  ///
  /// [defaultState] is the default state of the calculator. If null,
  /// [initializeDefaultState] is called to create the default state.
  ///
  /// [validators] is a list of validators to check the validity of the state.
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

  /// Initializes the default state of the calculator.
  S initializeDefaultState() => throw UnimplementedError();

  /// Initializes the state of the calculator.
  S initializeState() => throw UnimplementedError();

  /// Returns the current value of the calculator.
  R value();

  /// Sets the state of the calculator to [newState].
  void setState(S newState) {
    state = newState;
    checkValidity();
  }

  S getState() => state.clone() as S;

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
