import 'package:intl/intl.dart';

class VDateFormatter {

  static String historyDateFormatter(DateTime date) {
    return DateFormat('MMM d, hh:mm a').format(date);
  }

}