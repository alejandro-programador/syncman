import 'package:intl/intl.dart';

class DateUtilsHelper {
  static String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
}
