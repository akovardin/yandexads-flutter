import 'package:flutter_yandex_ads/pigeons/interstitial.dart';

class YandexAdsInterstitialComponent {
  YandexAdsInterstitialComponent({
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onImpression,
    Function? onAdClicked,
    Function? onLeftApplication,
    Function? onReturnedToApplication,
    Function? onAdShown,
    Function? onAdDismissed,
    required this.id,
  }) {
    interstitial = YandexAdsInterstitial();

    interstitial.make(id);

    if (onAdLoaded != null) {
      interstitial.onAdLoaded(id).then((value) {
        onAdLoaded();
      });
    }

    if (onAdFailedToLoad != null) {
      interstitial.onAdFailedToLoad(id).then((value) {
        onAdFailedToLoad(value);
      });
    }

    if (onImpression != null) {
      interstitial.onImpression(id).then((value) {
        onImpression(value);
      });
    }

    if (onAdClicked != null) {
      interstitial.onAdClicked(id).then((value) {
        onAdClicked();
      });
    }

    if (onLeftApplication != null) {
      interstitial.onLeftApplication(id).then((value) {
        onLeftApplication();
      });
    }

    if (onReturnedToApplication != null) {
      interstitial.onReturnedToApplication(id).then((value) {
        onReturnedToApplication();
      });
    }

    if (onAdShown != null) {
      interstitial.onAdShown(id).then((value) {
        onAdShown();
      });
    }

    if (onAdDismissed != null) {
      interstitial.onAdDismissed(id).then((value) {
        onAdDismissed();
      });
    }
  }

  final String id;
  late YandexAdsInterstitial interstitial;

  void load() {
    interstitial.load(id);
  }

  void show() {
    interstitial.show(id);
  }
}
