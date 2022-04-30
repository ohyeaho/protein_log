import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/admob.dart';
import 'package:protein_log/protein_formula.dart';

class IntakeCalculationPage extends StatefulWidget {
  const IntakeCalculationPage({Key? key}) : super(key: key);

  @override
  State<IntakeCalculationPage> createState() => _IntakeCalculationPageState();
}

class _IntakeCalculationPageState extends State<IntakeCalculationPage> {
  int weight = 60;
  final List<String> itemStrings = [
    '活発に活動していない人',
    'スポーツ愛好者(週に4～5回、30分のトレーニング)',
    '筋力トレーニング(維持期)',
    '筋力トレーニング(増強期)',
    '持久性トレーニング',
    'レジスタンストレーニング',
    'レジスタンストレーニングを始めて間もない時期',
    '状態維持のためのレジスタンストレーニング',
    '断続的な高強度トレーニング',
    'ウエートコントロール期間',
  ];
  String selectText = '運動強度';
  int? _index;
  String radioButtonItem = 'いいえ';
  int ageId = 2;
  String result = '0';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('たんぱく質目安計算'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('体重'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              weight--;
                            });
                          },
                          icon: Icon(Icons.remove_circle_outline),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              weight.toString(),
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('kg')
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              weight++;
                            });
                          },
                          icon: Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: CupertinoSlider(
                        value: weight.toDouble(),
                        min: 0.0,
                        max: 150.0,
                        onChanged: (value) {
                          setState(() {
                            weight = value.toInt();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 8.0),
                  child: OutlinedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: CupertinoPicker(
                                itemExtent: 30,
                                children: itemStrings.map(_pickerItem).toList(),
                                onSelectedItemChanged: (index) {
                                  setState(() {
                                    selectText = itemStrings[index];
                                    _index = index;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            selectText,
                            maxLines: 2,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('10代ですか？'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 1,
                            groupValue: ageId,
                            onChanged: (value) {
                              setState(() {
                                radioButtonItem = 'はい';
                                ageId = 1;
                              });
                            },
                          ),
                          Text(
                            'はい',
                            style: new TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 2,
                            groupValue: ageId,
                            onChanged: (value) {
                              setState(() {
                                radioButtonItem = 'いいえ';
                                ageId = 2;
                              });
                            },
                          ),
                          Text(
                            'いいえ',
                            style: new TextStyle(fontSize: 17.0),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ProteinFormula calc = ProteinFormula(weight: weight, motion: _index, ageId: ageId);
                      setState(() {
                        result = calc.resultProtein()!;
                      });
                    },
                    child: Text(
                      '計算',
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '１日に必要なたんぱく質目安量',
                          style: TextStyle(fontSize: 20),
                        ),
                        FittedBox(
                          child: Text(
                            '${result}g',
                            style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
                            maxLines: 1,
                          ),
                        ),
                      ],
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

  Widget _pickerItem(String string) {
    return Text(
      string,
    );
  }
}
