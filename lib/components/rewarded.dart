import 'package:flutter_yandex_ads/pigeons/rewarded.dart';
import 'package:flutter_yandex_ads/yandex.dart';

class YandexAdsRewardedComponent {
  YandexAdsRewardedComponent({
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onAdFailedToShow,
    Function? onImpression,
    Function? onAdClicked,
    Function? onAdShown,
    Function? onAdDismissed,
    Function? onRewarded,
    required this.id,
  }) {
    rewarded = YandexAdsRewarded();

    FlutterYandexAds.addRewarded(
      id,
      YandexAdsRewardedCallbacks(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
        onAdFailedToShow: onAdFailedToShow,
        onImpression: onImpression,
        onAdClicked: onAdClicked,
        onAdShown: onAdShown,
        onAdDismissed: onAdDismissed,
        onReward: onRewarded,
      ),
    );

    rewarded.make(id);
  }

  final String id;
  late YandexAdsRewarded rewarded;

  void load() {
    rewarded.load(id);
  }

  void show() {
    rewarded.show(id);
  }
}

class FlutterYandexAdsRewardedCallbacks implements FlutterYandexAdsRewarded {
  @override
  void onAdClicked(String id) {
    final callbacks = FlutterYandexAds.getRewarded(id);
    if (callbacks?.onAdClicked != null) {
      callbacks?.onAdClicked!();
    }
  }

  @override
  void onAdDismissed(String id) {
    final callbacks = FlutterYandexAds.getRewarded(id);
    if (callbacks?.onAdDismissed != null) {
      callbacks?.onAdDismissed!();
    }
  }

  @override
  void onAdFailedToLoad(String id, RewardedError err) {
    final callbacks = FlutterYandexAds.getRewarded(id);
    if (callbacks?.onAdFailedToLoad != null) {
      callbacks?.onAdFailedToLoad!(err);
    }
  }

  @override
  void onAdFailedToShow(String id, RewardedError err) {
    final callbacks = FlutterYandexAds.getRewarded(id);
    if (callbacks?.onAdFailedToShow != null) {
      callbacks?.onAdFailedToShow!(err);
    }
  }

  @override
  void onAdLoaded(String id) {
    final callbacks = FlutterYandexAds.getRewarded(id);
    if (callbacks?.onAdLoaded != null) {
      callbacks?.onAdLoaded!();
    }
  }

  @override
  void onAdShown(String id) {
    final callbacks = FlutterYandexAds.getRewarded(id);
    if (callbacks?.onAdShown != null) {
      callbacks?.onAdShown!();
    }
  }

  @override
  void onImpression(String id, RewardedImpression data) {
    final callbacks = FlutterYandexAds.getRewarded(id);
    if (callbacks?.onImpression != null) {
      callbacks?.onImpression!(data);
    }
  }

  @override
  void onRewarded(String id, RewardedEvent reward) {
    final callbacks = FlutterYandexAds.getRewarded(id);
    if (callbacks?.onImpression != null) {
      callbacks?.onReward!(reward);
    }
  }
}
