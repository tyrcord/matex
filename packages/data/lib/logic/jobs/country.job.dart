// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fastyle_core/fastyle_core.dart';
import 'package:rxdart/rxdart.dart';

// Project imports:
import 'package:matex_data/matex_data.dart';

/// A delegate for fetching country-specific metadata in JSON format.
mixin MatexCountryJobDelegate {
  /// Retrieves the country's JSON metadata.
  ///
  /// This function is called when [MatexCountryJob] needs to fetch
  /// the country's metadata. It provides the current [BuildContext] to
  /// potentially help in obtaining the data.
  Future<String?> onGetCountryJsonMetadata(BuildContext context);
}

/// A job that initializes the country data.
///
/// This class represents a job to retrieve and process country-specific
/// metadata for the application. It uses a delegate to fetch the metadata and
/// uses a BLoC pattern to manage its state.
class MatexCountryJob extends FastJob {
  /// A singleton instance for the [MatexCountryJob].
  ///
  /// This ensures that only one instance of this job exists throughout the
  /// application's lifecycle.
  static MatexCountryJob? _singleton;

  /// The delegate used to fetch country-specific metadata.
  final MatexCountryJobDelegate? delegate;

  /// Constructs a new instance of [MatexCountryJob].
  ///
  /// Uses a factory constructor to ensure that only a single instance
  /// of this class exists. If an instance does not exist, it will be created.
  factory MatexCountryJob({MatexCountryJobDelegate? delegate}) {
    return (_singleton ??= MatexCountryJob._(delegate: delegate));
  }

  /// The private constructor used by the factory.
  ///
  /// This constructor is marked as `const`, which ensures that instances are
  /// immutable.
  const MatexCountryJob._({this.delegate})
      : super(debugLabel: 'MatexCountryJob');

  /// Initializes the job to retrieve country data.
  ///
  /// This method starts the job to retrieve and process country-specific
  /// metadata. It will fetch the data using the provided delegate, and then
  /// update the associated BLoC's state.
  @override
  Future<void> initialize(
    BuildContext context, {
    IFastErrorReporter? errorReporter,
  }) async {
    final bloc = MatexCountryBloc.instance;
    String? jsonData;

    if (delegate != null) {
      jsonData = await delegate!.onGetCountryJsonMetadata(context);
    }

    bloc.addEvent(MatexCountryBlocEvent.init(jsonData: jsonData));

    final blocState = await RaceStream([
      bloc.onError,
      bloc.onData.where((state) => state.isInitialized),
    ]).first;

    if (blocState is! MatexCountryBlocState) {
      throw blocState;
    }
  }
}
