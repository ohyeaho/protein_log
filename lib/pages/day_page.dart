import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/admob.dart';
import 'package:protein_log/model/protein_data.dart';
import 'package:protein_log/pages/add_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Map<DateTime, List<dynamic>> dayTotalData = {};

  List<ProteinData> proteinList = [
    ProteinData(proteinName: '肉', color: 0x66f44336, proteinIntake: 0),
    ProteinData(proteinName: '魚', color: 0x662196f3, proteinIntake: 0),
    ProteinData(proteinName: '豆', color: 0x664caf50, proteinIntake: 0),
    ProteinData(proteinName: '乳製品', color: 0x66ffeb3b, proteinIntake: 0),
    ProteinData(proteinName: '卵', color: 0x66ff9800, proteinIntake: 0),
    ProteinData(proteinName: 'プロテイン', color: 0x669e9e9e, proteinIntake: 0),
    ProteinData(proteinName: 'その他', color: 0x66000000, proteinIntake: 0),
  ];

  void setProteinList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
      Map<String, dynamic> newMap = {};
      map.forEach((key, value) {
        newMap[key.toString()] = map[key];
      });
      return newMap;
    }

    String encodedMap = json.encode(encodeMap(dayTotalData));
    prefs.setString('proteinList', encodedMap);
  }

  void getProteinList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('proteinList')) {
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
        decodeMap(json.decode(prefs.getString('proteinList') ?? '')),
      );
      dayTotalData = newMap;
    });
  }

  void deleteProteinList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('proteinList');
  }

  @override
  void initState() {
    super.initState();
    total = int.parse(widget.event);
    getProteinList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final BannerAd myBanner = BannerAd(
      adUnitId: AdMob().getBannerAdUnitId(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, total);
        dayTotalData.containsKey(widget.selectedDay) == true ? null : dayTotalData[widget.selectedDay] = proteinList;
        setProteinList();
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
                    if (dayTotalData.containsKey(widget.selectedDay) == true) {
                      // dayTotalData.updateAll((key, value) {
                      //   value.add(
                      //     ProteinData(
                      //       proteinName: proteinName,
                      //       color: 0xffffffff,
                      //     ),
                      //   );
                      //   return value;
                      // });

                      dayTotalData.update(widget.selectedDay, (value) {
                        value.add(
                          ProteinData(proteinName: proteinName, color: 0xffffffff),
                        );
                        return value;
                      });
                      setProteinList();
                    } else {
                      proteinList.add(
                        ProteinData(proteinName: proteinName, color: 0xffffffff),
                      );
                    }
                  } else {
                    return null;
                  }
                });
                getProteinList();
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
                  itemCount: dayTotalData.containsKey(widget.selectedDay) == true ? dayTotalData[widget.selectedDay]!.length : proteinList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 3,
                      clipBehavior: Clip.antiAlias,
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                color: Color(
                                  dayTotalData.containsKey(widget.selectedDay) == true
                                      ? dayTotalData[widget.selectedDay]![index]['color']
                                      : proteinList[index].color,
                                ),
                                child: SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      dayTotalData.containsKey(widget.selectedDay) == true
                                          ? dayTotalData[widget.selectedDay]![index]['proteinName']
                                          : proteinList[index].proteinName,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: TextEditingController(
                                          text: dayTotalData.containsKey(widget.selectedDay) == true
                                              ? dayTotalData[widget.selectedDay]![index]['proteinIntake'].toString()
                                              : proteinList[index].proteinIntake.toString(),
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLength: 3,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        decoration: InputDecoration(counterText: ''),
                                        onChanged: (text) {
                                          if (text.length > 0) {
                                            // 入力値があるなら、それを反映する。
                                            setState(() {
                                              dayTotalData.containsKey(widget.selectedDay) == true
                                                  ? dayTotalData[widget.selectedDay]![index]['proteinIntake'] = int.parse(text)
                                                  : proteinList[index].proteinIntake = int.parse(text);
                                            });
                                          } else {
                                            setState(() {
                                              dayTotalData.containsKey(widget.selectedDay) == true
                                                  ? dayTotalData[widget.selectedDay]![index]['controller'] = TextEditingController(text: '0')
                                                  : this.proteinList[index].controller = TextEditingController(text: '0');
                                              dayTotalData.containsKey(widget.selectedDay) == true
                                                  ? dayTotalData[widget.selectedDay]![index]['proteinIntake'] = 0
                                                  : proteinList[index].proteinIntake = 0;
                                            });
                                          }
                                          int ans = 0;
                                          for (var i = 0;
                                              dayTotalData.containsKey(widget.selectedDay) == true
                                                  ? i < dayTotalData[widget.selectedDay]!.length
                                                  : i < proteinList.length;
                                              i++) {
                                            dayTotalData.containsKey(widget.selectedDay) == true
                                                ? ans += dayTotalData[widget.selectedDay]![i]['proteinIntake'] as int
                                                : ans += proteinList[i].proteinIntake;
                                          }
                                          total = ans;
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
      ),
    );
  }
}
