import 'package:pigeon/pigeon.dart';

class InterstitialError {
  late int code;
  late String description;
}

class InterstitialImpression {
  late String data;
}

@HostApi()
abstract class YandexAdsInterstitial {
  void make(String id);

  void load(String id);

  void show(String id);
}

@FlutterApi()
abstract class FlutterYandexAdsInterstitial {
  void onAdLoaded(String id);

  void onAdFailedToLoad(String id, InterstitialError err);

  void onAdFailedToShow(String id, InterstitialError err);

  void onAdShown(String id);

  void onAdDismissed(String id);

  void onAdClicked(String id);

  void onImpression(String id, InterstitialImpression data);
}
