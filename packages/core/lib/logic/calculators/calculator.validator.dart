// Project imports:
import 'package:matex_core/core.dart';

/// Defines a function type that takes a [MatexCalculatorState] object and
/// returns a boolean value. This function is used to validate the state of
/// a calculator.
typedef MatexCalculatorValidator<S> = bool Function(S state);
