import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarModel extends ChangeNotifier {
  DateTime now = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  Future<void> init() async {}

  DateTime get firstDayOfMonth => DateTime(now.year, now.month - 1, 1);

  DateTime get lastDayOfMonth =>
      DateTime(now.year, now.month + 1, 1).add(const Duration(days: -1));

  void selectDay(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(this.selectedDay, selectedDay)) {
      this.selectedDay = selectedDay;
      this.focusedDay = focusedDay;
      notifyListeners();
    }
  }

  List<dynamic> fetchScheduleForDay(DateTime dateTime) {
    final schedule = {
      '1': ['on', 'on'],
      '2': ['on', 'off'],
      '3': ['on', 'off'],
      '4': ['on', 'on'],
    };
    return schedule[dateTime.day.toString()] ?? [null];
  }
}
