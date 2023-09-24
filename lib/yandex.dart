import 'package:flutter_yandex_ads/components/appopen.dart';
import 'package:flutter_yandex_ads/components/interstitial.dart';
import 'package:flutter_yandex_ads/pigeons/appopen.dart';
import 'package:flutter_yandex_ads/pigeons/interstitial.dart';
import 'package:flutter_yandex_ads/pigeons/yandex.dart';

class FlutterYandexAds {
  static Map<String, YandexAdsAppOpenCallbacks> appopens = {};
  static Map<String, YandexAdsInterstitialCallbacks> interstitials = {};

  static void initialize() {
    YandexAdsApi().initialize();

    FlutterYandexAdsAppOpen.setup(FlutterYandexAdsAppOpenCallbacks());
    FlutterYandexAdsInterstitial.setup(FlutterYandexAdsInterstitialCallbacks());
  }

  static void addAppOpen(String id, YandexAdsAppOpenCallbacks callbacks) {
    appopens[id] = callbacks;
  }

  static YandexAdsAppOpenCallbacks? getAppOpen(String id) {
    return appopens[id];
  }

  static void addInterstitial(String id, YandexAdsInterstitialCallbacks callbacks) {
    interstitials[id] = callbacks;
  }

  static YandexAdsInterstitialCallbacks? getInterstitial(String id) {
    return interstitials[id];
  }
}

class YandexAdsAppOpenCallbacks {
  YandexAdsAppOpenCallbacks({
    required this.onAdLoaded,
    required this.onAdFailedToLoad,
    required this.onAdFailedToShow,
    required this.onImpression,
    required this.onAdClicked,
    required this.onAdShown,
    required this.onAdDismissed,
  });

  Function? onAdLoaded;
  Function? onAdFailedToLoad;
  Function? onAdFailedToShow;
  Function? onImpression;
  Function? onAdClicked;
  Function? onAdShown;
  Function? onAdDismissed;
}

class YandexAdsInterstitialCallbacks {
  YandexAdsInterstitialCallbacks({
    required this.onAdLoaded,
    required this.onAdFailedToLoad,
    required this.onAdFailedToShow,
    required this.onImpression,
    required this.onAdClicked,
    required this.onAdShown,
    required this.onAdDismissed,
  });

  Function? onAdLoaded;
  Function? onAdFailedToLoad;
  Function? onAdFailedToShow;
  Function? onImpression;
  Function? onAdClicked;
  Function? onAdShown;
  Function? onAdDismissed;
}
