// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:fastyle_core/fastyle_core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';

mixin MatexCalculatorFormatterMixin {
  /// An optional delegate for handling MatexCalculatorBloc-specific tasks.
  /// This delegate can be used to load metadata, retrieve user information...
  ///
  /// If not provided, it will be `null`.
  late final FastCalculatorBlocDelegate? delegate;

  /// Retrieves the user's locale code.
  ///
  /// If the `delegate` provides a locale code, it will be returned. Otherwise,
  /// it attempts to derive the locale code from the app settings and device
  /// information.
  @protected
  String getUserLocaleCode() {
    String? localeCode = delegate?.getUserLocaleCode();
    localeCode ??= FastAppSettingsBloc.instance.currentState.localeCode;

    return localeCode;
  }

  /// Retrieves the country code of the device.
  ///
  /// This method accesses the current state of the `FastAppInfoBloc` to
  /// obtain the country code that the device is registered in or operating.
  /// The country code is often used for localizing user experiences.
  ///
  /// Returns a `String` representing the country code of the device,
  /// or `null` if it's not available or cannot be determined.
  String? getDeviceCountryCode() {
    final appInfo = FastAppInfoBloc.instance.currentState;

    return appInfo.deviceCountryCode;
  }

  /// Retrieves the user's currency code.
  ///
  /// If the `delegate` provides a currency code, it will be returned.
  @protected
  String getUserCurrencyCode() {
    final currencyCode = delegate?.getUserCurrencyCode();
    final appSettings = FastAppSettingsBloc.instance.currentState;

    return currencyCode ?? appSettings.primaryCurrencyCode.toUpperCase();
  }

  /// Retrieves the user's currency symbol using the provided locale and
  /// currency code.
  ///
  /// If the `delegate` provides a locale code, it is used. Otherwise,
  /// the user's locale code is derived from the app settings and
  /// device information.
  @protected
  String getUserCurrencySymbol() {
    return getCurrencySymbol(
      localeCode: getUserLocaleCode(),
      currencyCode: getUserCurrencyCode(),
    );
  }

  @protected

  /// Localizes a percentage value according to the specified parameters.
  ///
  /// The `value` is the numeric value to be formatted as a percentage.
  /// The `locale` parameter specifies the locale to use for formatting.
  /// `minimumFractionDigits` and `maximumFractionDigits` control the precision
  /// of the formatted percentage.
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

  /// Localizes a numeric value according to the specified parameters.
  ///
  /// The `value` is the numeric value to be formatted.
  /// The `locale` parameter specifies the locale to use for formatting.
  /// `minimumFractionDigits` and `maximumFractionDigits` control the precision
  /// of the formatted number.
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

  /// Localizes a currency value according to the specified parameters.
  ///
  /// The `value` is the numeric value to be formatted as currency.
  /// The `symbol` is the currency symbol to use (if not provided, it uses the
  /// user's currency code).
  /// The `locale` parameter specifies the locale to use for formatting.
  /// `minimumFractionDigits` and `maximumFractionDigits` control the precision
  /// of the formatted currency.
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

  /// Localizes the provided Unix timestamp in milliseconds based on user's
  /// preferences and locale.
  ///
  /// It considers the user's format preference (24-hour or 12-hour) and
  /// utilizes device-specific locale settings for accurate localization.
  ///
  /// Parameters:
  ///   - `timestampInMilliseconds`: The Unix timestamp in milliseconds to be
  ///                                localized.
  ///
  /// Returns a `Future<String>` that when completed, provides the localized
  /// timestamp as a string.
  Future<String> localizeTimestampInMilliseconds(
    int timestampInMilliseconds,
  ) async {
    final appSettingsBloc = FastAppSettingsBloc.instance;

    return formatTimestampInMilliseconds(
      use24HourFormat: appSettingsBloc.currentState.use24HourFormat,
      countryCode: getDeviceCountryCode(),
      languageCode: getUserLocaleCode(),
      timestamp: timestampInMilliseconds,
    );
  }
}
