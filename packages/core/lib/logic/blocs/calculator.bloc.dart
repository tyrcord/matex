// Flutter imports:
import 'dart:async';

import 'package:fastyle_core/fastyle_core.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:decimal/decimal.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_helpers/helpers.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import 'package:matex_core/core.dart';

/// An abstract class that defines the structure of a calculator bloc that uses
/// the `matex_core` library.
///
/// This class extends the `HydratedFastCalculatorBloc` class and provides
/// additional functionality for working with the `matex_core` library.
///
/// The type parameters are:
///
/// * `C`: The type of calculator to use.
/// * `E`: The type of events that the bloc will receive.
/// * `S`: The type of states that the bloc will emit.
/// * `D`: The type of document that the calculator will use.
/// * `R`: The type of results that the calculator will produce.
abstract class MatexCalculatorBloc<
        C extends MatexCalculator,
        E extends FastCalculatorBlocEvent,
        S extends FastCalculatorBlocState,
        D extends FastCalculatorDocument,
        R extends FastCalculatorResults>
    extends HydratedFastCalculatorBloc<E, S, D, R> {
  @protected
  late final C calculator;

  /// Checks if the current calculator state is valid.
  ///
  /// Returns `true` if the calculator state is valid, `false` otherwise.
  @override
  Future<bool> isCalculatorStateValid() async => calculator.isValid;

  /// Resets the calculator bloc state to its initial state.
  ///
  /// This method should be implemented by subclasses.
  ///
  /// Returns a `Future` that completes with the new state of the bloc.
  @protected
  Future<S> resetCalculatorBlocState(D document);

  /// Resets the calculator to its initial state.
  ///
  /// This method should be implemented by subclasses.
  ///
  /// Returns a `Future` that completes when the calculator has been reset.
  @protected
  Future<void> resetCalculator(D document);

  /// Creates a new instance of the `MatexCalculatorBloc`.
  ///
  /// The `dataProvider` parameter is required and specifies the data provider
  /// to use.
  ///
  /// The `initialState` parameter specifies the initial state of the bloc.
  ///
  /// The `debouceComputeEvents` parameter specifies whether to debounce compute
  /// events.
  ///
  /// The `debugLabel` parameter specifies a label to use for debugging.
  MatexCalculatorBloc({
    required super.dataProvider,
    super.initialState,
    super.debouceComputeEvents = false,
    super.debugLabel,
  });

  /// Initializes the default calculator state.
  ///
  /// Returns a `Future` that completes with the new state of the bloc.
  @override
  @protected
  Future<S> initializeDefaultCalculatorState() async {
    return resetCalculatorBlocState(document);
  }

  /// Initializes the calculator state.
  ///
  /// Returns a `Future` that completes with the new state of the bloc.
  @override
  @mustCallSuper
  Future<S> initializeCalculatorState() async {
    await resetCalculator(document);

    return super.initializeCalculatorState();
  }

  /// Clears the calculator state.
  ///
  /// Returns a `Future` that completes with the new state of the bloc.
  @override
  @mustCallSuper
  Future<S> clearCalculatorState() async {
    await super.clearCalculatorState();
    await resetCalculator(defaultDocument);

    return resetCalculatorBlocState(defaultDocument);
  }

  /// Handles compute errors.
  ///
  /// This method should be implemented by subclasses.
  ///
  /// The `error` parameter is the error that occurred.
  ///
  /// Returns a `Future` that completes when the error has been handled.
  @override
  Future<void> handleComputeError(dynamic error) async {
    //TODO: handle compute error
  }

  /// Loads the metadata of the calculator.
  @override
  @mustCallSuper
  Future<Map<String, dynamic>> loadMetadata() async {
    return <String, dynamic>{
      'userCurrencySymbol': getUserCurrencySymbol(),
      'userCurrencyCode': getUserCurrencyCode(),
      'userLocaleCode': getUserLocaleCode(),
    };
  }

  @override
  Future<void> shareCalculatorState(BuildContext context) async {
    if (calculator.isValid) {
      XFile? file;

      showExportPdfDialog(
        context: context,
        onCreateOperation: () async {
          file = await toPdfFile(context);

          return true;
        },
        onValid: (FastOperationStatus status) {
          if (status == FastOperationStatus.operationSucceeded &&
              context.mounted &&
              file != null) {
            final box = context.findRenderObject() as RenderBox?;

            Share.shareXFiles(
              [file!],
              sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
            );
          }
        },
      );
    }
  }

  Future<XFile> toPdfFile(BuildContext context) async {
    final pdfBytes = await toPdf(context);

    return XFile.fromData(pdfBytes, mimeType: 'application/pdf');
  }

  Future<Uint8List> toPdf(BuildContext context) async {
    throw UnimplementedError('toPdf() is not implemented');
  }

  /// Parses a string to a double.
  ///
  /// The `value` parameter is the string to parse.
  ///
  /// Returns the parsed double, or `null` if the string could not be parsed.
  double? parseStringToDouble(String? value) {
    if (value is String && value.isNotEmpty) {
      final dValue = Decimal.tryParse(value);

      return dValue?.toDouble();
    }

    return null;
  }

  @protected
  String getUserLocaleCode() {
    return appSettingsBloc.currentState.localeCode;
  }

  @protected
  String getUserCurrencyCode() {
    return userSettingsBloc.currentState.primaryCurrencyCode.toUpperCase();
  }

  @protected
  String getUserCurrencySymbol() {
    final format = NumberFormat.simpleCurrency(
      locale: getUserLocaleCode(),
      name: getUserCurrencyCode(),
    );

    return format.currencySymbol;
  }

  @protected
  String localizePercentage({
    num? value,
    String? locale,
    int? minimumFractionDigits,
    int? maximumFractionDigits,
  }) {
    return formatPercentage(
      minimumFractionDigits: minimumFractionDigits,
      maximumFractionDigits: maximumFractionDigits,
      locale: locale ?? getUserLocaleCode(),
      value: value,
    );
  }

  String localizeNumber({
    num? value,
    String? locale,
    int? minimumFractionDigits,
    int? maximumFractionDigits,
  }) {
    return formatDecimal(
      minimumFractionDigits: minimumFractionDigits,
      maximumFractionDigits: maximumFractionDigits,
      locale: locale ?? getUserLocaleCode(),
      value: value,
    );
  }

  String localizeCurrency({
    num? value,
    String? symbol,
    String? locale,
    int? minimumFractionDigits,
    int? maximumFractionDigits,
  }) {
    return formatCurrency(
      minimumFractionDigits: minimumFractionDigits,
      maximumFractionDigits: maximumFractionDigits,
      locale: locale ?? getUserLocaleCode(),
      symbol: symbol ?? getUserCurrencyCode(),
      value: value,
    );
  }
}
