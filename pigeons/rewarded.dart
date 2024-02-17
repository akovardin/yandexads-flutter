import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeons/rewarded.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/ru/kovardin/flutter_yandex_ads/pigeons/rewarded/Rewarded.kt',
  kotlinOptions: KotlinOptions(
    package: 'ru.kovardin.flutter_yandex_ads.pigeons.rewarded',
  ),
  dartPackageName: 'flutter_yandex_ads',
  swiftOut: 'ios/Classes/pigeons/Rewarded.g.swift',
  swiftOptions: SwiftOptions(),
))
class RewardedError {
  late int code;
  late String description;
}

class RewardedImpression {
  late String data;
}

class RewardedEvent {
  late int amount;
  late String type;
}

@HostApi()
abstract class YandexAdsRewarded {
  void make(String id);

  void load(String id);

  void show(String id);
}

@FlutterApi()
abstract class FlutterYandexAdsRewarded {
  void onAdLoaded(String id);

  void onAdFailedToLoad(String id, RewardedError err);

  void onAdFailedToShow(String id, RewardedError err);

  void onAdShown(String id);

  void onAdDismissed(String id);

  void onAdClicked(String id);

  void onImpression(String id, RewardedImpression data);

  void onRewarded(String id, RewardedEvent reward);
}
