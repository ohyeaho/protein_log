import 'package:flutter/material.dart';
import 'package:protein_log/calendar_model.dart';
import 'package:protein_log/custom_calendar_builders.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CalendarModel>(
      create: (_) => CalendarModel()..init(),
      child: Consumer<CalendarModel>(builder: (context, model, snapshot) {
        final CustomCalendarBuilders customCalendarBuilders =
            CustomCalendarBuilders();

        return Scaffold(
          appBar: AppBar(
            title: const Text('たんぱくログ'),
          ),
          body: Column(
            children: [
              TableCalendar<dynamic>(
                focusedDay: model.focusedDay,
                firstDay: model.firstDayOfMonth,
                lastDay: model.lastDayOfMonth,
                locale: Localizations.localeOf(context).languageCode,
                // markerBuilderの大きさに合わせて調整してください
                rowHeight: 70,
                // 曜日文字の大きさに合わせて調整してください
                // 日本語だとこのくらいで見切れなくなります
                daysOfWeekHeight: 32,
                // 見た目をスッキリさせるためなのでなくても大丈夫です
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                ),
                calendarStyle: const CalendarStyle(
                  // true（デフォルト）の場合は
                  // todayBuilderが呼ばれるので設定しましょう
                  isTodayHighlighted: false,
                ),
                // カスタマイズ用の関数を渡してやりましょう
                calendarBuilders: CalendarBuilders(
                  dowBuilder: customCalendarBuilders.daysOfWeekBuilder,
                  defaultBuilder: customCalendarBuilders.defaultBuilder,
                  disabledBuilder: customCalendarBuilders.disabledBuilder,
                  selectedBuilder: customCalendarBuilders.selectedBuilder,
                  markerBuilder: customCalendarBuilders.markerBuilder,
                ),
                eventLoader: model.fetchScheduleForDay,
                selectedDayPredicate: (day) {
                  return isSameDay(model.selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  model.selectDay(selectedDay, focusedDay);
                },
              ),
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: Colors.red),
                      color: Colors.red,
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '目標: 60.0g',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
