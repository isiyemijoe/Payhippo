extension DateTimeX on DateTime {
  DateTime updateToMatchEndOfMoment() {
    return add(kDurationTillEndOfDay);
  }
}

const kDurationTillEndOfDay = Duration(
  hours: 23,
  minutes: 59,
  seconds: 59,
  milliseconds: 999,
  microseconds: 999,
);
