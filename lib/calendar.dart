import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:protein_log/day_log.dart';
import 'package:protein_log/goal_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<DateTime, List<dynamic>> selectedEvents = {};
  List<dynamic> event = [];
  CalendarFormat format = CalendarFormat.month;
  DateTime now = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime get lastDayOfMonth =>
      DateTime(now.year, now.month + 1, 1).add(const Duration(days: -1));
  int total = 0;
  int goal = 0;
  int dayTotal = 0;

  void _totalValue(_total) async {
    setState(() {
      total = _total;
      selectedEvents[selectedDay] = [total.toString()];
      _setSelectedEvents();
    });
  }

  void _setSelectedEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
      Map<String, dynamic> newMap = {};
      map.forEach((key, value) {
        newMap[key.toString()] = map[key];
      });
      return newMap;
    }

    String testEncoded = json.encode(encodeMap(selectedEvents));
    prefs.setString('eventString', testEncoded);
  }

  void _getSelectedEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('eventString')) {
      return;
    }

    Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
      Map<DateTime, dynamic> newMap = {};
      map.forEach((key, value) {
        newMap[DateTime.parse(key)] = map[key];
      });
      return newMap;
    }

    setState(() {
      Map<DateTime, List<dynamic>> newMap = {};
      newMap = Map<DateTime, List<dynamic>>.from(
        decodeMap(json.decode(prefs.getString('eventString') ?? '')),
      );

      selectedEvents = newMap;

      ///Map<DateTime, List<Event>>でdecodeできなかったのでコメントアウト
      // String rowJson = prefs.getString('eventString') ?? '';
      // print(rowJson);
      // Map<String, dynamic> map = jsonDecode(rowJson);
      // SelectedEvents _selectedEvent = SelectedEvents.fromJson(map);
      // print('map: $map');
      // print(map.runtimeType);
      // print('_selectedEvent: $_selectedEvent');
      // print(_selectedEvent.runtimeType);

      // List<Event>? event;
      // newMap.forEach((key, value) {
      //   event = newMap[value]!.cast<Event>();
      // });

      // print(newMap.cast<DateTime, List<Event>>());

      // print('selectedEvents.runtimeType: ${selectedEvents.runtimeType}');
      // print('_getValue selectedEvents: $selectedEvents');

      // Map<DateTime, dynamic> sdMap =
      //     jsonDecode(prefs.getString('eventString') ?? '');
      // selectedEvents =
      //     SelectedEvents.fromJson(sdMap) as Map<DateTime, List<Event>>?;
      // selectedEvents = SelectedEvents.fromJson(
      //         jsonDecode(prefs.getString('eventString') ?? ''))
      //     as Map<DateTime, List<Event>>?;

      /*Map<String, dynamic> sdMap =
          jsonDecode(prefs.getString('eventString') ?? '');
      print('sdMap: $sdMap');
      print('sdMap.runtimeType: ${sdMap.runtimeType}');

      // Map<DateTime, List<dynamic>> newSdMap = {};
      sdMap.forEach((key, value) async {
        // newSdMap[DateTime.parse(key)] = sdMap[key];
        // var event = newSdMap[DateTime.parse(key)];
        selectedEvents = await {
          DateTime.parse(key): [Event(value.toString())]
        };
        print('getValueSelectedEvents: $selectedEvents');
      });*/
      // print('newSdMap.runtimeType: ${newSdMap.runtimeType}');
      // print(newSdMap);

      // print(ddMap['2022-03-07 13:47:52.720287']);
      // print(ddMap[DateTime(2022, 03, 07, 13, 47, 52, 7202387)]);

      // ddMap['$selectedDay'] = DateTime.parse(ddMap['$selectedDay']);
      // List<Event> event = jsonDecode(ddMap['$selectedDay']) ?? [];
      // List<Event> event = List<Event>.from(jsonDecode(ddMap['$selectedDay']));
      // final event = (jsonDecode(ddMap['$selectedDay']) as List)
      //     .map((e) => e as Event)
      //     .toList();

      // print('event: $event');
      //
      // selectedEvents = {selectedDay: event};

      // selectedEvents = jsonDecode(prefs.getString('eventString') ?? '')
      //     .cast<DateTime, List<Event>>();
    });
  }

  ///shared_preferencesの削除現在は使用してないのでコメントアウト
  // void _removeValue() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove('eventString');
  //   setState(() {
  //     selectedEvents = {};
  //   });
  // }

  void _setGoal(goalValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('goal', goalValue);
    setState(() {
      goal = goalValue;
    });
  }

  void _getGoal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      goal = prefs.getInt('goal') ?? 0;
    });
  }

  @override
  void initState() {
    super.initState();
    _getGoal();
    _getSelectedEvents();
  }

  List<dynamic> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロたん'),
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(2022, 1, 1),
            lastDay: lastDayOfMonth,
            // calendarFormat: format,
            // onFormatChanged: (CalendarFormat _format) {
            //   setState(() {
            //     format = _format;
            //   });
            // },
            locale: 'ja_JP',
            rowHeight: 70,
            daysOfWeekHeight: 32,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) async {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DayLog(
                        selectDay, selectedEvents[selectedDay]?[0] ?? '0')),
              ).then((dayTotal) => _totalValue(dayTotal));
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            eventLoader: _getEventsFromDay,
            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronVisible: false,
              rightChevronVisible: false,
            ),
            calendarBuilders:
                CalendarBuilders(singleMarkerBuilder: (context, date, event) {
              print('selectedEvents: $selectedEvents');
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('${event}g')),
              );
            }),
          ),
          Expanded(
            child: Container(
              height: 80,
              color: Colors.white,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GoalPage(goal)),
                    ).then((goalValue) => _setGoal(goalValue));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '目標: ${goal.toString()}g',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
