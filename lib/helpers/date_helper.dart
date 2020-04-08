import 'package:intl/intl.dart';

String getDateAlone(DateTime dateTime) {
  return DateFormat('yyyy-MM-dd').format(dateTime);
}

String getDateAloneFromString(String dateTime) {
  return getDateAlone(DateTime.parse(dateTime));
}

String getDateTimeFormatted(String dateTime) {
  // To fix the URC parse issue in dart
  if (dateTime.indexOf('.') != -1) {
    dateTime = dateTime.substring(0, dateTime.indexOf('.'));
  }
  DateTime dt = DateTime.parse(dateTime);
  DateTime u = DateTime.utc(dt.year, dt.month, dt.day, dt.hour, dt.minute,
      dt.second, dt.millisecond, dt.microsecond);

  return DateFormat('MMM dd yyyy hh:mm a').format(u.toLocal());
}

bool checkToday(String date) {
  final now = DateTime.now();
  final dateNotified = DateTime.parse(date);

  return (dateNotified.year == now.year &&
      dateNotified.month == now.month &&
      dateNotified.day == now.day);
}

bool compareDay(String dateOne, String dateTwo) {
  // final now = DateTime.now();

  dateOne = stripDot(dateOne);
  dateTwo = stripDot(dateTwo);

  final one = DateTime.parse(dateOne);
  final two = DateTime.parse(dateTwo);

  return (one.year == two.year && one.month == two.month && one.day == two.day);
}

bool compareIsAfter(String dateOne, String dateTwo) {
  dateOne = stripDot(dateOne);
  dateTwo = stripDot(dateTwo);

  // final now = DateTime.now();
  final one = DateTime.parse(dateOne);
  final two = DateTime.parse(dateTwo);

  return two.isAfter(one);
}

String stripDot(String dateOne) {
  if (dateOne.indexOf('.') != -1) {
    dateOne = dateOne.substring(0, dateOne.indexOf('.'));
  }
  return dateOne;
}
