import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/admob.dart';
import 'package:protein_log/pages/intake_calculation_page.dart';

class GoalPage extends StatefulWidget {
  GoalPage(this.goal, {Key? key}) : super(key: key);
  final int goal;

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  TextEditingController otherController = TextEditingController();

  @override
  void initState() {
    super.initState();
    otherController = new TextEditingController(text: widget.goal.toString());
  }

  @override
  Widget build(BuildContext context) {
    int goal = int.parse(otherController.text);
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
        Navigator.pop(context, widget.goal);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('目標値設定'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, goal);
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text('完了'),
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Center(
              child: SizedBox(
                height: 100,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.red,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  '目標値',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
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
                                    controller: otherController,
                                    textAlign: TextAlign.center,
                                    maxLength: 3,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                    decoration: InputDecoration(counterText: ''),
                                    onChanged: (text) {
                                      if (text.length > 0) {
                                        setState(() {});
                                      } else {
                                        setState(() {
                                          this.otherController = TextEditingController(text: '0');
                                        });
                                      }
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
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IntakeCalculationPage(),
                  ),
                );
              },
              child: Text('たんぱく質目安計算'),
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
