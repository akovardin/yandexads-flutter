import 'package:flutter_yandex_ads/pigeons/interstitial.dart';
import 'package:flutter_yandex_ads/yandex.dart';

class YandexAdsIntersttialComponents {
  YandexAdsIntersttialComponents({
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onImpression,
    Function? onAdClicked,
    Function? onLeftApplication,
    Function? onReturnedToApplication,
    required this.id,
    required this.ads,
  }) {
    interstitial = YandexAdsInterstitial();
    interstitial.config(id);

    if (onAdLoaded != null) {
      ads.setOnAdLoaded(id, EventTypes.INTERSTITIAL, onAdLoaded);
    }

    if (onAdFailedToLoad != null) {
      ads.setOnAdFailedToLoad(id, EventTypes.INTERSTITIAL, onAdFailedToLoad);
    }
  }

  final String id;
  final FlutterYandexAds ads;
  late YandexAdsInterstitial interstitial;

  void load() {
    interstitial.load();
  }

  void show() {
    interstitial.show();
  }
}
