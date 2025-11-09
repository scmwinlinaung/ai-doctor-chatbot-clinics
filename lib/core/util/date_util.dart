import 'package:intl/intl.dart';

class DateUtil {
  static String formatToLocalDateTime(DateTime dateTime) {
    final DateTime localDateTime = dateTime.toLocal();
    return DateFormat("yyyy-MM-dd HH:mm").format(localDateTime);
  }

  static String formatStringToLocalDateTime(String dateString) {
    try {
      final DateTime dateTime = DateTime.parse(dateString);
      return formatToLocalDateTime(dateTime);
    } catch (e) {
      return dateString; // Fallback to original string if parsing fails
    }
  }

  static String formatToUTC(DateTime dateTime) {
    final DateTime utcDateTime = dateTime.toUtc();
    return DateFormat("yyyy-MM-dd HH:mm:ss 'UTC'").format(utcDateTime);
  }

  static String formatStringToUTC(String dateString) {
    try {
      final DateTime dateTime = DateTime.parse(dateString);
      return formatToUTC(dateTime);
    } catch (e) {
      return dateString; // Fallback to original string if parsing fails
    }
  }

  static String formatDateOnly(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String formatStringToDateOnly(String dateString) {
    try {
      final DateTime dateTime = DateTime.parse(dateString).toLocal();
      return formatDateOnly(dateTime);
    } catch (e) {
      return dateString; // Fallback to original string if parsing fails
    }
  }
}
