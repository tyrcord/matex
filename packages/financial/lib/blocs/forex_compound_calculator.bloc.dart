// Dart imports:
import 'dart:convert';
import 'dart:typed_data';

// Flutter imports:
import 'package:flutter/foundation.dart' as isolate;
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:fastyle_calculator/fastyle_calculator.dart';
import 'package:lingua_finance/generated/locale_keys.g.dart';
import 'package:lingua_number/number.dart';
import 'package:matex_core/core.dart';
import 'package:t_helpers/helpers.dart';
import 'package:tenhance/tenhance.dart';

// Project imports:
import 'package:matex_financial/financial.dart';

final _kDefaultDividendYieldBlocState = MatexForexCompoundCalculatorBlocState(
  results: const MatexForexCompoundCalculatorBlocResults(),
  fields: MatexForexCompoundCalculatorBlocFields(),
);

class MatexForexCompoundCalculatorBloc extends MatexCalculatorBloc<
    MatexCompoundInterestCalculator,
    FastCalculatorBlocEvent,
    MatexForexCompoundCalculatorBlocState,
    MatexForexCompoundCalculatorBlocDocument,
    MatexForexCompoundCalculatorBlocResults> {
  static const defaultFrequency =
      MatexForexCompoundCalculatorBlocFields.defaultFrequency;

  static const allowedRateFinancialFrequency = [
    // TODO: implement better ui for daily and weekly
    // MatexFinancialFrequency.daily,
    // MatexFinancialFrequency.weekly,
    MatexFinancialFrequency.monthly,
    MatexFinancialFrequency.quarterly,
    MatexFinancialFrequency.semiAnnually,
    MatexFinancialFrequency.annually,
  ];

  static const allowedCashFlowFinancialFrequency = [
    MatexFinancialFrequency.monthly,
    MatexFinancialFrequency.quarterly,
    MatexFinancialFrequency.semiAnnually,
    MatexFinancialFrequency.annually,
  ];

  MatexForexCompoundCalculatorBloc({
    MatexForexCompoundCalculatorBlocState? initialState,
    MatexForexCompoundCalculatorBlocDataProvider? dataProvider,
    super.debouceComputeEvents = true,
    super.getExportDialog,
    super.delegate,
    super.getContext,
  }) : super(
          initialState: initialState ?? _kDefaultDividendYieldBlocState,
          dataProvider:
              dataProvider ?? MatexForexCompoundCalculatorBlocDataProvider(),
          debugLabel: 'MatexForexCompoundCalculatorBloc',
        ) {
    calculator = MatexCompoundInterestCalculator();

    // Note: no need to listen to user account currency changes
    // because the calculator is not requiring full screen.
  }

  @override
  Future<MatexForexCompoundCalculatorBlocResults> compute() async {
    final results = await calculator.valueAsync();
    final fields = currentState.fields;
    final accountCurrency = fields.accountCurrency;
    final monthsToDoubleInvestment = results.monthsToDoubleInvestment;
    final period = convertMonthsToYearsAndMonths(monthsToDoubleInvestment);

    return MatexForexCompoundCalculatorBlocResults(
      monthsToDoubleInvestment: results.monthsToDoubleInvestment,
      formattedTimeToDoubleInvestment: localizePeriod(
        years: period['years'] ?? 0,
        months: period['months'] ?? 0,
      ),
      effectiveAnnualRate: results.effectiveAnnualRate,
      formattedEffectiveAnnualRate: localizePercentage(
        value: results.effectiveAnnualRate,
      ),
      endBalance: results.endBalance,
      formattedEndBalance: localizeCurrency(
        symbol: accountCurrency,
        value: results.endBalance,
      ),
      startBalance: results.startBalance,
      formattedStartBalance: localizeCurrency(
        symbol: accountCurrency,
        value: results.startBalance,
      ),
      totalContributions: results.totalContributions,
      formattedTotalContributions: localizeCurrency(
        symbol: accountCurrency,
        value: results.totalContributions,
      ),
      totalWithdrawals: results.totalWithdrawals,
      formattedTotalWithdrawals: localizeCurrency(
        symbol: accountCurrency,
        value: results.totalWithdrawals,
      ),
      rateOfReturn: results.rateOfReturn,
      formattedRateOfReturn: localizePercentage(value: results.rateOfReturn),
      totalEarnings: results.totalEarnings,
      formattedTotalEarnings: localizeCurrency(
        symbol: accountCurrency,
        value: results.totalEarnings,
      ),
      breakdown: results.breakdown?.map((entry) {
        return entry.copyWith(
          formattedStartBalance: localizeCurrency(
            symbol: accountCurrency,
            value: entry.startBalance,
            minimumFractionDigits: 2,
          ),
          formattedEndBalance: localizeCurrency(
            symbol: accountCurrency,
            value: entry.endBalance,
            minimumFractionDigits: 2,
          ),
          formattedEarnings: localizeCurrency(
            symbol: accountCurrency,
            value: entry.earnings,
            minimumFractionDigits: 2,
          ),
          formattedCashFlow: localizeCurrency(
            symbol: accountCurrency,
            value: entry.cashFlow,
          ),
          formattedWithdrawal: localizeCurrency(
            symbol: accountCurrency,
            value: entry.withdrawal,
            minimumFractionDigits: 2,
          ),
          formattedDeposit: localizeCurrency(
            symbol: accountCurrency,
            value: entry.deposit,
            minimumFractionDigits: 2,
          ),
          formattedTotalEarnings: localizeCurrency(
            symbol: accountCurrency,
            value: entry.totalEarnings,
            minimumFractionDigits: 2,
          ),
          formattedTotalWithdrawals: localizeCurrency(
            symbol: accountCurrency,
            value: entry.totalWithdrawals,
            minimumFractionDigits: 2,
          ),
          formattedTotalDeposits: localizeCurrency(
            symbol: accountCurrency,
            value: entry.totalDeposits,
            minimumFractionDigits: 2,
          ),
          formattedPeriod: localizeNumber(value: entry.period),
        );
      }).toList(),
    );
  }

  @override
  Future<MatexForexCompoundCalculatorBlocDocument?> patchCalculatorDocument(
    String key,
    dynamic value,
  ) async {
    if (value == null) {
      if (key == MatexFiancialCalculatorBlocKey.accountCurrency) {
        return document.copyWithDefaults(resetAccountCurrency: true);
      } else if (key == MatexForexCompoundCalculatorBlocKey.startBalance) {
        return document.copyWithDefaults(resetStartBalance: true);
      } else if (key == MatexForexCompoundCalculatorBlocKey.rate) {
        return document.copyWithDefaults(resetRate: true);
      } else if (key == MatexForexCompoundCalculatorBlocKey.duration) {
        return document.copyWithDefaults(resetDuration: true);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.contributionFrequency) {
        return document.copyWithDefaults(resetContributionFrequency: true);
      } else if (key == MatexForexCompoundCalculatorBlocKey.compoundFrequency) {
        return document.copyWithDefaults(resetCompoundFrequency: true);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.withdrawalFrequency) {
        return document.copyWithDefaults(resetWithdrawalFrequency: true);
      } else if (key == MatexForexCompoundCalculatorBlocKey.withdrawalAmount) {
        return document.copyWithDefaults(resetWithdrawalAmount: true);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.additionalContribution) {
        return document.copyWithDefaults(resetAdditionalContribution: true);
      } else if (key == MatexForexCompoundCalculatorBlocKey.rateFrequency) {
        return document.copyWithDefaults(
          resetRateFrequency: true,
          resetContributionFrequency: true,
          resetWithdrawalFrequency: true,
          resetCompoundFrequency: true,
        );
      }
    } else if (value is String) {
      if (key == MatexFiancialCalculatorBlocKey.accountCurrency) {
        return document.copyWith(accountCurrency: value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.startBalance) {
        return document.copyWith(startBalance: value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.rate) {
        return document.copyWith(rate: value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.duration) {
        return document.copyWith(duration: value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.withdrawalAmount) {
        return document.copyWith(withdrawalAmount: value);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.additionalContribution) {
        return document.copyWith(additionalContribution: value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.rateFrequency) {
        final frequency = MatexFinancialFrequencyX.fromName(value);

        if (frequency != null) {
          final cashFlowFrequency = _getCashFlowFrequency(frequency);

          return document.copyWith(
            rateFrequency: value,
            compoundFrequency: value,
            contributionFrequency: cashFlowFrequency.name,
            withdrawalFrequency: cashFlowFrequency.name,
          );
        }
      } else {
        final frequency = MatexFinancialFrequencyX.fromName(value);

        if (frequency != null &&
            frequency >= currentState.fields.rateFrequency) {
          if (key ==
              MatexForexCompoundCalculatorBlocKey.contributionFrequency) {
            return document.copyWith(contributionFrequency: value);
          } else if (key ==
              MatexForexCompoundCalculatorBlocKey.compoundFrequency) {
            return document.copyWith(compoundFrequency: value);
          } else if (key ==
              MatexForexCompoundCalculatorBlocKey.withdrawalFrequency) {
            return document.copyWith(withdrawalFrequency: value);
          }
        }
      }
    } else if (value is MatexFinancialFrequency) {
      if (key == MatexForexCompoundCalculatorBlocKey.rateFrequency) {
        final cashFlowFrequency = _getCashFlowFrequency(value);

        return document.copyWith(
          contributionFrequency: cashFlowFrequency.name,
          withdrawalFrequency: cashFlowFrequency.name,
          compoundFrequency: value.name,
          rateFrequency: value.name,
        );
      } else if (value >= currentState.fields.rateFrequency) {
        if (key == MatexForexCompoundCalculatorBlocKey.contributionFrequency) {
          return document.copyWith(contributionFrequency: value.name);
        } else if (key ==
            MatexForexCompoundCalculatorBlocKey.compoundFrequency) {
          return document.copyWith(compoundFrequency: value.name);
        } else if (key ==
            MatexForexCompoundCalculatorBlocKey.withdrawalFrequency) {
          return document.copyWith(withdrawalFrequency: value.name);
        }
      }
    }

    return null;
  }

  @override
  Future<MatexForexCompoundCalculatorBlocState?> patchCalculatorState(
    String key,
    dynamic value,
  ) async {
    if (value is String?) {
      if (key == MatexFiancialCalculatorBlocKey.accountCurrency) {
        return patchAccountCurrency(value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.startBalance) {
        return patchStartBalance(value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.rate) {
        return patchRate(value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.duration) {
        return patchDuration(value);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.contributionFrequency) {
        return patchContributionFrequency(value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.compoundFrequency) {
        return patchCompoundFrequency(value);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.withdrawalFrequency) {
        return patchWithdrawalFrequency(value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.rateFrequency) {
        return patchRateFrequency(value);
      } else if (key == MatexForexCompoundCalculatorBlocKey.withdrawalAmount) {
        return patchWithdrawalAmount(value);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.additionalContribution) {
        return patchAdditionalContribution(value);
      }
    } else if (value is MatexFinancialFrequency) {
      if (key == MatexForexCompoundCalculatorBlocKey.rateFrequency) {
        return patchRateFrequency(value.name);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.withdrawalFrequency) {
        return patchWithdrawalFrequency(value.name);
      } else if (key == MatexForexCompoundCalculatorBlocKey.compoundFrequency) {
        return patchCompoundFrequency(value.name);
      } else if (key ==
          MatexForexCompoundCalculatorBlocKey.contributionFrequency) {
        return patchContributionFrequency(value.name);
      }
    }

    return currentState;
  }

  @override
  Future<void> resetCalculator(
    MatexForexCompoundCalculatorBlocDocument document,
  ) async {
    final rateFrequency = document.rateFrequency;
    final compoundFrequency = document.compoundFrequency;
    final contributionFrequency = document.contributionFrequency;
    final withdrawalFrequency = document.withdrawalFrequency;
    final dRate = parseStringToDouble(document.rate);

    calculator.setState(MatexCompoundInterestCalculatorState(
      rateFrequency: MatexFinancialFrequencyX.fromName(rateFrequency),
      compoundFrequency: MatexFinancialFrequencyX.fromName(compoundFrequency),
      contributionFrequency:
          MatexFinancialFrequencyX.fromName(contributionFrequency),
      withdrawalFrequency:
          MatexFinancialFrequencyX.fromName(withdrawalFrequency),
      startBalance: tryParseStringToDouble(document.startBalance),
      rate: (dRate / 100),
      duration: tryParseStringToInt(document.duration),
      withdrawalAmount: tryParseStringToDouble(document.withdrawalAmount),
      additionalContribution:
          tryParseStringToDouble(document.additionalContribution),
    ));
  }

  @override
  Future<MatexForexCompoundCalculatorBlocState> resetCalculatorBlocState(
    MatexForexCompoundCalculatorBlocDocument document,
  ) async {
    final rateFrequency = document.rateFrequency;
    final compoundFrequency = document.compoundFrequency;
    final contributionFrequency = document.contributionFrequency;
    final withdrawalFrequency = document.withdrawalFrequency;

    return _kDefaultDividendYieldBlocState.copyWith(
      results: await retrieveDefaultResult(),
      fields: MatexForexCompoundCalculatorBlocFields(
        rateFrequency: MatexFinancialFrequencyX.fromName(rateFrequency),
        compoundFrequency: MatexFinancialFrequencyX.fromName(compoundFrequency),
        contributionFrequency:
            MatexFinancialFrequencyX.fromName(contributionFrequency),
        withdrawalFrequency:
            MatexFinancialFrequencyX.fromName(withdrawalFrequency),
        startBalance: document.startBalance,
        rate: document.rate,
        duration: document.duration,
        withdrawalAmount: document.withdrawalAmount,
        additionalContribution: document.additionalContribution,
        accountCurrency: document.accountCurrency,
      ),
    );
  }

  @override
  Future<MatexForexCompoundCalculatorBlocDocument>
      retrieveDefaultCalculatorDocument() async {
    return MatexForexCompoundCalculatorBlocDocument(
      accountCurrency: getUserCurrencyCode(),
    );
  }

  @override
  Future<MatexForexCompoundCalculatorBlocResults>
      retrieveDefaultResult() async {
    final fields = currentState.fields;
    final accountCurrency = fields.accountCurrency;

    return MatexForexCompoundCalculatorBlocResults(
      formattedEndBalance: localizeCurrency(symbol: accountCurrency, value: 0),
      endBalance: 0,
    );
  }

  MatexForexCompoundCalculatorBlocState patchAccountCurrency(String? value) {
    late final MatexForexCompoundCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(resetAccountCurrency: true);
    } else {
      fields = currentState.fields.copyWith(accountCurrency: value);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchStartBalance(String? value) {
    late MatexForexCompoundCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetStartBalance: true,
      );

      calculator.startBalance = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(startBalance: value);
      calculator.startBalance = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchRate(String? value) {
    late MatexForexCompoundCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetRate: true,
      );

      calculator.rate = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(rate: value);
      calculator.rate = (dValue / 100);
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchDuration(String? value) {
    late MatexForexCompoundCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetDuration: true,
      );

      calculator.duration = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(duration: value);
      calculator.duration = dValue.toInt();
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchContributionFrequency(
    String? value,
  ) {
    late MatexForexCompoundCalculatorBlocFields fields;
    final frequency = MatexFinancialFrequencyX.fromName(value);

    if (frequency == null) {
      fields = currentState.fields.copyWithDefaults(
        resetContributionFrequency: true,
      );

      calculator.contributionFrequency = defaultFrequency;
    } else if (frequency >= currentState.fields.rateFrequency) {
      fields = currentState.fields.copyWith(contributionFrequency: frequency);
      calculator.contributionFrequency = frequency;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchCompoundFrequency(
    String? value,
  ) {
    late MatexForexCompoundCalculatorBlocFields fields;
    final frequency = MatexFinancialFrequencyX.fromName(value);

    if (frequency == null) {
      fields = currentState.fields.copyWithDefaults(
        resetCompoundFrequency: true,
      );

      calculator.compoundFrequency = defaultFrequency;
    } else if (frequency >= currentState.fields.rateFrequency) {
      fields = currentState.fields.copyWith(compoundFrequency: frequency);
      calculator.compoundFrequency = frequency;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchWithdrawalFrequency(
    String? value,
  ) {
    late MatexForexCompoundCalculatorBlocFields fields;
    final frequency = MatexFinancialFrequencyX.fromName(value);

    if (frequency == null) {
      fields = currentState.fields.copyWithDefaults(
        resetWithdrawalFrequency: true,
      );
      calculator.withdrawalFrequency = defaultFrequency;
    } else if (frequency >= currentState.fields.rateFrequency) {
      fields = currentState.fields.copyWith(withdrawalFrequency: frequency);
      calculator.withdrawalFrequency = frequency;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchRateFrequency(
    String? value,
  ) {
    late MatexForexCompoundCalculatorBlocFields fields;
    final frequency = MatexFinancialFrequencyX.fromName(value);

    if (frequency == null) {
      fields = currentState.fields.copyWithDefaults(
        resetRateFrequency: true,
      );

      calculator
        ..rateFrequency = defaultFrequency
        ..contributionFrequency = defaultFrequency
        ..compoundFrequency = defaultFrequency
        ..withdrawalFrequency = defaultFrequency;
    } else {
      final cashFlowFrequency = _getCashFlowFrequency(frequency);

      fields = currentState.fields.copyWith(
        rateFrequency: frequency,
        compoundFrequency: frequency,
        contributionFrequency: cashFlowFrequency,
        withdrawalFrequency: cashFlowFrequency,
      );

      calculator
        ..rateFrequency = frequency
        ..compoundFrequency = frequency
        ..contributionFrequency = cashFlowFrequency
        ..withdrawalFrequency = cashFlowFrequency;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchWithdrawalAmount(String? value) {
    late MatexForexCompoundCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetWithdrawalAmount: true,
      );

      calculator.withdrawalAmount = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(withdrawalAmount: value);
      calculator.withdrawalAmount = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexForexCompoundCalculatorBlocState patchAdditionalContribution(
    String? value,
  ) {
    late MatexForexCompoundCalculatorBlocFields fields;

    if (value == null) {
      fields = currentState.fields.copyWithDefaults(
        resetAdditionalContribution: true,
      );

      calculator.additionalContribution = 0;
    } else {
      final dValue = parseStringToDouble(value);
      fields = currentState.fields.copyWith(additionalContribution: value);
      calculator.additionalContribution = dValue;
    }

    return currentState.copyWith(fields: fields);
  }

  MatexFinancialFrequency _getCashFlowFrequency(
    MatexFinancialFrequency frequency,
  ) {
    return allowedCashFlowFinancialFrequency.contains(frequency)
        ? frequency
        : allowedCashFlowFinancialFrequency[0];
  }

  @override
  String getReportFilename() => 'forex_compound_report';

  @override
  Future<Uint8List> toPdf(BuildContext context) async {
    final pdfGenerator = MatexForexCompoundCalculatorPdfGenerator();
    final fields = currentState.fields;
    final results = await compute();

    // ignore: use_build_context_synchronously
    return pdfGenerator.generate(context, fields, results);
  }

  @override
  Future<Uint8List> toCsv(BuildContext context) async {
    final fields = currentState.fields;
    final hasContributions = fields.additionalContribution?.isNotEmpty ?? false;
    final hasWithdrawals = fields.withdrawalAmount?.isNotEmpty ?? false;

    final results = await compute();
    final breakdown = results.breakdown ?? [];
    final columns = [
      FinanceLocaleKeys.finance_label_period.tr(),
      FinanceLocaleKeys.finance_label_starting_balance.tr(),
      if (hasContributions) FinanceLocaleKeys.finance_label_deposits.tr(),
      if (hasWithdrawals) FinanceLocaleKeys.finance_label_withdrawals_text.tr(),
      FinanceLocaleKeys.finance_label_earnings.tr(),
      FinanceLocaleKeys.finance_label_ending_balance.tr(),
    ];

    return isolate.compute((Map<String, dynamic> map) {
      final breakdown =
          map['breakdown'] as List<MatexCompoundInterestBreakdownEntry>;
      final columns = map['columns'] as List<String>;

      // Add columns
      var data = '${columns.join(',')}\n';

      // Add rows
      for (final element in breakdown) {
        data += '${element.toCsv()}\n';
      }

      // Convert the string to a byte buffer using UTF-8 encoding
      final List<int> bytesBuffer = utf8.encode(data);

      // Create a Uint8List from the byte buffer
      return Uint8List.fromList(bytesBuffer);
    }, {
      'breakdown': breakdown,
      'columns': columns,
    });
  }
}
