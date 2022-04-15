import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/admob.dart';
import 'package:protein_log/model/protein_data.dart';
import 'package:protein_log/pages/add_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class TotalIntake {
//   final String? proteinName;
//   int? proteinIntake;
//
//   TotalIntake({this.proteinName, this.proteinIntake});
// }

class DayPage extends StatefulWidget {
  DayPage(this.selectedDay, this.event, {Key? key}) : super(key: key);
  final DateTime selectedDay;
  final String event;

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  int? total;
  ProteinData proteinData = ProteinData();
  // Map<String, int> eachProtein = {};
  // TotalIntake totalIntake = TotalIntake();

  List<ProteinData> proteinList = [
    ProteinData(
        proteinName: '肉',
        color: Colors.red.withOpacity(0.4),
        proteinIntake: 0,
        controller: TextEditingController(
          text: ProteinData().proteinIntake.toString(),
        )),
    ProteinData(
        proteinName: '魚',
        color: Colors.blue.withOpacity(0.4),
        proteinIntake: 0,
        controller: TextEditingController(
          text: ProteinData().proteinIntake.toString(),
        )),
    ProteinData(
        proteinName: '豆',
        color: Colors.green.withOpacity(0.4),
        proteinIntake: 0,
        controller: TextEditingController(
          text: ProteinData().proteinIntake.toString(),
        )),
    ProteinData(
        proteinName: '乳製品',
        color: Colors.yellow.withOpacity(0.4),
        proteinIntake: 0,
        controller: TextEditingController(
          text: ProteinData().proteinIntake.toString(),
        )),
    ProteinData(
        proteinName: '卵',
        color: Colors.orange.withOpacity(0.4),
        proteinIntake: 0,
        controller: TextEditingController(
          text: ProteinData().proteinIntake.toString(),
        )),
    ProteinData(
        proteinName: 'プロテイン',
        color: Colors.grey.withOpacity(0.4),
        proteinIntake: 0,
        controller: TextEditingController(
          text: ProteinData().proteinIntake.toString(),
        )),
    ProteinData(
        proteinName: 'その他',
        color: Colors.black.withOpacity(0.4),
        proteinIntake: 0,
        controller: TextEditingController(
          text: ProteinData().proteinIntake.toString(),
        )),
  ];

  void setProteinList() async {
    List<String> encodeList = proteinList.map((e) => json.encode(e.toJson())).toList();
    // String encoded = jsonEncode(proteinList);
    // print(encoded);
    print(encodeList);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('proteinList', encodeList);
  }

  void getProteinList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('proteinList');
    print(result);
    //
    // List<ProteinData> newList = [];
    // newList =

    if (result != null) {
      proteinList = result.map((e) => ProteinData.fromJson(json.decode(e))).toList();
    } else {
      return;
    }
    print(proteinList);
  }

  @override
  void initState() {
    super.initState();
    total = int.parse(widget.event);
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, List<dynamic>> dayTotalData = {widget.selectedDay: proteinList};
    print(dayTotalData);
    final height = MediaQuery.of(context).size.height;
    final BannerAd myBanner = BannerAd(
      adUnitId: AdMob().getBannerAdUnitId(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, total);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.selectedDay.year}/${widget.selectedDay.month}/${widget.selectedDay.day}'),
          actions: [
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPage(),
                    fullscreenDialog: true,
                  ),
                ).then((proteinName) {
                  if (proteinName != null) {
                    proteinList.add(
                      ProteinData(
                        proteinName: proteinName,
                        color: Colors.black.withOpacity(0.4),
                        proteinIntake: 0,
                        controller: TextEditingController(text: proteinData.proteinIntake.toString()),
                      ),
                    );
                  } else {
                    return null;
                  }
                });
                setState(() {});
              },
              icon: Icon(Icons.add),
            ),
          ],
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
              child: ListView.builder(
                  itemCount: proteinList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: proteinList[index].color,
                                child: Padding(
                                  padding: EdgeInsets.all(13.0),
                                  child: Center(child: Text(proteinList[index].proteinName)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: proteinList[index].controller,
                                        textAlign: TextAlign.center,
                                        maxLength: 3,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        decoration: InputDecoration(counterText: ''),
                                        onChanged: (text) {
                                          if (text.length > 0) {
                                            // 入力値があるなら、それを反映する。
                                            setState(() {
                                              proteinList[index].proteinIntake = int.parse(text);
                                              // eachProtein[proteinList[index].proteinName] = int.parse(text);
                                            });
                                          } else {
                                            setState(() {
                                              this.proteinList[index].controller = TextEditingController(text: '0');
                                              proteinList[index].proteinIntake = 0;
                                              // eachProtein[proteinList[index].proteinName] = 0;
                                            });
                                          }
                                          int ans = 0;
                                          for (var i = 0; i < proteinList.length; i++) {
                                            ans += proteinList[i].proteinIntake;
                                          }
                                          total = ans;
                                          // List<int> totalIntakeList = [];
                                          // eachProtein.forEach((key, value) => totalIntakeList.add(value));
                                          // total = totalIntakeList.reduce((value, element) => value + element);
                                        },
                                      ),
                                    ),
                                    Text('g'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            ElevatedButton(
              onPressed: () => setProteinList(),
              child: Text('set'),
            ),
            ElevatedButton(
              onPressed: () => getProteinList(),
              child: Text('get'),
            ),
            Container(
              height: 80,
              color: Colors.white,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
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
            Container(
              height: height * 0.06,
              child: AdWidget(ad: myBanner),
            ),
          ],
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 13.0),
        //   child: FloatingActionButton(
        //     onPressed: () async {
        //       await Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => AddPage(),
        //           fullscreenDialog: true,
        //         ),
        //       ).then((proteinName) => proteinList.add(ProteinData(
        //             proteinName: proteinName,
        //             color: Colors.black.withOpacity(0.4),
        //             proteinIntake: 0,
        //             controller: TextEditingController(text: '0'),
        //           )));
        //       setState(() {});
        //     },
        //     child: Icon(Icons.add),
        //   ),
        // ),
      ),
    );
  }
}
