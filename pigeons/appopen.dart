import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeons/appopen.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/ru/kovardin/flutter_yandex_ads/pigeons/appopen/Appopen.kt',
  kotlinOptions: KotlinOptions(
    package: 'ru.kovardin.flutter_yandex_ads.pigeons.appopen',
  ),
  dartPackageName: 'flutter_yandex_ads',
  swiftOut: 'ios/Classes/pigeons/Appopen.g.swift',
  swiftOptions: SwiftOptions(),
))
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
