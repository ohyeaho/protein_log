import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DayLog extends StatefulWidget {
  DayLog(this.selectedDay, {Key? key}) : super(key: key);
  DateTime selectedDay;

  @override
  State<DayLog> createState() => _DayLogState();
}

class _DayLogState extends State<DayLog> {
  TextEditingController otherController = TextEditingController();
  TextEditingController meetController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otherController = new TextEditingController(text: '0');
    meetController = new TextEditingController(text: '0');
  }

  @override
  Widget build(BuildContext context) {
    double other = double.parse(otherController.text);
    double meet = double.parse(meetController.text);
    int total =
        int.parse(otherController.text) + int.parse(meetController.text);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, total);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              '${widget.selectedDay.year}/${widget.selectedDay.month}/${widget.selectedDay.day}'),
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      color: Colors.grey,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(child: Text('その他')),
                                      ))),
                              Expanded(child: Center(child: Text('プロテイン'))),
                              Expanded(child: Center(child: Text('20g'))),
                              Expanded(
                                  child: Center(
                                      child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: otherController,
                                      textAlign: TextAlign.center,
                                      maxLength: 3,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration:
                                          InputDecoration(counterText: ''),
                                      onChanged: (text) {
                                        if (text.length > 0) {
                                          // 入力値があるなら、それを反映する。
                                          setState(() {});
                                        } else {
                                          setState(() {
                                            this.otherController =
                                                TextEditingController(
                                                    text: '0');
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Text('g'),
                                ],
                              ))),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      color: Colors.grey,
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Center(child: Text('その他')),
                                      ))),
                              Expanded(child: Center(child: Text('プロテイン'))),
                              Expanded(child: Center(child: Text('20g'))),
                              Expanded(
                                  child: Center(
                                      child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: meetController,
                                      textAlign: TextAlign.center,
                                      maxLength: 3,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      decoration:
                                          InputDecoration(counterText: ''),
                                      onChanged: (text) {
                                        if (text.length > 0) {
                                          // 入力値があるなら、それを反映する。
                                          setState(() {});
                                        } else {
                                          setState(() {
                                            this.meetController =
                                                TextEditingController(
                                                    text: '0');
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Text('g'),
                                ],
                              ))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '合計: ${total.toString()}g',
                      style: const TextStyle(
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
      ),
    );
  }
}
