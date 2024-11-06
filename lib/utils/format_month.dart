import 'package:intl/intl.dart';

String formatMonth(int monthInInt) {
  String monthInLetter = DateFormat('MMM').format(DateTime.now());
  switch (monthInInt) {
    case 1:
      {
        monthInLetter = "Jan";
        break;
      }
    case 2:
      {
        monthInLetter = "Feb";
        break;
      }
    case 3:
      {
        monthInLetter = "Mar";
        break;
      }
    case 4:
      {
        monthInLetter = "Apr";
        break;
      }
    case 5:
      {
        monthInLetter = "May";
        break;
      }
    case 6:
      {
        monthInLetter = "Jun";
        break;
      }
    case 7:
      {
        monthInLetter = "Jul";
        break;
      }
    case 8:
      {
        monthInLetter = "Aug";
        break;
      }
    case 9:
      {
        monthInLetter = "Sep";
        break;
      }
    case 10:
      {
        monthInLetter = "Oct";
        break;
      }
    case 11:
      {
        monthInLetter = "Nov";
        break;
      }
    case 12:
      {
        monthInLetter = "Dec";
        break;
      }
  }
  return monthInLetter;
}
