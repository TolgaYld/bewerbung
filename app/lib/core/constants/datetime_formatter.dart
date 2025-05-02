import 'package:intl/intl.dart';

class DateTimeFormatter {
  DateTimeFormatter._();

  static const _fallbackLocale = 'de';

  static String formatDateShort(DateTime date, {String? locale}) =>
      DateFormat.yMd(locale ?? _fallbackLocale).format(date);

  static String formatDateLong(DateTime date, {String? locale}) =>
      DateFormat.yMMMMd(locale ?? _fallbackLocale).format(date);

  static String formatTime(DateTime date, {String? locale}) =>
      DateFormat.Hm(locale ?? _fallbackLocale).format(date);

  static String formatDateTimeCombined(DateTime date, {String? locale}) =>
      DateFormat.yMMMMd(locale ?? _fallbackLocale).add_jm().format(date);

  static String formatIsoDate(DateTime date, {String? locale}) =>
      DateFormat('yyyy-MM-dd', locale ?? _fallbackLocale).format(date);

  static String formatMonthYear(DateTime date, {String? locale}) =>
      DateFormat('MM/yyyy', locale ?? _fallbackLocale).format(date);
}
