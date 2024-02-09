import 'package:t_helpers/helpers.dart';

enum MatexBlocAnalyticsEvent {
  exportToPdf,
  exportToExcel,
  exportToCsv,
}

extension MatexBlocAnalyticsEventX on MatexBlocAnalyticsEvent {
  String get snakeCase => toSnakeCase(name);
}
