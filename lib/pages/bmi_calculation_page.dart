import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/admob.dart';
import 'package:protein_log/model/bmi_formula.dart';

class BmiCalculationPage extends StatefulWidget {
  const BmiCalculationPage({Key? key}) : super(key: key);

  @override
  State<BmiCalculationPage> createState() => _BmiCalculationPageState();
}

class _BmiCalculationPageState extends State<BmiCalculationPage> {
  int height = 170;
  int weight = 60;
  String bmi = '0';
  String standardWeight = '0';
  String lowWeight = '0';
  String highWeight = '0';

  @override
  Widget build(BuildContext context) {
    final adHeight = MediaQuery.of(context).size.height;
    final BannerAd myBanner = BannerAd(
      adUnitId: AdMob().getBannerAdUnitId(),
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();

    return Scaffold(
      appBar: AppBar(
        title: Text('BMI計算'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('BMIとは'),
                    content: Column(
                      children: [
                        Text(
                          'BMI(Body Mass Index)はボディマス指数と呼ばれ、体重と身長から算出される肥満度を表す体格指数です。',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 5),
                        Text(
                          'BMIは健康を基準とした体重であり、統計上、糖尿病・高血圧・高脂血症などの疾患にかかりにくいとされる指数値です。そのため、普通体重だと見た目、やや太って見えることがあります。ファッション体重を目指すのなら、19をめやすにすると良いようです。18.5未満は、痩せすぎですのでお気を付け下さい。ダイエットをするときは、健康には十分お気をつけ下さい。',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '適正体重',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '日本肥満学会では、BMIが22を適正体重(標準体重)とし、統計的に最も病気になりにくい体重とされています。25以上を肥満、18.5未満を低体重と分類しています。',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '日本での評価',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: DataTable(
                            dataRowHeight: 25,
                            columns: [
                              DataColumn(
                                label: Text('BMI'),
                              ),
                              DataColumn(
                                label: Text('判定'),
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(Text('18.5未満')),
                                  DataCell(Text('低体重')),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text('18.5~25未満')),
                                  DataCell(Text('普通体重')),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text('25~30未満')),
                                  DataCell(Text('肥満(1度)')),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text('30~35未満')),
                                  DataCell(Text('肥満(2度)')),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text('35~40未満')),
                                  DataCell(Text('肥満(3度)')),
                                ],
                              ),
                              DataRow(
                                cells: [
                                  DataCell(Text('40以上')),
                                  DataCell(Text('肥満(4度)')),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('身長'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    height--;
                                  });
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 35,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    height.toString(),
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text('cm')
                                ],
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    height++;
                                  });
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              child: CupertinoSlider(
                                value: height.toDouble(),
                                min: 120.0,
                                max: 220.0,
                                onChanged: (value) {
                                  setState(() {
                                    height = value.toInt();
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
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
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  size: 35,
                                ),
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
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  size: 35,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
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
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 45.0),
                      child: Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            BmiFormula calc = BmiFormula(
                              height: height,
                              weight: weight,
                            );
                            setState(() {
                              bmi = calc.resultBmi()!;
                              standardWeight = calc.resultStandardWeight()!;
                              lowWeight = calc.resultLowWeight()!;
                              highWeight = calc.resultHighWeight()!;
                            });
                          },
                          child: FittedBox(
                            child: Text(
                              '計算',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('BMI'),
                                Text(
                                  bmi,
                                  style: TextStyle(fontSize: 30),
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('適正体重'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      standardWeight,
                                      style: TextStyle(fontSize: 30),
                                    ),
                                    Text('kg'),
                                  ],
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('普通体重範囲'),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          lowWeight,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          'kg以上',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          highWeight,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          'kg未満',
                                          style: TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: adHeight * 0.06,
            child: AdWidget(ad: myBanner),
          ),
        ],
      ),
    );
  }
}
