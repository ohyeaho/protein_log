import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:protein_log/day_log.dart';
import 'package:protein_log/event.dart';
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
  int _total = 0;
  // DateTime? eventDate;
  // List<Event>? eventTotal;
  // final TextEditingController _eventController = TextEditingController();

  // Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  //   Map<String, dynamic> newMap = {};
  //   map.forEach((key, value) {
  //     newMap[key.toString()] = map[key];
  //   });
  //   return newMap;
  // }

  // late String encoded = json.encode(encodeMap(selectedEvents!));

  // late String encoded = jsonEncode(encodeMap(selectedEvents!));

  void _totalValue(total) async {
    setState(() {
      _total = total;
      // print('total: $total');
      // selectedEvents![selectedDay] = [Event(total.toString())];
      // print('selectedEvents: $selectedEvents');
      // _setValue();
    });
  }

  void _setValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt('total', _total);

    // final eventData = json.encode({
    //   'total': _total,
    //   'selectedDay': selectedDay.toIso8601String(),
    // });
    // await prefs.setString('eventData', eventData);

    // Map<String, dynamic> map = {
    //   'selectedDay': selectedDay.toIso8601String(),
    //   'total': selectedEvents![selectedDay]
    // };
    // String rawJson = jsonEncode(map);
    // prefs.setString('selectedEvents', rawJson);
    // prefs.setStringList('selectedEvents', selectedEvents![selectedDay]);

    // Map<String, dynamic> eventData = {
    //   selectedDay.toIso8601String(): selectedEvents![selectedDay]
    // };
    //
    // final String eventString = json.encode(eventData);
    //
    // print('eventString: $eventString');
    //
    // prefs.setString('eventString', eventString);

    Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
      Map<String, dynamic> newMap = {};
      map.forEach((key, value) {
        newMap[key.toString()] = map[key];
      });
      return newMap;
    }

    String testEncoded = json.encode(encodeMap(selectedEvents));

    print('testEncoded: $testEncoded');

    prefs.setString('eventString', testEncoded);
  }

  void _getValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   _total = prefs.getInt('total') ?? 0;
    // });

    // final rawJson = prefs.getString('selectedEvents') ?? '';
    // Map<String, dynamic> map = jsonDecode(rawJson);

    // setState(() {
    //   final eventData = json.decode(prefs.getString('eventString') ?? '');
    //   _total = eventData[selectedEvents![selectedDay]] ?? 0;
    // });

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
      // json.decodeでStringをMapへ
      newMap = Map<DateTime, List<dynamic>>.from(
        // 以下は、実際にはsharedPreferences等を利用し、取得したString値を入れる
        decodeMap(json.decode(prefs.getString('eventString') ?? '')),
      );
      print('newMap.runtimeType: ${newMap.runtimeType}');
      print('_getValue newMap: $newMap');

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

      selectedEvents = newMap;

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

  void _removeValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('eventString');
    setState(() {
      selectedEvents = {};
    });
  }

  @override
  void initState() {
    super.initState();
    _getValue();
    _totalValue(_total);
    // print('selectedEvents: $selectedEvents');
    // selectedEvents = selectedEvents ??
    //     {
    //       // DateTime(now.year, now.month, now.day): [Event(title: '0')]
    //     };
  }

  List<dynamic> _getEventsFromDay(DateTime date) {
    // print('$date: ${selectedEvents![date]}');
    return selectedEvents[date] ?? [];
  }

  // @override
  // void dispose() {
  //   _eventController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('たんぱくログ'),
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
            locale: Localizations.localeOf(context).languageCode,
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
                MaterialPageRoute(builder: (context) => DayLog(selectDay)),
              ).then((total) => _totalValue(total));
              selectedEvents[selectedDay] = [Event(_total.toString())];
              _setValue();
              print(focusedDay);
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
              print('--------------------------------------------------------');
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: Text('${event}g')),
              );
            }),
          ),
          // ..._getEventsFromDay(selectedDay).map(
          //   (Event event) => ListTile(
          //     title: Text(
          //       event.title,
          //     ),
          //   ),
          // ),
          Text(_total.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _removeValue();
                },
                child: Text('reset'),
              ),
              ElevatedButton(
                onPressed: () {
                  // print(eventDate);
                },
                child: Text('test'),
              ),
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () => showDialog(
      //     context: context,
      //     builder: (context) => AlertDialog(
      //       title: Text("Add Event"),
      //       content: TextFormField(
      //         controller: _eventController,
      //       ),
      //       actions: [
      //         TextButton(
      //           child: Text("Cancel"),
      //           onPressed: () => Navigator.pop(context),
      //         ),
      //         TextButton(
      //           child: Text("Ok"),
      //           onPressed: () {
      //             if (_eventController.text.isEmpty) {
      //             } else {
      //               if (selectedEvents![selectedDay] != null) {
      //                 print('hoge');
      //                 selectedEvents![selectedDay]!.add(
      //                   Event(title: _eventController.text),
      //                 );
      //               } else {
      //                 print('test');
      //                 selectedEvents![selectedDay] = [
      //                   Event(title: _eventController.text)
      //                 ];
      //               }
      //             }
      //             Navigator.pop(context);
      //             _eventController.clear();
      //             setState(() {});
      //             return;
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      //   label: Text("Add Event"),
      //   icon: Icon(Icons.add),
      // ),
    );
  }
}
