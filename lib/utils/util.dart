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