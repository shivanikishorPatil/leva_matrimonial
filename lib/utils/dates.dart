class Dates {
  static DateTime get now => DateTime.now();
  static DateTime get today => DateTime(now.year, now.month, now.day);

  static DateTime get y18 => DateTime(today.year - 18, today.month, today.day);
  static DateTime get y21 => DateTime(today.year - 21, today.month, today.day);
}
