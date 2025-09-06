extension ExtraStringMethods on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  DateTime? toDate() {
    var date = split('-');
    if (date.length < 3) {
      return null;
    } else {
      return DateTime(
          int.parse(date[0]), int.parse(date[1]), int.parse(date[2]));
    }
  }
}

extension ExtraDateTimeMethods on DateTime {
  String toCustomString() {
    var tempMonth = month.toString();
    tempMonth = tempMonth.length < 2 ? '0$tempMonth' : tempMonth;
    var tempDay = day.toString();
    tempDay = tempDay.length < 2 ? '0$tempDay' : tempDay;
    return '$year-$tempMonth-$tempDay';
  }
}
