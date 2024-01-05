// Dart imports:
import 'dart:async';
import 'dart:io';

// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:fastyle_core/fastyle_core.dart';
import 'package:lingua_core/generated/locale_keys.g.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

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
    extends HydratedFastCalculatorBloc<E, S, D, R>
    with MatexCalculatorFormatterMixin {
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

  /// A callback function for showing an export PDF dialog in the UI.
  /// This callback can be used to display a dialog for exporting PDF documents.
  ///
  /// If not provided, it will be `null`.
  final MatexPdfDialogCallback? showExportPdfDialog;

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
    super.debouceComputeEvents = false,
    super.isAutoRefreshEnabled = false,
    super.autoRefreshPeriod,
    this.showExportPdfDialog,
    super.initialState,
    super.debugLabel,
    FastCalculatorBlocDelegate? delegate,
    super.getContext,
  }) {
    this.delegate = delegate;
  }

  /// Initializes the default calculator state.
  ///
  /// Returns a `Future` that completes with the new state of the bloc.
  @override
  @protected
  Future<S> initializeDefaultCalculatorState() async {
    return resetCalculatorBlocState(defaultDocument);
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

  @override
  @protected
  Future<bool> canSaveUserEntry() async {
    return appSettingsBloc.currentState.saveEntry;
  }

  /// Clears the calculator state.
  ///
  /// Returns a `Future` that completes with the new state of the bloc.
  @override
  @mustCallSuper
  Future<S> clearCalculatorState() async {
    await super.clearCalculatorState();
    await resetCalculator(defaultDocument);

    final metadata = await loadMetadata();
    final clearedState = await resetCalculatorBlocState(defaultDocument);

    return clearedState.copyWith(metadata: metadata) as S;
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
    if (context != null) {
      FastNotificationCenter.error(
        context!,
        CoreLocaleKeys.core_error_error_occurred_please.tr(),
      );
    }
  }

  /// Loads the metadata of the calculator.
  @override
  @mustCallSuper
  Future<Map<String, dynamic>> loadMetadata() async {
    Map<String, dynamic>? metadata = await delegate?.loadMetadata();

    if (metadata == null) {
      metadata = await super.loadMetadata();

      return {
        ...metadata,
        'userCurrencySymbol': getUserCurrencySymbol(),
        'userCurrencyCode': getUserCurrencyCode(),
        'userLocaleCode': getUserLocaleCode(),
      };
    }

    return metadata;
  }

  void listenOnDefaultValueChanges(String defaultValueKey, String stateKey) {
    final appDictBloc = FastAppDictBloc.instance;

    subxList.add(appDictBloc.onData
        .where((event) => isInitialized)
        .distinct((previous, next) {
      final previousValue = previous.getValue(defaultValueKey);
      final nextValue = next.getValue(defaultValueKey);

      return previousValue == nextValue;
    }).listen((state) {
      handleDefaultValueChanges(defaultValueKey, stateKey, state);
    }));
  }

  void handleDefaultValueChanges(
    String defaultValueKey,
    String stateKey,
    FastAppDictBlocState state,
  ) {
    addEvent(FastCalculatorBlocEvent.retrieveDefaultValues());

    addEvent(FastCalculatorBlocEvent.patchValue(
      value: state.getValue(defaultValueKey),
      key: stateKey,
    ));
  }

  @override
  Future<void> exportToPdf(BuildContext context) async {
    if (calculator.isValid) {
      XFile? file;

      showExportPdfDialog?.call(
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

  @protected
  String getReportFilename() => 'report';

  @protected
  Future<XFile> toPdfFile(BuildContext context) async {
    final pdfBytes = await toPdf(context);

    return createPdfXFile(pdfBytes, getReportFilename());
  }

  @protected
  Future<Uint8List> toPdf(BuildContext context) async {
    throw UnimplementedError('toPdf() is not implemented');
  }

  // Function to write bytes to a file and return an XFile
  @protected
  Future<XFile> createPdfXFile(List<int> bytes, String newFileName) async {
    // Get temporary directory
    final directory = await getTemporaryDirectory();

    // Format the current date
    final now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final filePath = '${directory.path}/${newFileName}_$formattedDate.pdf';
    // Write bytes to the file
    final file = File(filePath);
    await file.writeAsBytes(bytes);

    // Create an XFile from the file path
    return XFile(file.path, mimeType: 'application/pdf');
  }
}
