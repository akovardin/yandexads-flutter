import 'package:flutter_yandex_ads/pigeons/rewarded.dart';

class YandexAdsRewardedComponent {
  YandexAdsRewardedComponent({
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onImpression,
    Function? onAdClicked,
    Function? onLeftApplication,
    Function? onReturnedToApplication,
    Function? onAdShown,
    Function? onAdDismissed,
    Function? onRewarded,
    required this.id,
  }) {
    rewarded = YandexAdsRewarded();

    rewarded.make(id);

    if (onAdLoaded != null) {
      rewarded.onAdLoaded(id).then((value) {
        onAdLoaded();
      });
    }

    if (onAdFailedToLoad != null) {
      rewarded.onAdFailedToLoad(id).then((value) {
        onAdFailedToLoad(value);
      });
    }

    if (onImpression != null) {
      rewarded.onImpression(id).then((value) {
        onImpression(value);
      });
    }

    if (onAdClicked != null) {
      rewarded.onAdClicked(id).then((value) {
        onAdClicked();
      });
    }

    if (onLeftApplication != null) {
      rewarded.onLeftApplication(id).then((value) {
        onLeftApplication();
      });
    }

    if (onReturnedToApplication != null) {
      rewarded.onReturnedToApplication(id).then((value) {
        onReturnedToApplication();
      });
    }

    if (onAdShown != null) {
      rewarded.onAdShown(id).then((value) {
        onAdShown();
      });
    }

    if (onAdDismissed != null) {
      rewarded.onAdDismissed(id).then((value) {
        onAdDismissed();
      });
    }

    if (onRewarded != null) {
      rewarded.onRewarded(id).then((value) {
        onRewarded(value);
      });
    }
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
