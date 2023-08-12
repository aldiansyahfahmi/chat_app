import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String toDateFormatWithTime() {
    return DateFormat('dd MMM yyyy, hh:mm').format(this);
  }
}
