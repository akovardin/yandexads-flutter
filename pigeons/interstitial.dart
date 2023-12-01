import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeons/interstitial.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/ru/kovardin/flutter_yandex_ads/pigeons/interstitial/Interstitial.kt',
  kotlinOptions: KotlinOptions(
    package: 'ru.kovardin.flutter_yandex_ads.pigeons.interstitial',
  ),
  dartPackageName: 'flutter_yandex_ads',
  swiftOut: 'ios/Classes/pigeons/Interstitial.g.swift',
  swiftOptions: SwiftOptions(),
))
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
