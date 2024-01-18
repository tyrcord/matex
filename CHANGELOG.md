# Change Log

All notable changes to this project will be documented in this file.
See [Conventional Commits](https://conventionalcommits.org) for commit guidelines.

## 2024-01-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.37`](#matex_core---v0037)
 - [`matex_data` - `v0.0.29`](#matex_data---v0029)
 - [`matex_financial` - `v0.0.47`](#matex_financial---v0047)

---

#### `matex_core` - `v0.0.37`

 - **REFACTOR**: isMandatoryFieldValid.
 - **PERF**: minor improvement.
 - **FIX**: remove defaults min and max fraction digits.
 - **FIX**: use toSafeDouble.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: wrong initial validity.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: regression.
 - **FIX**: use right document for resetCalculatorBlocState.
 - **FIX**: make sure we keep the default metadata after reseting a calculator.
 - **FIX**: dependency requirements.
 - **FIX**: minor issue.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: update dependencies.
 - **FEAT**: support latest fastyle.
 - **FEAT**: support different export type.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add parseStringToInt.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: more tests.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to the value of a calculator asynchronously.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: override canSaveEntry.
 - **FEAT**: allow to override share user interactions.
 - **FEAT**: remove dead code.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: add matex core package.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: remove dead code.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: forex pip delta version 1.
 - **FEAT**: update dependencies.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add metadata to blocs.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(core): add default info button.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: minor improvements.
 - **FEAT**: add UserPreferences Bloc.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: support default values.

#### `matex_data` - `v0.0.29`

 - **FIX**: typo.
 - **FEAT**: update dependencies.
 - **FEAT**: update metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update currencies.
 - **FEAT**: update data.
 - **FEAT**: add jamaican dollar.
 - **FEAT**: update dependencies.
 - **FEAT**: update metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: initial commit for matex_data.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add findOneByCountryCode method.
 - **FEAT**: bunch of improvements.
 - **FEAT**: update country metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: minor perf improvements.
 - **FEAT**: add country data bloc.
 - **FEAT**: update country data.
 - **FEAT**: add id property to MatexCountryMetadata.
 - **FEAT**: add MatexCountryMetadata.
 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.47`

 - **REFACTOR**: property names.
 - **REFACTOR**: isMandatoryFieldValid.
 - **REFACTOR**: MatexFinancialInstrumentsBloc.
 - **FIX**: short positions.
 - **FIX**: typo.
 - **FIX**: use toSafeDouble.
 - **FIX**: minor improvements.
 - **FIX**: avoid to compute tax amount when profit is negative.
 - **FIX**: bunch of fixes.
 - **FIX**: typo.
 - **FIX**: bunch of fixes.
 - **FIX**: display lot size in pdfs.
 - **FIX**: bunch of fixes.
 - **FIX**: allow user default value to override default value from documents.
 - **FIX**: bunch of fixes.
 - **FIX**: Pivot Points Camarilla.
 - **FIX**: typos.
 - **FIX**: bunch of fixes.
 - **FIX**: SL/TP calculator.
 - **FIX**: wrong dependency version.
 - **FIX**: required margin.
 - **FIX**: allow negative pnl computations.
 - **FIX**: allow to reset some fields.
 - **FIX**: Pdf for Forex position Calculator.
 - **FIX**: minor improvements.
 - **FIX**: dispatch metadata in advance to avoid UI flickering.
 - **FIX**: override  getUserCurrencyCode.
 - **FIX**: reset entry price when stop loss type change.
 - **FIX**: attempts to fix tests.
 - **FIX**: typo.
 - **FIX**: deprecated use of describeEnum.
 - **FIX**: show the defaults results when resetting.
 - **FIX**: regression.
 - **FIX**: bunch of fixes.
 - **FIX**: use24HourFormat.
 - **FIX**: move away from Decimal for performance issue.
 - **FIX**: minor improvement.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: minor improvements.
 - **FIX**(compound): frequency logic.
 - **FIX**: better user country handling.
 - **FIX**: minor issues.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: remove MatexSelectCurrencyField.
 - **FIX**: regression.
 - **FIX**: typo.
 - **FIX**: support very small values correctly.
 - **FIX**: minor improvements.
 - **FIX**: rename to RiskReward.
 - **FIX**: minor improvements.
 - **FIX**: dependency requirements.
 - **FIX**: wrong import.
 - **FIX**: missing export.
 - **FIX**: wrong dependency requirement.
 - **FIX**: bunch of fixes.
 - **FIX**: minor fixes.
 - **FEAT**: minor changes.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendPayoutRatioCalculatorBloc.
 - **FEAT**: add MatexDividendYieldCalculatorPdfGenerator.
 - **FEAT**: implement dividend yield calculator bloc.
 - **FEAT**: update dependencies.
 - **FEAT**: add dividend calculators.
 - **FEAT**: added MatexFinancialFrequency.
 - **FEAT**: allow to reset account size.
 - **FEAT**: minor improvements.
 - **FEAT**: add more results to profit and loss.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(MatexForexCompoundCalculatorPdfGenerator): add colors.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: add default risk percent settings.
 - **FEAT**: update MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: bunch of improvements.
 - **FEAT**: add stopLossPrice result to fx position calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: use default user values.
 - **FEAT**: add periods.
 - **FEAT**: update dependencies.
 - **FEAT**: add fastyle financial dependencies.
 - **FEAT**: refactor validators.
 - **FEAT**: implement forex compounding calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: update dependencies.
 - **FEAT**: implement ForexPositionSize Results.
 - **FEAT**: update dependencies.
 - **FEAT**: implement position calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculator results.
 - **FEAT**: missing MatexForexPositionSizeCalculatorBloc results.
 - **FEAT**: implement fx pos cal fields.
 - **FEAT**: clean up.
 - **FEAT**: add structure for forex position size calculator.
 - **FEAT**: support more default values.
 - **FEAT**: update dependencies.
 - **FEAT**: support lot sizes.
 - **FEAT**: update doc versions.
 - **FEAT**: compound calculator can export to CSV.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: clean up.
 - **FEAT**: update dependencies.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: add pdf generator for pip value.
 - **FEAT**: update dependencies.
 - **FEAT**: debounce compute events.
 - **FEAT**: implement pip value results.
 - **FEAT**: add MatexFinancialInstrumentExchangeService.
 - **FEAT**: support new metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: added MatexFinancialInstrumentCalculatorBlocFields interface.
 - **FEAT**: add quote model.
 - **FEAT**: minor improvements.
 - **FEAT**: add favorite instrument logic.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexPipValueCalculator.
 - **FEAT**: add logic for stop loss & take profit logic.
 - **FEAT**: add MatexInstrumentPairsBloc.
 - **FEAT**: initial structure for pip calculator.
 - **FEAT**: update dependencies.
 - **FEAT**(MatexProfitAndLossCalculatorPdfGenerator): add additional metrics category.
 - **FEAT**: update localization.
 - **FEAT**: update dependencies.
 - **FEAT**: add default tax rate to MatexProfitAndLossCalculatorBloc.
 - **FEAT**: add MatexProfitAndLossCalculatorPdfGenerator.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: add required margin logic.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexProfitAndLossCalculator.
 - **FEAT**: initial commit for MatexProfitAndLossCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**(PDF): support short position.
 - **FEAT**: add MatexVatCalculator.
 - **FEAT**: add support for short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: add logic for fx profit & loss.
 - **FEAT**: more tests.
 - **FEAT**: update dependencies.
 - **FEAT**: bunch of improvements.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add vat validators.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: stock position size supports short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: support takeProfitAmountAfterFee.
 - **FEAT**: minor improvements.
 - **FEAT**: toleratedRisk should be red when it's equal to effectiveRisk.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: support default values.
 - **FEAT**: implement fibonnaci levels pdf generator.
 - **FEAT**(pdf): add subtitle.
 - **FEAT**: update dependencies.
 - **FEAT**: localize PDF.
 - **FEAT**: add fibonacci levels.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: added pip delta calculator.
 - **FEAT**: minor improvements.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: localize text.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: set dividend document versions.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to clear the selection.
 - **FEAT**: update fastyle_financial dependency.
 - **FEAT**: rename MatexInstrumentBloc to MatexCurrencyBloc.
 - **FEAT**: add MatexDividendReinvestmentCalculatorPdfGenerator.
 - **FEAT**: add instruments ui.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: better pdf for stock position.
 - **FEAT**(StockPositionSizeCalculator): add missing results.
 - **FEAT**: more results.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: add risk and amount at risk support.
 - **FEAT**: implement MatexStockPositionSizeCalculatorBloc.
 - **FEAT**: add more results.
 - **FEAT**: use Decimal package for MatexStockPositionSizeCalculator.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: more tests.
 - **FEAT**: add missing properties.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendReinvestmentCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: rename discountPercentage.
 - **FEAT**: add missing features.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: forex pip delta version 1.


## 2024-01-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.36`](#matex_core---v0036)
 - [`matex_data` - `v0.0.28`](#matex_data---v0028)
 - [`matex_financial` - `v0.0.46`](#matex_financial---v0046)

---

#### `matex_core` - `v0.0.36`

 - **REFACTOR**: isMandatoryFieldValid.
 - **PERF**: minor improvement.
 - **FIX**: remove defaults min and max fraction digits.
 - **FIX**: use toSafeDouble.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: wrong initial validity.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: regression.
 - **FIX**: use right document for resetCalculatorBlocState.
 - **FIX**: make sure we keep the default metadata after reseting a calculator.
 - **FIX**: dependency requirements.
 - **FIX**: minor issue.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: update dependencies.
 - **FEAT**: support latest fastyle.
 - **FEAT**: support different export type.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add parseStringToInt.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: more tests.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to the value of a calculator asynchronously.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: override canSaveEntry.
 - **FEAT**: allow to override share user interactions.
 - **FEAT**: remove dead code.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: add matex core package.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: remove dead code.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: forex pip delta version 1.
 - **FEAT**: update dependencies.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add metadata to blocs.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(core): add default info button.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: minor improvements.
 - **FEAT**: add UserPreferences Bloc.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: support default values.

#### `matex_data` - `v0.0.28`

 - **FIX**: typo.
 - **FEAT**: update dependencies.
 - **FEAT**: update metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update currencies.
 - **FEAT**: update data.
 - **FEAT**: add jamaican dollar.
 - **FEAT**: update dependencies.
 - **FEAT**: update metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: initial commit for matex_data.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add findOneByCountryCode method.
 - **FEAT**: bunch of improvements.
 - **FEAT**: update country metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: minor perf improvements.
 - **FEAT**: add country data bloc.
 - **FEAT**: update country data.
 - **FEAT**: add id property to MatexCountryMetadata.
 - **FEAT**: add MatexCountryMetadata.
 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.46`

 - **REFACTOR**: property names.
 - **REFACTOR**: isMandatoryFieldValid.
 - **REFACTOR**: MatexFinancialInstrumentsBloc.
 - **FIX**: short positions.
 - **FIX**: typo.
 - **FIX**: use toSafeDouble.
 - **FIX**: minor improvements.
 - **FIX**: avoid to compute tax amount when profit is negative.
 - **FIX**: bunch of fixes.
 - **FIX**: typo.
 - **FIX**: bunch of fixes.
 - **FIX**: display lot size in pdfs.
 - **FIX**: bunch of fixes.
 - **FIX**: allow user default value to override default value from documents.
 - **FIX**: bunch of fixes.
 - **FIX**: Pivot Points Camarilla.
 - **FIX**: typos.
 - **FIX**: bunch of fixes.
 - **FIX**: SL/TP calculator.
 - **FIX**: wrong dependency version.
 - **FIX**: required margin.
 - **FIX**: allow negative pnl computations.
 - **FIX**: allow to reset some fields.
 - **FIX**: Pdf for Forex position Calculator.
 - **FIX**: minor improvements.
 - **FIX**: dispatch metadata in advance to avoid UI flickering.
 - **FIX**: override  getUserCurrencyCode.
 - **FIX**: reset entry price when stop loss type change.
 - **FIX**: attempts to fix tests.
 - **FIX**: typo.
 - **FIX**: deprecated use of describeEnum.
 - **FIX**: show the defaults results when resetting.
 - **FIX**: regression.
 - **FIX**: bunch of fixes.
 - **FIX**: use24HourFormat.
 - **FIX**: move away from Decimal for performance issue.
 - **FIX**: minor improvement.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: minor improvements.
 - **FIX**(compound): frequency logic.
 - **FIX**: better user country handling.
 - **FIX**: minor issues.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: remove MatexSelectCurrencyField.
 - **FIX**: regression.
 - **FIX**: typo.
 - **FIX**: support very small values correctly.
 - **FIX**: minor improvements.
 - **FIX**: rename to RiskReward.
 - **FIX**: minor improvements.
 - **FIX**: dependency requirements.
 - **FIX**: wrong import.
 - **FIX**: missing export.
 - **FIX**: wrong dependency requirement.
 - **FIX**: bunch of fixes.
 - **FIX**: minor fixes.
 - **FEAT**: minor changes.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendPayoutRatioCalculatorBloc.
 - **FEAT**: add MatexDividendYieldCalculatorPdfGenerator.
 - **FEAT**: implement dividend yield calculator bloc.
 - **FEAT**: update dependencies.
 - **FEAT**: add dividend calculators.
 - **FEAT**: added MatexFinancialFrequency.
 - **FEAT**: allow to reset account size.
 - **FEAT**: minor improvements.
 - **FEAT**: add more results to profit and loss.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(MatexForexCompoundCalculatorPdfGenerator): add colors.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: add default risk percent settings.
 - **FEAT**: update MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: bunch of improvements.
 - **FEAT**: add stopLossPrice result to fx position calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: use default user values.
 - **FEAT**: add periods.
 - **FEAT**: update dependencies.
 - **FEAT**: add fastyle financial dependencies.
 - **FEAT**: refactor validators.
 - **FEAT**: implement forex compounding calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: update dependencies.
 - **FEAT**: implement ForexPositionSize Results.
 - **FEAT**: update dependencies.
 - **FEAT**: implement position calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculator results.
 - **FEAT**: missing MatexForexPositionSizeCalculatorBloc results.
 - **FEAT**: implement fx pos cal fields.
 - **FEAT**: clean up.
 - **FEAT**: add structure for forex position size calculator.
 - **FEAT**: support more default values.
 - **FEAT**: update dependencies.
 - **FEAT**: support lot sizes.
 - **FEAT**: update doc versions.
 - **FEAT**: compound calculator can export to CSV.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: clean up.
 - **FEAT**: update dependencies.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: add pdf generator for pip value.
 - **FEAT**: update dependencies.
 - **FEAT**: debounce compute events.
 - **FEAT**: implement pip value results.
 - **FEAT**: add MatexFinancialInstrumentExchangeService.
 - **FEAT**: support new metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: added MatexFinancialInstrumentCalculatorBlocFields interface.
 - **FEAT**: add quote model.
 - **FEAT**: minor improvements.
 - **FEAT**: add favorite instrument logic.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexPipValueCalculator.
 - **FEAT**: add logic for stop loss & take profit logic.
 - **FEAT**: add MatexInstrumentPairsBloc.
 - **FEAT**: initial structure for pip calculator.
 - **FEAT**: update dependencies.
 - **FEAT**(MatexProfitAndLossCalculatorPdfGenerator): add additional metrics category.
 - **FEAT**: update localization.
 - **FEAT**: update dependencies.
 - **FEAT**: add default tax rate to MatexProfitAndLossCalculatorBloc.
 - **FEAT**: add MatexProfitAndLossCalculatorPdfGenerator.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: add required margin logic.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexProfitAndLossCalculator.
 - **FEAT**: initial commit for MatexProfitAndLossCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**(PDF): support short position.
 - **FEAT**: add MatexVatCalculator.
 - **FEAT**: add support for short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: add logic for fx profit & loss.
 - **FEAT**: more tests.
 - **FEAT**: update dependencies.
 - **FEAT**: bunch of improvements.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add vat validators.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: stock position size supports short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: support takeProfitAmountAfterFee.
 - **FEAT**: minor improvements.
 - **FEAT**: toleratedRisk should be red when it's equal to effectiveRisk.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: support default values.
 - **FEAT**: implement fibonnaci levels pdf generator.
 - **FEAT**(pdf): add subtitle.
 - **FEAT**: update dependencies.
 - **FEAT**: localize PDF.
 - **FEAT**: add fibonacci levels.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: added pip delta calculator.
 - **FEAT**: minor improvements.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: localize text.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: set dividend document versions.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to clear the selection.
 - **FEAT**: update fastyle_financial dependency.
 - **FEAT**: rename MatexInstrumentBloc to MatexCurrencyBloc.
 - **FEAT**: add MatexDividendReinvestmentCalculatorPdfGenerator.
 - **FEAT**: add instruments ui.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: better pdf for stock position.
 - **FEAT**(StockPositionSizeCalculator): add missing results.
 - **FEAT**: more results.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: add risk and amount at risk support.
 - **FEAT**: implement MatexStockPositionSizeCalculatorBloc.
 - **FEAT**: add more results.
 - **FEAT**: use Decimal package for MatexStockPositionSizeCalculator.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: more tests.
 - **FEAT**: add missing properties.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendReinvestmentCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: rename discountPercentage.
 - **FEAT**: add missing features.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: forex pip delta version 1.


## 2024-01-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.35`](#matex_core---v0035)
 - [`matex_data` - `v0.0.27`](#matex_data---v0027)
 - [`matex_financial` - `v0.0.45`](#matex_financial---v0045)

---

#### `matex_core` - `v0.0.35`

 - **REFACTOR**: isMandatoryFieldValid.
 - **PERF**: minor improvement.
 - **FIX**: remove defaults min and max fraction digits.
 - **FIX**: use toSafeDouble.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: wrong initial validity.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: regression.
 - **FIX**: use right document for resetCalculatorBlocState.
 - **FIX**: make sure we keep the default metadata after reseting a calculator.
 - **FIX**: dependency requirements.
 - **FIX**: minor issue.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: update dependencies.
 - **FEAT**: support latest fastyle.
 - **FEAT**: support different export type.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add parseStringToInt.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: more tests.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to the value of a calculator asynchronously.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: override canSaveEntry.
 - **FEAT**: allow to override share user interactions.
 - **FEAT**: remove dead code.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: add matex core package.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: remove dead code.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: forex pip delta version 1.
 - **FEAT**: update dependencies.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add metadata to blocs.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(core): add default info button.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: minor improvements.
 - **FEAT**: add UserPreferences Bloc.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: support default values.

#### `matex_data` - `v0.0.27`

 - **FIX**: typo.
 - **FEAT**: update dependencies.
 - **FEAT**: update metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update currencies.
 - **FEAT**: update data.
 - **FEAT**: add jamaican dollar.
 - **FEAT**: update dependencies.
 - **FEAT**: update metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: initial commit for matex_data.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add findOneByCountryCode method.
 - **FEAT**: bunch of improvements.
 - **FEAT**: update country metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: minor perf improvements.
 - **FEAT**: add country data bloc.
 - **FEAT**: update country data.
 - **FEAT**: add id property to MatexCountryMetadata.
 - **FEAT**: add MatexCountryMetadata.
 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.45`

 - **REFACTOR**: property names.
 - **REFACTOR**: isMandatoryFieldValid.
 - **REFACTOR**: MatexFinancialInstrumentsBloc.
 - **FIX**: short positions.
 - **FIX**: typo.
 - **FIX**: use toSafeDouble.
 - **FIX**: minor improvements.
 - **FIX**: avoid to compute tax amount when profit is negative.
 - **FIX**: bunch of fixes.
 - **FIX**: typo.
 - **FIX**: bunch of fixes.
 - **FIX**: display lot size in pdfs.
 - **FIX**: bunch of fixes.
 - **FIX**: allow user default value to override default value from documents.
 - **FIX**: bunch of fixes.
 - **FIX**: Pivot Points Camarilla.
 - **FIX**: typos.
 - **FIX**: bunch of fixes.
 - **FIX**: SL/TP calculator.
 - **FIX**: wrong dependency version.
 - **FIX**: required margin.
 - **FIX**: allow negative pnl computations.
 - **FIX**: allow to reset some fields.
 - **FIX**: Pdf for Forex position Calculator.
 - **FIX**: minor improvements.
 - **FIX**: dispatch metadata in advance to avoid UI flickering.
 - **FIX**: override  getUserCurrencyCode.
 - **FIX**: reset entry price when stop loss type change.
 - **FIX**: attempts to fix tests.
 - **FIX**: typo.
 - **FIX**: deprecated use of describeEnum.
 - **FIX**: show the defaults results when resetting.
 - **FIX**: regression.
 - **FIX**: bunch of fixes.
 - **FIX**: use24HourFormat.
 - **FIX**: move away from Decimal for performance issue.
 - **FIX**: minor improvement.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: minor improvements.
 - **FIX**(compound): frequency logic.
 - **FIX**: better user country handling.
 - **FIX**: minor issues.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: remove MatexSelectCurrencyField.
 - **FIX**: regression.
 - **FIX**: typo.
 - **FIX**: support very small values correctly.
 - **FIX**: minor improvements.
 - **FIX**: rename to RiskReward.
 - **FIX**: minor improvements.
 - **FIX**: dependency requirements.
 - **FIX**: wrong import.
 - **FIX**: missing export.
 - **FIX**: wrong dependency requirement.
 - **FIX**: bunch of fixes.
 - **FIX**: minor fixes.
 - **FEAT**: minor changes.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendPayoutRatioCalculatorBloc.
 - **FEAT**: add MatexDividendYieldCalculatorPdfGenerator.
 - **FEAT**: implement dividend yield calculator bloc.
 - **FEAT**: update dependencies.
 - **FEAT**: add dividend calculators.
 - **FEAT**: added MatexFinancialFrequency.
 - **FEAT**: allow to reset account size.
 - **FEAT**: minor improvements.
 - **FEAT**: add more results to profit and loss.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(MatexForexCompoundCalculatorPdfGenerator): add colors.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: add default risk percent settings.
 - **FEAT**: update MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: bunch of improvements.
 - **FEAT**: add stopLossPrice result to fx position calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: use default user values.
 - **FEAT**: add periods.
 - **FEAT**: update dependencies.
 - **FEAT**: add fastyle financial dependencies.
 - **FEAT**: refactor validators.
 - **FEAT**: implement forex compounding calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: update dependencies.
 - **FEAT**: implement ForexPositionSize Results.
 - **FEAT**: update dependencies.
 - **FEAT**: implement position calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculator results.
 - **FEAT**: missing MatexForexPositionSizeCalculatorBloc results.
 - **FEAT**: implement fx pos cal fields.
 - **FEAT**: clean up.
 - **FEAT**: add structure for forex position size calculator.
 - **FEAT**: support more default values.
 - **FEAT**: update dependencies.
 - **FEAT**: support lot sizes.
 - **FEAT**: update doc versions.
 - **FEAT**: compound calculator can export to CSV.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: clean up.
 - **FEAT**: update dependencies.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: add pdf generator for pip value.
 - **FEAT**: update dependencies.
 - **FEAT**: debounce compute events.
 - **FEAT**: implement pip value results.
 - **FEAT**: add MatexFinancialInstrumentExchangeService.
 - **FEAT**: support new metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: added MatexFinancialInstrumentCalculatorBlocFields interface.
 - **FEAT**: add quote model.
 - **FEAT**: minor improvements.
 - **FEAT**: add favorite instrument logic.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexPipValueCalculator.
 - **FEAT**: add logic for stop loss & take profit logic.
 - **FEAT**: add MatexInstrumentPairsBloc.
 - **FEAT**: initial structure for pip calculator.
 - **FEAT**: update dependencies.
 - **FEAT**(MatexProfitAndLossCalculatorPdfGenerator): add additional metrics category.
 - **FEAT**: update localization.
 - **FEAT**: update dependencies.
 - **FEAT**: add default tax rate to MatexProfitAndLossCalculatorBloc.
 - **FEAT**: add MatexProfitAndLossCalculatorPdfGenerator.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: add required margin logic.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexProfitAndLossCalculator.
 - **FEAT**: initial commit for MatexProfitAndLossCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**(PDF): support short position.
 - **FEAT**: add MatexVatCalculator.
 - **FEAT**: add support for short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: add logic for fx profit & loss.
 - **FEAT**: more tests.
 - **FEAT**: update dependencies.
 - **FEAT**: bunch of improvements.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add vat validators.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: stock position size supports short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: support takeProfitAmountAfterFee.
 - **FEAT**: minor improvements.
 - **FEAT**: toleratedRisk should be red when it's equal to effectiveRisk.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: support default values.
 - **FEAT**: implement fibonnaci levels pdf generator.
 - **FEAT**(pdf): add subtitle.
 - **FEAT**: update dependencies.
 - **FEAT**: localize PDF.
 - **FEAT**: add fibonacci levels.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: added pip delta calculator.
 - **FEAT**: minor improvements.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: localize text.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: set dividend document versions.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to clear the selection.
 - **FEAT**: update fastyle_financial dependency.
 - **FEAT**: rename MatexInstrumentBloc to MatexCurrencyBloc.
 - **FEAT**: add MatexDividendReinvestmentCalculatorPdfGenerator.
 - **FEAT**: add instruments ui.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: better pdf for stock position.
 - **FEAT**(StockPositionSizeCalculator): add missing results.
 - **FEAT**: more results.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: add risk and amount at risk support.
 - **FEAT**: implement MatexStockPositionSizeCalculatorBloc.
 - **FEAT**: add more results.
 - **FEAT**: use Decimal package for MatexStockPositionSizeCalculator.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: more tests.
 - **FEAT**: add missing properties.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendReinvestmentCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: rename discountPercentage.
 - **FEAT**: add missing features.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: forex pip delta version 1.


## 2024-01-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.34`](#matex_core---v0034)
 - [`matex_data` - `v0.0.26`](#matex_data---v0026)
 - [`matex_financial` - `v0.0.44`](#matex_financial---v0044)

---

#### `matex_core` - `v0.0.34`

 - **REFACTOR**: isMandatoryFieldValid.
 - **PERF**: minor improvement.
 - **FIX**: remove defaults min and max fraction digits.
 - **FIX**: use toSafeDouble.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: wrong initial validity.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: regression.
 - **FIX**: use right document for resetCalculatorBlocState.
 - **FIX**: make sure we keep the default metadata after reseting a calculator.
 - **FIX**: dependency requirements.
 - **FIX**: minor issue.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: update dependencies.
 - **FEAT**: support latest fastyle.
 - **FEAT**: support different export type.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add parseStringToInt.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: more tests.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to the value of a calculator asynchronously.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: override canSaveEntry.
 - **FEAT**: allow to override share user interactions.
 - **FEAT**: remove dead code.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: add matex core package.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: remove dead code.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: forex pip delta version 1.
 - **FEAT**: update dependencies.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add metadata to blocs.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(core): add default info button.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: minor improvements.
 - **FEAT**: add UserPreferences Bloc.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: support default values.

#### `matex_data` - `v0.0.26`

 - **FIX**: typo.
 - **FEAT**: update dependencies.
 - **FEAT**: update metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update currencies.
 - **FEAT**: update data.
 - **FEAT**: add jamaican dollar.
 - **FEAT**: update dependencies.
 - **FEAT**: update metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: initial commit for matex_data.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add findOneByCountryCode method.
 - **FEAT**: bunch of improvements.
 - **FEAT**: update country metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: minor perf improvements.
 - **FEAT**: add country data bloc.
 - **FEAT**: update country data.
 - **FEAT**: add id property to MatexCountryMetadata.
 - **FEAT**: add MatexCountryMetadata.
 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.44`

 - **REFACTOR**: property names.
 - **REFACTOR**: isMandatoryFieldValid.
 - **REFACTOR**: MatexFinancialInstrumentsBloc.
 - **FIX**: short positions.
 - **FIX**: typo.
 - **FIX**: use toSafeDouble.
 - **FIX**: minor improvements.
 - **FIX**: avoid to compute tax amount when profit is negative.
 - **FIX**: bunch of fixes.
 - **FIX**: typo.
 - **FIX**: bunch of fixes.
 - **FIX**: display lot size in pdfs.
 - **FIX**: bunch of fixes.
 - **FIX**: allow user default value to override default value from documents.
 - **FIX**: bunch of fixes.
 - **FIX**: Pivot Points Camarilla.
 - **FIX**: typos.
 - **FIX**: bunch of fixes.
 - **FIX**: SL/TP calculator.
 - **FIX**: wrong dependency version.
 - **FIX**: required margin.
 - **FIX**: allow negative pnl computations.
 - **FIX**: allow to reset some fields.
 - **FIX**: Pdf for Forex position Calculator.
 - **FIX**: minor improvements.
 - **FIX**: dispatch metadata in advance to avoid UI flickering.
 - **FIX**: override  getUserCurrencyCode.
 - **FIX**: reset entry price when stop loss type change.
 - **FIX**: attempts to fix tests.
 - **FIX**: typo.
 - **FIX**: deprecated use of describeEnum.
 - **FIX**: show the defaults results when resetting.
 - **FIX**: regression.
 - **FIX**: bunch of fixes.
 - **FIX**: use24HourFormat.
 - **FIX**: move away from Decimal for performance issue.
 - **FIX**: minor improvement.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: minor improvements.
 - **FIX**(compound): frequency logic.
 - **FIX**: better user country handling.
 - **FIX**: minor issues.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: remove MatexSelectCurrencyField.
 - **FIX**: regression.
 - **FIX**: typo.
 - **FIX**: support very small values correctly.
 - **FIX**: minor improvements.
 - **FIX**: rename to RiskReward.
 - **FIX**: minor improvements.
 - **FIX**: dependency requirements.
 - **FIX**: wrong import.
 - **FIX**: missing export.
 - **FIX**: wrong dependency requirement.
 - **FIX**: bunch of fixes.
 - **FIX**: minor fixes.
 - **FEAT**: minor changes.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendPayoutRatioCalculatorBloc.
 - **FEAT**: add MatexDividendYieldCalculatorPdfGenerator.
 - **FEAT**: implement dividend yield calculator bloc.
 - **FEAT**: update dependencies.
 - **FEAT**: add dividend calculators.
 - **FEAT**: added MatexFinancialFrequency.
 - **FEAT**: allow to reset account size.
 - **FEAT**: minor improvements.
 - **FEAT**: add more results to profit and loss.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(MatexForexCompoundCalculatorPdfGenerator): add colors.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: add default risk percent settings.
 - **FEAT**: update MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: bunch of improvements.
 - **FEAT**: add stopLossPrice result to fx position calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: use default user values.
 - **FEAT**: add periods.
 - **FEAT**: update dependencies.
 - **FEAT**: add fastyle financial dependencies.
 - **FEAT**: refactor validators.
 - **FEAT**: implement forex compounding calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: update dependencies.
 - **FEAT**: implement ForexPositionSize Results.
 - **FEAT**: update dependencies.
 - **FEAT**: implement position calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculator results.
 - **FEAT**: missing MatexForexPositionSizeCalculatorBloc results.
 - **FEAT**: implement fx pos cal fields.
 - **FEAT**: clean up.
 - **FEAT**: add structure for forex position size calculator.
 - **FEAT**: support more default values.
 - **FEAT**: update dependencies.
 - **FEAT**: support lot sizes.
 - **FEAT**: update doc versions.
 - **FEAT**: compound calculator can export to CSV.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: clean up.
 - **FEAT**: update dependencies.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: add pdf generator for pip value.
 - **FEAT**: update dependencies.
 - **FEAT**: debounce compute events.
 - **FEAT**: implement pip value results.
 - **FEAT**: add MatexFinancialInstrumentExchangeService.
 - **FEAT**: support new metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: added MatexFinancialInstrumentCalculatorBlocFields interface.
 - **FEAT**: add quote model.
 - **FEAT**: minor improvements.
 - **FEAT**: add favorite instrument logic.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexPipValueCalculator.
 - **FEAT**: add logic for stop loss & take profit logic.
 - **FEAT**: add MatexInstrumentPairsBloc.
 - **FEAT**: initial structure for pip calculator.
 - **FEAT**: update dependencies.
 - **FEAT**(MatexProfitAndLossCalculatorPdfGenerator): add additional metrics category.
 - **FEAT**: update localization.
 - **FEAT**: update dependencies.
 - **FEAT**: add default tax rate to MatexProfitAndLossCalculatorBloc.
 - **FEAT**: add MatexProfitAndLossCalculatorPdfGenerator.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: add required margin logic.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexProfitAndLossCalculator.
 - **FEAT**: initial commit for MatexProfitAndLossCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**(PDF): support short position.
 - **FEAT**: add MatexVatCalculator.
 - **FEAT**: add support for short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: add logic for fx profit & loss.
 - **FEAT**: more tests.
 - **FEAT**: update dependencies.
 - **FEAT**: bunch of improvements.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add vat validators.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: stock position size supports short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: support takeProfitAmountAfterFee.
 - **FEAT**: minor improvements.
 - **FEAT**: toleratedRisk should be red when it's equal to effectiveRisk.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: support default values.
 - **FEAT**: implement fibonnaci levels pdf generator.
 - **FEAT**(pdf): add subtitle.
 - **FEAT**: update dependencies.
 - **FEAT**: localize PDF.
 - **FEAT**: add fibonacci levels.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: added pip delta calculator.
 - **FEAT**: minor improvements.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: localize text.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: set dividend document versions.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to clear the selection.
 - **FEAT**: update fastyle_financial dependency.
 - **FEAT**: rename MatexInstrumentBloc to MatexCurrencyBloc.
 - **FEAT**: add MatexDividendReinvestmentCalculatorPdfGenerator.
 - **FEAT**: add instruments ui.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: better pdf for stock position.
 - **FEAT**(StockPositionSizeCalculator): add missing results.
 - **FEAT**: more results.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: add risk and amount at risk support.
 - **FEAT**: implement MatexStockPositionSizeCalculatorBloc.
 - **FEAT**: add more results.
 - **FEAT**: use Decimal package for MatexStockPositionSizeCalculator.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: more tests.
 - **FEAT**: add missing properties.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendReinvestmentCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: rename discountPercentage.
 - **FEAT**: add missing features.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: forex pip delta version 1.


## 2024-01-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.33`](#matex_core---v0033)
 - [`matex_data` - `v0.0.25`](#matex_data---v0025)
 - [`matex_financial` - `v0.0.43`](#matex_financial---v0043)

---

#### `matex_core` - `v0.0.33`

 - **REFACTOR**: isMandatoryFieldValid.
 - **PERF**: minor improvement.
 - **FIX**: remove defaults min and max fraction digits.
 - **FIX**: use toSafeDouble.
 - **FIX**: bunch of fixes.
 - **FIX**: use right document for resetCalculatorBlocState.
 - **FIX**: bunch of fixes.
 - **FIX**: wrong initial validity.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: regression.
 - **FIX**: make sure we keep the default metadata after reseting a calculator.
 - **FIX**: dependency requirements.
 - **FIX**: minor issue.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: update dependencies.
 - **FEAT**: support latest fastyle.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to the value of a calculator asynchronously.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: add parseStringToInt.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: more tests.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: override canSaveEntry.
 - **FEAT**: allow to override share user interactions.
 - **FEAT**: remove dead code.
 - **FEAT**: update dependencies.
 - **FEAT**: support default values.
 - **FEAT**: add matex core package.
 - **FEAT**: update dependencies.
 - **FEAT**: forex pip delta version 1.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: remove dead code.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: add pivot points logic.
 - **FEAT**: update dependencies.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add metadata to blocs.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**(core): add default info button.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: minor improvements.
 - **FEAT**: add UserPreferences Bloc.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.25`

 - **FIX**: typo.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update currencies.
 - **FEAT**: add jamaican dollar.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add findOneByCountryCode method.
 - **FEAT**: bunch of improvements.
 - **FEAT**: update country metadata.
 - **FEAT**: update dependencies.
 - **FEAT**: minor perf improvements.
 - **FEAT**: add country data bloc.
 - **FEAT**: update country data.
 - **FEAT**: add id property to MatexCountryMetadata.
 - **FEAT**: add MatexCountryMetadata.
 - **FEAT**: initial commit for matex_data.

#### `matex_financial` - `v0.0.43`

 - **REFACTOR**: property names.
 - **REFACTOR**: isMandatoryFieldValid.
 - **REFACTOR**: MatexFinancialInstrumentsBloc.
 - **FIX**: allow negative pnl computations.
 - **FIX**: minor improvements.
 - **FIX**: avoid to compute tax amount when profit is negative.
 - **FIX**: bunch of fixes.
 - **FIX**: typo.
 - **FIX**: bunch of fixes.
 - **FIX**: display lot size in pdfs.
 - **FIX**: bunch of fixes.
 - **FIX**: allow user default value to override default value from documents.
 - **FIX**: bunch of fixes.
 - **FIX**: Pivot Points Camarilla.
 - **FIX**: typos.
 - **FIX**: bunch of fixes.
 - **FIX**: SL/TP calculator.
 - **FIX**: required margin.
 - **FIX**: wrong dependency version.
 - **FIX**: allow to reset some fields.
 - **FIX**: Pdf for Forex position Calculator.
 - **FIX**: move away from Decimal for performance issue.
 - **FIX**: minor improvements.
 - **FIX**: dispatch metadata in advance to avoid UI flickering.
 - **FIX**: override  getUserCurrencyCode.
 - **FIX**: reset entry price when stop loss type change.
 - **FIX**: attempts to fix tests.
 - **FIX**: typo.
 - **FIX**: deprecated use of describeEnum.
 - **FIX**: show the defaults results when resetting.
 - **FIX**(compound): frequency logic.
 - **FIX**: bunch of fixes.
 - **FIX**: use24HourFormat.
 - **FIX**: typo.
 - **FIX**: minor improvement.
 - **FIX**: minor fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: minor improvements.
 - **FIX**: use toSafeDouble.
 - **FIX**: short positions.
 - **FIX**: better user country handling.
 - **FIX**: minor issues.
 - **FIX**: remove fastyle_ad dependency.
 - **FIX**: remove MatexSelectCurrencyField.
 - **FIX**: regression.
 - **FIX**: typo.
 - **FIX**: support very small values correctly.
 - **FIX**: minor improvements.
 - **FIX**: rename to RiskReward.
 - **FIX**: minor improvements.
 - **FIX**: dependency requirements.
 - **FIX**: wrong import.
 - **FIX**: missing export.
 - **FIX**: wrong dependency requirement.
 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FEAT**: update MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: implement dividend yield calculator bloc.
 - **FEAT**: update dependencies.
 - **FEAT**: add dividend calculators.
 - **FEAT**: added MatexFinancialFrequency.
 - **FEAT**: allow to reset account size.
 - **FEAT**: minor improvements.
 - **FEAT**: add more results to profit and loss.
 - **FEAT**: use default user values.
 - **FEAT**: update dependencies.
 - **FEAT**: minor changes.
 - **FEAT**: bunch of improvements.
 - **FEAT**: add default risk percent settings.
 - **FEAT**: add periods.
 - **FEAT**: implement forex compounding calculator.
 - **FEAT**: add stopLossPrice result to fx position calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: add  tenhance dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: add fastyle financial dependencies.
 - **FEAT**: refactor validators.
 - **FEAT**: support more default values.
 - **FEAT**: implement MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: update doc versions.
 - **FEAT**: implement ForexPositionSize Results.
 - **FEAT**: update dependencies.
 - **FEAT**: implement position calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculator results.
 - **FEAT**: missing MatexForexPositionSizeCalculatorBloc results.
 - **FEAT**: implement fx pos cal fields.
 - **FEAT**: clean up.
 - **FEAT**: add structure for forex position size calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: support lot sizes.
 - **FEAT**: update dependencies.
 - **FEAT**: handle exchange rate errors.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: forex pip delta version 1.
 - **FEAT**: clean up.
 - **FEAT**: update dependencies.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: add pdf generator for pip value.
 - **FEAT**: update dependencies.
 - **FEAT**: debounce compute events.
 - **FEAT**: implement pip value results.
 - **FEAT**: add MatexFinancialInstrumentExchangeService.
 - **FEAT**: add logic for stop loss & take profit logic.
 - **FEAT**: update dependencies.
 - **FEAT**: added MatexFinancialInstrumentCalculatorBlocFields interface.
 - **FEAT**: add quote model.
 - **FEAT**: minor improvements.
 - **FEAT**: add favorite instrument logic.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: implement MatexPipValueCalculator.
 - **FEAT**: minor improvements.
 - **FEAT**: add MatexInstrumentPairsBloc.
 - **FEAT**: initial structure for pip calculator.
 - **FEAT**: add required margin logic.
 - **FEAT**(MatexProfitAndLossCalculatorPdfGenerator): add additional metrics category.
 - **FEAT**: update localization.
 - **FEAT**: update dependencies.
 - **FEAT**: add default tax rate to MatexProfitAndLossCalculatorBloc.
 - **FEAT**: add MatexProfitAndLossCalculatorPdfGenerator.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: add logic for fx profit & loss.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: implement MatexProfitAndLossCalculator.
 - **FEAT**: initial commit for MatexProfitAndLossCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**(PDF): support short position.
 - **FEAT**: minor improvements.
 - **FEAT**: add MatexVatCalculator.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: more tests.
 - **FEAT**: add pivot points logic.
 - **FEAT**: bunch of improvements.
 - **FEAT**: support latest fastyle_settings.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: implement fibonnaci levels pdf generator.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add vat validators.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: stock position size supports short positions.
 - **FEAT**: update dependencies.
 - **FEAT**: support takeProfitAmountAfterFee.
 - **FEAT**: minor improvements.
 - **FEAT**: toleratedRisk should be red when it's equal to effectiveRisk.
 - **FEAT**: add fibonacci levels.
 - **FEAT**: added pip delta calculator.
 - **FEAT**: support default values.
 - **FEAT**: minor improvements.
 - **FEAT**(pdf): add subtitle.
 - **FEAT**: update dependencies.
 - **FEAT**: localize PDF.
 - **FEAT**: localize text.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: set dividend document versions.
 - **FEAT**: add MatexDividendReinvestmentCalculatorPdfGenerator.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.
 - **FEAT**: more results.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: added MatexDividendReinvestmentCalculatorBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: allow to clear the selection.
 - **FEAT**: update fastyle_financial dependency.
 - **FEAT**: rename MatexInstrumentBloc to MatexCurrencyBloc.
 - **FEAT**: update dependencies.
 - **FEAT**: add instruments ui.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: better pdf for stock position.
 - **FEAT**(StockPositionSizeCalculator): add missing results.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: add risk and amount at risk support.
 - **FEAT**: implement MatexStockPositionSizeCalculatorBloc.
 - **FEAT**: add more results.
 - **FEAT**: use Decimal package for MatexStockPositionSizeCalculator.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: more tests.
 - **FEAT**: add missing properties.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendPayoutRatioCalculatorBloc.
 - **FEAT**: rename discountPercentage.
 - **FEAT**: add missing features.
 - **FEAT**: support dart 3 & flutter 3.10.0.
 - **FEAT**: add MatexDividendYieldCalculatorPdfGenerator.
 - **FEAT**: add support for short positions.


## 2024-01-12

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.32`](#matex_core---v0032)
 - [`matex_financial` - `v0.0.42+2`](#matex_financial---v00422)

---

#### `matex_core` - `v0.0.32`

 - **FEAT**: allow to the value of a calculator asynchronously.

#### `matex_financial` - `v0.0.42+2`

 - **FIX**: move away from Decimal for performance issue.
 - **FIX**(compound): frequency logic.


## 2024-01-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.42+1`](#matex_financial---v00421)

---

#### `matex_financial` - `v0.0.42+1`

 - **FIX**: typo.


## 2024-01-06

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.42`](#matex_financial---v0042)

---

#### `matex_financial` - `v0.0.42`

 - **FEAT**: minor improvements.


## 2024-01-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.31`](#matex_core---v0031)
 - [`matex_data` - `v0.0.24`](#matex_data---v0024)
 - [`matex_financial` - `v0.0.41`](#matex_financial---v0041)

---

#### `matex_core` - `v0.0.31`

 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.24`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.41`

 - **FEAT**: update dependencies.


## 2024-01-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.30`](#matex_core---v0030)
 - [`matex_data` - `v0.0.23`](#matex_data---v0023)
 - [`matex_financial` - `v0.0.40`](#matex_financial---v0040)

---

#### `matex_core` - `v0.0.30`

 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.23`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.40`

 - **FEAT**: update dependencies.


## 2024-01-05

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.29`](#matex_core---v0029)
 - [`matex_financial` - `v0.0.39`](#matex_financial---v0039)

---

#### `matex_core` - `v0.0.29`

 - **FEAT**: handle exchange rate errors.
 - **FEAT**: support latest fastyle.

#### `matex_financial` - `v0.0.39`

 - **FEAT**: handle exchange rate errors.
 - **FEAT**: update dependencies.
 - **FEAT**: use default user values.
 - **FEAT**: add periods.
 - **FEAT**: implement forex compounding calculator.


## 2023-12-31

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.28`](#matex_core---v0028)
 - [`matex_data` - `v0.0.22`](#matex_data---v0022)
 - [`matex_financial` - `v0.0.38`](#matex_financial---v0038)

---

#### `matex_core` - `v0.0.28`

 - **FIX**: use toSafeDouble.
 - **FEAT**: update dependencies.
 - **FEAT**: add  tenhance dependencies.

#### `matex_data` - `v0.0.22`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.38`

 - **FIX**: use toSafeDouble.
 - **FEAT**: update dependencies.
 - **FEAT**: add  tenhance dependencies.


## 2023-12-29

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.37+3`](#matex_financial---v00373)

---

#### `matex_financial` - `v0.0.37+3`

 - **FIX**: minor improvements.


## 2023-12-27

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.37+2`](#matex_financial---v00372)

---

#### `matex_financial` - `v0.0.37+2`

 - **FIX**: avoid to compute tax amount when profit is negative.


## 2023-12-27

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.37+1`](#matex_financial---v00371)

---

#### `matex_financial` - `v0.0.37+1`

 - **FIX**: bunch of fixes.


## 2023-12-20

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.27`](#matex_core---v0027)
 - [`matex_data` - `v0.0.21`](#matex_data---v0021)
 - [`matex_financial` - `v0.0.37`](#matex_financial---v0037)

---

#### `matex_core` - `v0.0.27`

 - **FIX**: bunch of fixes.
 - **FEAT**: update dependencies.
 - **FEAT**: forex pip delta version 1.
 - **FEAT**: add pivot points logic.

#### `matex_data` - `v0.0.21`

 - **FIX**: typo.
 - **FEAT**: update dependencies.
 - **FEAT**: update currencies.
 - **FEAT**: add jamaican dollar.

#### `matex_financial` - `v0.0.37`

 - **FIX**: typo.
 - **FIX**: bunch of fixes.
 - **FIX**: display lot size in pdfs.
 - **FIX**: bunch of fixes.
 - **FIX**: allow user default value to override default value from documents.
 - **FIX**: bunch of fixes.
 - **FIX**: Pivot Points Camarilla.
 - **FIX**: typos.
 - **FIX**: bunch of fixes.
 - **FIX**: SL/TP calculator.
 - **FIX**: required margin.
 - **FIX**: allow negative pnl computations.
 - **FEAT**: update dependencies.
 - **FEAT**: bunch of improvements.
 - **FEAT**: support more default values.
 - **FEAT**: update doc versions.
 - **FEAT**: forex pip delta version 1.
 - **FEAT**: add logic for stop loss & take profit logic.
 - **FEAT**: minor improvements.
 - **FEAT**: add required margin logic.
 - **FEAT**: minor improvements.
 - **FEAT**: add logic for fx profit & loss.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: add pivot points logic.


## 2023-12-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.26`](#matex_core---v0026)
 - [`matex_data` - `v0.0.20`](#matex_data---v0020)
 - [`matex_financial` - `v0.0.36`](#matex_financial---v0036)

---

#### `matex_core` - `v0.0.26`

 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.20`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.36`

 - **FEAT**: update dependencies.
 - **FEAT**: implement fibonnaci levels pdf generator.
 - **FEAT**: add fibonacci levels.
 - **FEAT**: added pip delta calculator.


## 2023-12-01

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.35`](#matex_financial---v0035)

---

#### `matex_financial` - `v0.0.35`

 - **FEAT**: minor improvements.


## 2023-12-01

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.34`](#matex_financial---v0034)

---

#### `matex_financial` - `v0.0.34`

 - **FEAT**: localize text.
 - **FEAT**: set dividend document versions.
 - **FEAT**: add MatexDividendReinvestmentCalculatorPdfGenerator.
 - **FEAT**: more results.
 - **FEAT**: added MatexDividendReinvestmentCalculatorBloc.


## 2023-11-29

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.25`](#matex_core---v0025)
 - [`matex_data` - `v0.0.19`](#matex_data---v0019)
 - [`matex_financial` - `v0.0.33`](#matex_financial---v0033)

---

#### `matex_core` - `v0.0.25`

 - **FEAT**: update dependencies.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.19`

 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.33`

 - **FEAT**: update dependencies.
 - **FEAT**: allow to change the filename of a PDF report.
 - **FEAT**: minor improvements.
 - **FEAT**: added MatexDividendPayoutRatioCalculatorBloc.
 - **FEAT**: add MatexDividendYieldCalculatorPdfGenerator.
 - **FEAT**: implement dividend yield calculator bloc.
 - **FEAT**: update dependencies.
 - **FEAT**: add dividend calculators.


## 2023-11-27

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.32`](#matex_financial---v0032)

---

#### `matex_financial` - `v0.0.32`

 - **FEAT**: added MatexFinancialFrequency.


## 2023-11-23

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.31`](#matex_financial---v0031)

---

#### `matex_financial` - `v0.0.31`

 - **FIX**: allow to reset some fields.
 - **FEAT**: allow to reset account size.
 - **FEAT**: minor improvements.
 - **FEAT**: add more results to profit and loss.
 - **FEAT**: update dependencies.
 - **FEAT**: minor changes.


## 2023-11-22

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.30+1`](#matex_financial---v00301)

---

#### `matex_financial` - `v0.0.30+1`

 - **FIX**: Pdf for Forex position Calculator.


## 2023-11-22

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.24`](#matex_core---v0024)
 - [`matex_data` - `v0.0.18`](#matex_data---v0018)
 - [`matex_financial` - `v0.0.30`](#matex_financial---v0030)

---

#### `matex_core` - `v0.0.24`

 - **PERF**: minor improvement.
 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.18`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.30`

 - **FIX**: minor improvements.
 - **FIX**: dispatch metadata in advance to avoid UI flickering.
 - **FIX**: override  getUserCurrencyCode.
 - **FIX**: reset entry price when stop loss type change.
 - **FEAT**: add default risk percent settings.
 - **FEAT**: update MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: add stopLossPrice result to fx position calculator.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.


## 2023-11-20

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.23`](#matex_core---v0023)
 - [`matex_data` - `v0.0.17`](#matex_data---v0017)
 - [`matex_financial` - `v0.0.29`](#matex_financial---v0029)

---

#### `matex_core` - `v0.0.23`

 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.17`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.29`

 - **FIX**: attempts to fix tests.
 - **FIX**: typo.
 - **FEAT**: add fastyle financial dependencies.
 - **FEAT**: refactor validators.
 - **FEAT**: implement MatexForexPositionSizeCalculatorPdfGenerator.
 - **FEAT**: implement ForexPositionSize Results.
 - **FEAT**: update dependencies.
 - **FEAT**: implement position calculator.
 - **FEAT**: implement MatexForexPositionSizeCalculator results.
 - **FEAT**: missing MatexForexPositionSizeCalculatorBloc results.
 - **FEAT**: implement fx pos cal fields.
 - **FEAT**: clean up.
 - **FEAT**: add structure for forex position size calculator.


## 2023-11-16

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.22`](#matex_core---v0022)
 - [`matex_data` - `v0.0.16`](#matex_data---v0016)
 - [`matex_financial` - `v0.0.28`](#matex_financial---v0028)

---

#### `matex_core` - `v0.0.22`

 - **REFACTOR**: isMandatoryFieldValid.
 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.16`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.28`

 - **REFACTOR**: isMandatoryFieldValid.
 - **FIX**: deprecated use of describeEnum.
 - **FIX**: show the defaults results when resetting.
 - **FEAT**: update dependencies.
 - **FEAT**: support lot sizes.


## 2023-11-14

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.21`](#matex_core---v0021)
 - [`matex_data` - `v0.0.15`](#matex_data---v0015)
 - [`matex_financial` - `v0.0.27`](#matex_financial---v0027)

---

#### `matex_core` - `v0.0.21`

 - **FIX**: bunch of fixes.
 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.15`

 - **FEAT**: move away from matex_dart.

#### `matex_financial` - `v0.0.27`

 - **FIX**: bunch of fixes.
 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: move away from matex_dart.
 - **FEAT**: clean up.


## 2023-11-14

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.20`](#matex_core---v0020)
 - [`matex_data` - `v0.0.14`](#matex_data---v0014)
 - [`matex_financial` - `v0.0.26`](#matex_financial---v0026)

---

#### `matex_core` - `v0.0.20`

 - **FIX**: wrong initial validity.
 - **FEAT**: update dependencies.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: add parseStringToInt.

#### `matex_data` - `v0.0.14`

 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.
 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.26`

 - **REFACTOR**: MatexFinancialInstrumentsBloc.
 - **FIX**: use24HourFormat.
 - **FIX**: minor improvement.
 - **FIX**: minor fixes.
 - **FEAT**: update dependencies.
 - **FEAT**: add default financial instrument to pip value calculator.
 - **FEAT**: add pdf generator for pip value.
 - **FEAT**: update dependencies.
 - **FEAT**: debounce compute events.
 - **FEAT**: implement pip value results.
 - **FEAT**: add MatexFinancialInstrumentExchangeService.
 - **FEAT**: update dependencies.
 - **FEAT**: added MatexFinancialInstrumentCalculatorBlocFields interface.
 - **FEAT**: add quote model.
 - **FEAT**: minor improvements.
 - **FEAT**: add favorite instrument logic.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexPipValueCalculator.
 - **FEAT**: add MatexInstrumentPairsBloc.
 - **FEAT**: initial structure for pip calculator.


## 2023-10-27

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.19`](#matex_core---v0019)
 - [`matex_data` - `v0.0.13`](#matex_data---v0013)
 - [`matex_financial` - `v0.0.25`](#matex_financial---v0025)

---

#### `matex_core` - `v0.0.19`

 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.13`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.25`

 - **FEAT**(MatexProfitAndLossCalculatorPdfGenerator): add additional metrics category.
 - **FEAT**: update localization.
 - **FEAT**: update dependencies.


## 2023-10-26

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.18`](#matex_core---v0018)
 - [`matex_data` - `v0.0.12`](#matex_data---v0012)
 - [`matex_financial` - `v0.0.24`](#matex_financial---v0024)

---

#### `matex_core` - `v0.0.18`

 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.

#### `matex_data` - `v0.0.12`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.24`

 - **REFACTOR**: property names.
 - **FIX**: bunch of fixes.
 - **FIX**: minor improvements.
 - **FEAT**: add default tax rate to MatexProfitAndLossCalculatorBloc.
 - **FEAT**: add MatexProfitAndLossCalculatorPdfGenerator.
 - **FEAT**: update dependencies.
 - **FEAT**: add PDF generators.
 - **FEAT**: minor improvements.
 - **FEAT**: implement MatexProfitAndLossCalculator.
 - **FEAT**: initial commit for MatexProfitAndLossCalculatorBloc.
 - **FEAT**: minor improvements.


## 2023-10-17

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.17`](#matex_core---v0017)
 - [`matex_data` - `v0.0.11`](#matex_data---v0011)
 - [`matex_financial` - `v0.0.23`](#matex_financial---v0023)

---

#### `matex_core` - `v0.0.17`

 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.11`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.23`

 - **FEAT**: update dependencies.


## 2023-10-03

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.16`](#matex_core---v0016)
 - [`matex_data` - `v0.0.10`](#matex_data---v0010)
 - [`matex_financial` - `v0.0.22`](#matex_financial---v0022)

---

#### `matex_core` - `v0.0.16`

 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.10`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.22`

 - **FIX**: short positions.
 - **FIX**: better user country handling.
 - **FEAT**(PDF): support short position.
 - **FEAT**: add support for short positions.
 - **FEAT**: update dependencies.


## 2023-10-01

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.15`](#matex_core---v0015)
 - [`matex_data` - `v0.0.9`](#matex_data---v009)
 - [`matex_financial` - `v0.0.21`](#matex_financial---v0021)

---

#### `matex_core` - `v0.0.15`

 - **FEAT**: more tests.

#### `matex_data` - `v0.0.9`

 - **FEAT**: add findOneByCountryCode method.

#### `matex_financial` - `v0.0.21`

 - **FIX**: minor issues.
 - **FEAT**: more tests.


## 2023-09-20

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_data` - `v0.0.8`](#matex_data---v008)
 - [`matex_financial` - `v0.0.20`](#matex_financial---v0020)

---

#### `matex_data` - `v0.0.8`

 - **FEAT**: bunch of improvements.

#### `matex_financial` - `v0.0.20`

 - **FEAT**: bunch of improvements.


## 2023-09-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.14`](#matex_core---v0014)
 - [`matex_financial` - `v0.0.19`](#matex_financial---v0019)

---

#### `matex_core` - `v0.0.14`

 - **FEAT**: support latest fastyle_settings.

#### `matex_financial` - `v0.0.19`

 - **FEAT**: support latest fastyle_settings.


## 2023-09-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_data` - `v0.0.7`](#matex_data---v007)

---

#### `matex_data` - `v0.0.7`

 - **FEAT**: update country metadata.


## 2023-09-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.13`](#matex_core---v0013)
 - [`matex_data` - `v0.0.6`](#matex_data---v006)
 - [`matex_financial` - `v0.0.18`](#matex_financial---v0018)

---

#### `matex_core` - `v0.0.13`

 - **FEAT**: update dependencies.

#### `matex_data` - `v0.0.6`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.18`

 - **FEAT**: update dependencies.


## 2023-09-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.12+1`](#matex_core---v00121)
 - [`matex_financial` - `v0.0.17+2`](#matex_financial---v00172)

---

#### `matex_core` - `v0.0.12+1`

 - **FIX**: remove fastyle_ad dependency.

#### `matex_financial` - `v0.0.17+2`

 - **FIX**: remove fastyle_ad dependency.


## 2023-09-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_data` - `v0.0.5`](#matex_data---v005)

---

#### `matex_data` - `v0.0.5`

 - **FEAT**: minor perf improvements.


## 2023-09-18

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_data` - `v0.0.4`](#matex_data---v004)

---

#### `matex_data` - `v0.0.4`

 - **FEAT**: add country data bloc.
 - **FEAT**: update country data.


## 2023-09-17

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_data` - `v0.0.3`](#matex_data---v003)

---

#### `matex_data` - `v0.0.3`

 - **FEAT**: add id property to MatexCountryMetadata.


## 2023-09-16

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_data` - `v0.0.2`](#matex_data---v002)

---

#### `matex_data` - `v0.0.2`

 - **FEAT**: add MatexCountryMetadata.
 - **FEAT**: initial commit for matex_data.


## 2023-09-16

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.17+1`](#matex_financial---v00171)

---

#### `matex_financial` - `v0.0.17+1`

 - **FIX**: remove MatexSelectCurrencyField.


## 2023-09-06

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.12`](#matex_core---v0012)
 - [`matex_financial` - `v0.0.17`](#matex_financial---v0017)

---

#### `matex_core` - `v0.0.12`

 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.

#### `matex_financial` - `v0.0.17`

 - **FEAT**: minor improvements.
 - **FEAT**: update dependencies.
 - **FEAT**: add vat validators.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: implement toPdf for MatexVatCalculatorBloc.
 - **FEAT**: minor improvements.
 - **FEAT**: minor improvements.
 - **FEAT**: stock position size supports short positions.


## 2023-08-22

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.11`](#matex_core---v0011)
 - [`matex_financial` - `v0.0.16`](#matex_financial---v0016)

---

#### `matex_core` - `v0.0.11`

 - **FIX**: regression.
 - **FIX**: use right document for resetCalculatorBlocState.
 - **FEAT**: update dependencies.
 - **FEAT**: override canSaveEntry.
 - **FEAT**: allow to override share user interactions.
 - **FEAT**: remove dead code.
 - **FEAT**: support default values.

#### `matex_financial` - `v0.0.16`

 - **FIX**: regression.
 - **FIX**: typo.
 - **FIX**: support very small values correctly.
 - **FEAT**: update dependencies.
 - **FEAT**: support takeProfitAmountAfterFee.
 - **FEAT**: minor improvements.
 - **FEAT**: toleratedRisk should be red when it's equal to effectiveRisk.
 - **FEAT**: support default values.


## 2023-08-17

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.10`](#matex_core---v0010)
 - [`matex_financial` - `v0.0.15`](#matex_financial---v0015)

---

#### `matex_core` - `v0.0.10`

 - **FIX**: make sure we keep the default metadata after reseting a calculator.
 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.15`

 - **FEAT**(pdf): add subtitle.
 - **FEAT**: update dependencies.


## 2023-08-15

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.9`](#matex_core---v009)
 - [`matex_financial` - `v0.0.14`](#matex_financial---v0014)

---

#### `matex_core` - `v0.0.9`

 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: remove dead code.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.

#### `matex_financial` - `v0.0.14`

 - **FIX**: minor improvements.
 - **FIX**: rename to RiskReward.
 - **FIX**: minor improvements.
 - **FEAT**: localize PDF.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: add validators to MatexStockPositionSizeCalculator.
 - **FEAT**: better export to PDF file.


## 2023-08-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.8+1`](#matex_core---v0081)
 - [`matex_financial` - `v0.0.13+1`](#matex_financial---v00131)

---

#### `matex_core` - `v0.0.8+1`

 - **FIX**: dependency requirements.

#### `matex_financial` - `v0.0.13+1`

 - **FIX**: dependency requirements.


## 2023-08-07

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.8`](#matex_core---v008)
 - [`matex_financial` - `v0.0.13`](#matex_financial---v0013)

---

#### `matex_core` - `v0.0.8`

 - **FIX**: minor issue.
 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.13`

 - **FEAT**: update dependencies.


## 2023-07-31

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.12`](#matex_financial---v0012)

---

#### `matex_financial` - `v0.0.12`

 - **FIX**: wrong import.
 - **FEAT**: update dependencies.


## 2023-07-31

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.7`](#matex_core---v007)
 - [`matex_financial` - `v0.0.11`](#matex_financial---v0011)

---

#### `matex_core` - `v0.0.7`

 - **FEAT**: update dependencies.

#### `matex_financial` - `v0.0.11`

 - **FEAT**: update dependencies.


## 2023-07-16

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.6`](#matex_core---v006)
 - [`matex_financial` - `v0.0.10`](#matex_financial---v0010)

---

#### `matex_core` - `v0.0.6`

 - **FEAT**: minor improvements.

#### `matex_financial` - `v0.0.10`

 - **FEAT**: minor improvements.


## 2023-07-04

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.5`](#matex_core---v005)
 - [`matex_financial` - `v0.0.9`](#matex_financial---v009)

---

#### `matex_core` - `v0.0.5`

 - **FEAT**: update dependencies.
 - **FEAT**: add metadata to blocs.

#### `matex_financial` - `v0.0.9`

 - **FEAT**: update dependencies.


## 2023-06-29

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.8`](#matex_financial---v008)

---

#### `matex_financial` - `v0.0.8`

 - **FEAT**: allow to clear the selection.


## 2023-06-28

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.7`](#matex_financial---v007)

---

#### `matex_financial` - `v0.0.7`

 - **FEAT**: update fastyle_financial dependency.


## 2023-06-28

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.6`](#matex_financial---v006)

---

#### `matex_financial` - `v0.0.6`

 - **FEAT**: rename MatexInstrumentBloc to MatexCurrencyBloc.


## 2023-06-28

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.5+1`](#matex_financial---v0051)

---

#### `matex_financial` - `v0.0.5+1`

 - **FIX**: missing export.


## 2023-06-28

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_financial` - `v0.0.5`](#matex_financial---v005)

---

#### `matex_financial` - `v0.0.5`

 - **FEAT**: add instruments ui.


## 2023-06-25

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.4`](#matex_core---v004)
 - [`matex_financial` - `v0.0.4`](#matex_financial---v004)

---

#### `matex_core` - `v0.0.4`

 - **FIX**: remove defaults min and max fraction digits.
 - **FEAT**: update dependencies.
 - **FEAT**(core): add default info button.

#### `matex_financial` - `v0.0.4`

 - **FIX**: wrong dependency requirement.
 - **FEAT**: update dependencies.
 - **FEAT**: minor improvements.
 - **FEAT**: better pdf for stock position.
 - **FEAT**(StockPositionSizeCalculator): add missing results.


## 2023-06-02

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.3`](#matex_core---v003)
 - [`matex_financial` - `v0.0.3`](#matex_financial---v003)

---

#### `matex_core` - `v0.0.3`

 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: minor improvements.
 - **FEAT**: add UserPreferences Bloc.
 - **FEAT**: support dart 3 & flutter 3.10.0.

#### `matex_financial` - `v0.0.3`

 - **FIX**: bunch of fixes.
 - **FIX**: bunch of fixes.
 - **FIX**: wrong dependency version.
 - **FEAT**: generate stock position size pdf report.
 - **FEAT**: add risk and amount at risk support.
 - **FEAT**: implement MatexStockPositionSizeCalculatorBloc.
 - **FEAT**: add more results.
 - **FEAT**: use Decimal package for MatexStockPositionSizeCalculator.
 - **FEAT**: first implementation of stock position calculator.
 - **FEAT**: implement shareCalculatorState.
 - **FEAT**: more tests.
 - **FEAT**: add missing properties.
 - **FEAT**: minor improvements.
 - **FEAT**: rename discountPercentage.
 - **FEAT**: add missing features.
 - **FEAT**: support dart 3 & flutter 3.10.0.


## 2023-03-29

### Changes

---

Packages with breaking changes:

 - There are no breaking changes in this release.

Packages with other changes:

 - [`matex_core` - `v0.0.2`](#matex_core---v002)
 - [`matex_financial` - `v0.0.2`](#matex_financial---v002)

---

#### `matex_core` - `v0.0.2`

 - **FEAT**: add matex core package.

#### `matex_financial` - `v0.0.2`

 - **FEAT**: add MatexVatCalculator.

