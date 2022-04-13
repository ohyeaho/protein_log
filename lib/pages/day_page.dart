import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/admob.dart';

class TotalIntake {
  final String? proteinName;
  int? proteinIntake;

  TotalIntake({this.proteinName, this.proteinIntake});
}

class ProteinData {
  final String proteinName;
  final Color? color;
  final int? proteinIntake;
  TextEditingController? controller;

  ProteinData({this.proteinName = '', this.color, this.proteinIntake, this.controller});
}

class DayPage extends StatefulWidget {
  DayPage(this.selectedDay, this.event, {Key? key}) : super(key: key);
  DateTime selectedDay;
  String event;

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  int? total;
  Map<String, int> eachProtein = {};
  TotalIntake totalIntake = TotalIntake();

  List<ProteinData> proteinList = [
    ProteinData(proteinName: '肉', color: Colors.red.withOpacity(0.4), proteinIntake: 0, controller: TextEditingController(text: '0')),
    ProteinData(proteinName: '魚', color: Colors.blue.withOpacity(0.4), proteinIntake: 0, controller: TextEditingController(text: '0')),
    ProteinData(proteinName: '豆', color: Colors.green.withOpacity(0.4), proteinIntake: 0, controller: TextEditingController(text: '0')),
    ProteinData(proteinName: '乳製品', color: Colors.yellow.withOpacity(0.4), proteinIntake: 0, controller: TextEditingController(text: '0')),
    ProteinData(proteinName: '卵', color: Colors.orange.withOpacity(0.4), proteinIntake: 0, controller: TextEditingController(text: '0')),
    ProteinData(proteinName: 'その他', color: Colors.grey.withOpacity(0.4), proteinIntake: 0, controller: TextEditingController(text: '0')),
  ];

  @override
  void initState() {
    super.initState();
    total = int.parse(widget.event);
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
      onWillPop: () {
        Navigator.pop(context, total);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${widget.selectedDay.year}/${widget.selectedDay.month}/${widget.selectedDay.day}'),
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
                                              eachProtein[proteinList[index].proteinName] = int.parse(text);
                                            });
                                          } else {
                                            setState(() {
                                              this.proteinList[index].controller = TextEditingController(text: '0');
                                              eachProtein[proteinList[index].proteinName] = 0;
                                            });
                                          }
                                          List<int> totalIntakeList = [];
                                          eachProtein.forEach((key, value) => totalIntakeList.add(value));
                                          total = totalIntakeList.reduce((value, element) => value + element);
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
