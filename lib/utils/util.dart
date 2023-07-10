import 'package:intl/intl.dart';

int birthdayToAge(String birthday) {
  DateTime curDate = DateTime.now();
  DateTime birthDate = DateTime.parse(birthday);

  int age = curDate.year - birthDate.year;

  bool isBirthdayPassed =
      curDate.month > birthDate.month ||
          (curDate.month == birthDate.month && curDate.day >= birthDate.day);

  if (!isBirthdayPassed) age--;

  return age;
}

String formatDateTime(DateTime date) {
  //final now = DateTime.now();
  DateTime now = DateTime(2023, 7, 8, 15, 14, 32, 50);
  final today = DateTime(now.year, now.month, now.day);
  final inputDate = DateTime(date.year, date.month, date.day);

  final formatter = DateFormat('HH:mm', 'ko_KR');

  if (inputDate.isBefore(today)) {
    if (now.year != date.year) {
      return DateFormat('yy.MM.dd', 'ko_KR').format(date);
    } else if (now.difference(date).inDays > 7) {
      return DateFormat('MM월 dd일', 'ko_KR').format(date);
    } else {
      return DateFormat('E', 'ko_KR').format(date); // E stands for Weekday
    }
  } else {
    return DateFormat('a hh:mm', 'ko_KR').format(date);
  }
}
