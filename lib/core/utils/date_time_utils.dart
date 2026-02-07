import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static String formatTime(String time24) {
    try {
      final dateTime = DateFormat('HH:mm').parse(time24);
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      return time24;
    }
  }

  static String formatDate(DateTime date, {String format = 'MMM dd, yyyy'}) {
    return DateFormat(format).format(date);
  }

  static int getCurrentDayOfMonth() {
    return DateTime.now().day;
  }

  static int getCurrentMonth() {
    return DateTime.now().month;
  }

  static int getCurrentYear() {
    return DateTime.now().year;
  }

  static String getCurrentMonthName() {
    return DateFormat('MMMM').format(DateTime.now());
  }
}
