import 'dart:io';

class AdMob {
  // void id() async {
  //   await MobileAds.instance.initialize();
  //   final requestConfiguration = RequestConfiguration(
  //     testDeviceIds: ['id code,id code'],
  //   );
  //   await MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  // }

  String getBannerAdUnitId() {
    String bannerUnitId = '';
    // iOSとAndroidで広告ユニットIDを分岐させる
    if (Platform.isAndroid) {
      // Androidの広告ユニットID
      // bannerUnitId = 'ca-app-pub-6583499550754592/9410554180';
      //テスト用
      bannerUnitId = 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      // iOSの広告ユニットID
      // bannerUnitId = 'ca-app-pub-6583499550754592/3548725559';
      //テスト用
      bannerUnitId = 'ca-app-pub-3940256099942544/2934735716';
    }
    return bannerUnitId;
  }
}
