import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('EEE, d MMM').format(date);
}
