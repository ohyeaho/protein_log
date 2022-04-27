import 'dart:convert';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/admob.dart';
import 'package:protein_log/model/custom_calendar_builders.dart';
import 'package:protein_log/pages/day_page.dart';
import 'package:protein_log/pages/goal_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime, List<dynamic>> selectedEvents = {};
  DateTime now = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  DateTime get lastDayOfMonth => DateTime(now.year, now.month + 1, 1).add(const Duration(days: -1));
  int total = 0;
  int goal = 0;
  int dayTotal = 0;

  /// AppTrackingTransparency起動method
  void initPlugin() async {
    final status = await AppTrackingTransparency.trackingAuthorizationStatus;
    if (status == TrackingStatus.notDetermined) {
      await Future.delayed(const Duration(milliseconds: 200));
      await AppTrackingTransparency.requestTrackingAuthorization();
    }
  }

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
    });
  }

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
    WidgetsBinding.instance?.addPostFrameCallback((_) => initPlugin());
    _getGoal();
    _getSelectedEvents();
  }

  List<dynamic> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    print(selectedEvents);
    final CustomCalendarBuilders customCalendarBuilders = CustomCalendarBuilders();
    final height = MediaQuery.of(context).size.height;
    final BannerAd myBanner = BannerAd(
      adUnitId: AdMob().getBannerAdUnitId(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();

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
            locale: 'ja_JP',
            rowHeight: 70,
            daysOfWeekHeight: 32,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,
            onDaySelected: (DateTime selectDay, DateTime focusDay) async {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayPage(selectDay, selectedEvents[selectedDay]?[0] ?? '0'),
                ),
              ).then((dayTotal) => _totalValue(dayTotal));
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
            eventLoader: _getEventsFromDay,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
              leftChevronVisible: false,
              rightChevronVisible: false,
            ),
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              markersAutoAligned: false,
            ),
            calendarBuilders: CalendarBuilders(
              dowBuilder: customCalendarBuilders.daysOfWeekBuilder,
              defaultBuilder: customCalendarBuilders.defaultBuilder,
              outsideBuilder: customCalendarBuilders.disabledBuilder,
              disabledBuilder: customCalendarBuilders.disabledBuilder,
              selectedBuilder: customCalendarBuilders.selectedBuilder,
              todayBuilder: customCalendarBuilders.todayBuilder,
              singleMarkerBuilder: customCalendarBuilders.markerBuilder,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
          Expanded(
            flex: 1,
            child: Container(
              height: height * 0.06,
              child: AdWidget(ad: myBanner),
            ),
          ),
        ],
      ),
    );
  }
}
