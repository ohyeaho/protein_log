import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:protein_log/model/admob.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? proteinName;

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
        title: Text('項目の追加'),
        actions: [
          TextButton(
            onPressed: () {
              if (proteinName != null) {
                Navigator.pop(context, proteinName);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text('完了'),
            style: TextButton.styleFrom(primary: Colors.white),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Center(
            child: Card(
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: double.infinity,
                height: 80,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: '項目名を入力'),
                        onChanged: (text) {
                          if (text.isNotEmpty) {
                            setState(() {
                              proteinName = text;
                            });
                          } else {
                            setState(() {
                              proteinName = null;
                            });
                          }
                        },
                      ),
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
    );
  }
}
