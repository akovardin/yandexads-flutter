import 'package:pigeon/pigeon.dart';

class AppOpenError {
  late int code;
  late String description;
}

class AppOpenImpression {
  late String data;
}

@HostApi()
abstract class YandexAdsAppOpen {
  void make(String id);
}

@FlutterApi()
abstract class FlutterYandexAdsAppOpen {
  void onAdLoaded(String id);

  void onAdFailedToLoad(String id, AppOpenError err);

  void onAdFailedToShow(String id, AppOpenError err);

  void onAdShown(String id);

  void onAdDismissed(String id);

  void onAdClicked(String id);

  void onImpression(String id, AppOpenImpression data);
}
