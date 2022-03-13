import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DayPage extends StatefulWidget {
  DayPage(this.selectedDay, this.event, {Key? key}) : super(key: key);
  DateTime selectedDay;
  String event;

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  TextEditingController meetController = TextEditingController();
  TextEditingController fishController = TextEditingController();
  TextEditingController beansController = TextEditingController();
  TextEditingController milkController = TextEditingController();
  TextEditingController eggController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  int? total;

  @override
  void initState() {
    super.initState();
    meetController = new TextEditingController(text: '0');
    fishController = new TextEditingController(text: '0');
    beansController = new TextEditingController(text: '0');
    milkController = new TextEditingController(text: '0');
    eggController = new TextEditingController(text: '0');
    otherController = new TextEditingController(text: '0');
    total = int.parse(widget.event);
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          '',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '摂取値',
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
                                  color: Colors.red.withOpacity(0.4),
                                  child: const Padding(
                                    padding: EdgeInsets.all(13.0),
                                    child: Center(child: Text('肉')),
                                  ),
                                ),
                              ),
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
                                          setState(() {
                                            total = int.parse(
                                                    meetController.text) +
                                                int.parse(fishController.text) +
                                                int.parse(
                                                    beansController.text) +
                                                int.parse(milkController.text) +
                                                int.parse(eggController.text) +
                                                int.parse(otherController.text);
                                          });
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
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.blue.withOpacity(0.4),
                                  child: const Padding(
                                    padding: EdgeInsets.all(13.0),
                                    child: Center(child: Text('魚')),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: fishController,
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
                                          setState(() {
                                            total = int.parse(
                                                    meetController.text) +
                                                int.parse(fishController.text) +
                                                int.parse(
                                                    beansController.text) +
                                                int.parse(milkController.text) +
                                                int.parse(eggController.text) +
                                                int.parse(otherController.text);
                                          });
                                        } else {
                                          setState(() {
                                            this.fishController =
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
                                  color: Colors.green.withOpacity(0.4),
                                  child: const Padding(
                                    padding: EdgeInsets.all(13.0),
                                    child: Center(child: Text('豆')),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: beansController,
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
                                          setState(() {
                                            total = int.parse(
                                                    meetController.text) +
                                                int.parse(fishController.text) +
                                                int.parse(
                                                    beansController.text) +
                                                int.parse(milkController.text) +
                                                int.parse(eggController.text) +
                                                int.parse(otherController.text);
                                          });
                                        } else {
                                          setState(() {
                                            this.beansController =
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
                                  color: Colors.yellow.withOpacity(0.4),
                                  child: const Padding(
                                    padding: EdgeInsets.all(13.0),
                                    child: Center(child: Text('乳製品')),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: milkController,
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
                                          setState(() {
                                            total = int.parse(
                                                    meetController.text) +
                                                int.parse(fishController.text) +
                                                int.parse(
                                                    beansController.text) +
                                                int.parse(milkController.text) +
                                                int.parse(eggController.text) +
                                                int.parse(otherController.text);
                                          });
                                        } else {
                                          setState(() {
                                            this.milkController =
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
                                  color: Colors.orange.withOpacity(0.4),
                                  child: const Padding(
                                    padding: EdgeInsets.all(13.0),
                                    child: Center(child: Text('卵')),
                                  ),
                                ),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: eggController,
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
                                          setState(() {
                                            total = int.parse(
                                                    meetController.text) +
                                                int.parse(fishController.text) +
                                                int.parse(
                                                    beansController.text) +
                                                int.parse(milkController.text) +
                                                int.parse(eggController.text) +
                                                int.parse(otherController.text);
                                          });
                                        } else {
                                          setState(() {
                                            this.eggController =
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
                                  color: Colors.grey.withOpacity(0.4),
                                  child: const Padding(
                                    padding: EdgeInsets.all(13.0),
                                    child: Center(child: Text('その他')),
                                  ),
                                ),
                              ),
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
                                          setState(() {
                                            total = int.parse(
                                                    meetController.text) +
                                                int.parse(fishController.text) +
                                                int.parse(
                                                    beansController.text) +
                                                int.parse(milkController.text) +
                                                int.parse(eggController.text) +
                                                int.parse(otherController.text);
                                          });
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
                    color: Colors.deepOrangeAccent,
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
          ],
        ),
      ),
    );
  }
}
