// Package imports:
import 'package:tbloc/tbloc.dart';

// Project imports:
import 'package:matex_data/matex_data.dart';

/// Represents events that can be dispatched to the [MatexCountryBloc].
///
/// This class extends the [BlocEvent] class from the `tbloc` package. It
/// provides two specific events for the [MatexCountryBloc]: initialization
/// (`init`) and post-initialization (`initialized`).
///
/// - `init` event: Indicates that the bloc should be initialized.
/// - `initialized` event: Informs that the bloc has been successfully
/// initialized with a list of [MatexCountryMetadata] objects.
class MatexCountryBlocEvent
    extends BlocEvent<MatexCountryBlocEventType, MatexCountryBlocEventPayload> {
  /// Creates an `init` event for the [MatexCountryBloc].
  ///
  /// Optionally, JSON data can be provided as part of the initialization.
  ///
  /// - [jsonData]: A JSON formatted string (optional).
  MatexCountryBlocEvent.init({String? jsonData})
      : super(
          type: MatexCountryBlocEventType.init,
          payload: MatexCountryBlocEventPayload(jsonData: jsonData),
        );

  /// Creates an `initialized` event for the [MatexCountryBloc].
  ///
  /// This event carries a payload with a list of [MatexCountryMetadata]
  /// objects, indicating successful initialization.
  ///
  /// - [countries]: A list of `MatexCountryMetadata` instances.
  MatexCountryBlocEvent.initialized(
    List<MatexCountryMetadata> countries,
  ) : super(
          type: MatexCountryBlocEventType.initialized,
          payload: MatexCountryBlocEventPayload(countries: countries),
        );
}
