import 'package:pigeon/pigeon.dart';

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
  void onAdShown(String id);

  @async
  void onAdDismissed(String id);

  @async
  void onAdClicked(String id);

  @async
  void onLeftApplication(String id);

  @async
  void onReturnedToApplication(String id);

  @async
  RewardedImpression onImpression(String id);

  @async
  RewardedEvent onRewarded(String id);
}
