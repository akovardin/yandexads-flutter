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

  @async
  void onAdLoaded(String id);

  @async
  RewardedError onAdFailedToLoad(String id);

  @async
  RewardedError onAdFailedToShow(String id);

  @async
  void onAdShown(String id);

  @async
  void onAdDismissed(String id);

  @async
  void onAdClicked(String id);

  @async
  RewardedImpression onImpression(String id);

  @async
  RewardedEvent onRewarded(String id);
}
