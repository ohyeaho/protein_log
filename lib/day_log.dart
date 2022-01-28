import 'package:flutter/material.dart';

class DayLog extends StatelessWidget {
  DayLog(this.selectedDay, {Key? key}) : super(key: key);
  DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('${selectedDay.year}/${selectedDay.month}/${selectedDay.day}'),
      ),
      body: Column(
        children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '基本値',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(),
                      Text(
                        '摂取地',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  Placeholder(),
                  Placeholder(),
                ],
              ),
            ),
          ),
          Container(
            height: 80,
            color: Colors.white,
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
                    '合計: 20.0g',
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 80),
        ],
      ),
    );
  }
}
