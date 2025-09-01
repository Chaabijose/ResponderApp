extension DateTimeExtension on DateTime{
  DateTime get start => DateTime(year,month, day);
  DateTime get end => DateTime(year,month,day).add(const Duration(days: 1)).subtract(const Duration(seconds: 1));
  bool get isToday => DateTime.now().year == year && DateTime.now().month == month && DateTime.now().day == day;
}