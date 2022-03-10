import 'package:flutter/material.dart';
import 'package:protein_log/calendar_model.dart';
import 'package:protein_log/custom_calendar_builders.dart';
import 'package:protein_log/day_log.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int _total = 0;

  void _totalValue(total) {
    setState(() {
      _total = total;
      _setValue();
    });
  }

  void _getValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _total = prefs.getInt('total') ?? 0;
    });
  }

  void _setValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('total', _total);
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _getValue();
    _totalValue(_total);
  }

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
                focusedDay: _focusedDay,
                firstDay: DateTime(2022, 1, 1),
                lastDay: model.lastDayOfMonth,
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
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
                  isTodayHighlighted: true,
                ),
                // カスタマイズ用の関数を渡してやりましょう
                calendarBuilders: CalendarBuilders(
                  dowBuilder: customCalendarBuilders.daysOfWeekBuilder,
                  defaultBuilder: customCalendarBuilders.defaultBuilder,
                  disabledBuilder: customCalendarBuilders.disabledBuilder,
                  selectedBuilder: customCalendarBuilders.selectedBuilder,
                  markerBuilder: customCalendarBuilders.markerBuilder,
                  // markerBuilder: (
                  //   BuildContext context,
                  //   DateTime day,
                  //   List<dynamic> dailyScheduleList,
                  // ) {
                  //   final am = dailyScheduleList.first ?? '';
                  //
                  //   _scheduleText(String schedule) {
                  //     if (schedule == 'on') {
                  //       return Text(
                  //         '${_total.toString()}g',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       );
                  //     } else {
                  //       return const Text('-');
                  //     }
                  //   }
                  //
                  //   return Padding(
                  //     padding: const EdgeInsets.only(top: 24),
                  //     child: Center(
                  //       child: _scheduleText(am),
                  //     ),
                  //   );
                  // },
                  todayBuilder: customCalendarBuilders.todayBuilder,
                  outsideBuilder: customCalendarBuilders.disabledBuilder,
                ),
                eventLoader: model.fetchScheduleForDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                // onDaySelected: (selectedDay, focusedDay) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => const DayLog()),
                //   );
                // },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DayLog(selectedDay)),
                    ).then((total) => {_totalValue(total)});
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                // onDaySelected: (selectedDay, focusedDay) {
                //   model.selectDay(selectedDay, focusedDay);
                // },
              ),
              Expanded(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: Colors.red),
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _total.toString(),
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
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
