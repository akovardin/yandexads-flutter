import 'package:flutter_yandex_ads/pigeons/interstitial.dart';
import 'package:flutter_yandex_ads/yandex.dart';

class YandexAdsInterstitialComponent {
  YandexAdsInterstitialComponent({
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onAdFailedToShow,
    Function? onImpression,
    Function? onAdClicked,
    Function? onAdShown,
    Function? onAdDismissed,
    required this.id,
  }) {
    interstitial = YandexAdsInterstitial();

    FlutterYandexAds.addInterstitial(
      id,
      YandexAdsInterstitialCallbacks(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: onAdFailedToLoad,
        onAdFailedToShow: onAdFailedToShow,
        onImpression: onImpression,
        onAdClicked: onAdClicked,
        onAdShown: onAdShown,
        onAdDismissed: onAdDismissed,
      ),
    );

    interstitial.make(id);
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

class FlutterYandexAdsInterstitialCallbacks implements FlutterYandexAdsInterstitial {
  @override
  void onAdClicked(String id) {
    final callbacks = FlutterYandexAds.getInterstitial(id);
    if (callbacks?.onAdClicked != null) {
      callbacks?.onAdClicked!();
    }
  }

  @override
  void onAdDismissed(String id) {
    final callbacks = FlutterYandexAds.getInterstitial(id);
    if (callbacks?.onAdDismissed != null) {
      callbacks?.onAdDismissed!();
    }
  }

  @override
  void onAdFailedToLoad(String id, InterstitialError err) {
    final callbacks = FlutterYandexAds.getInterstitial(id);
    if (callbacks?.onAdFailedToLoad != null) {
      callbacks?.onAdFailedToLoad!(err);
    }
  }

  @override
  void onAdFailedToShow(String id, InterstitialError err) {
    final callbacks = FlutterYandexAds.getInterstitial(id);
    if (callbacks?.onAdFailedToShow != null) {
      callbacks?.onAdFailedToShow!(err);
    }
  }

  @override
  void onAdLoaded(String id) {
    final callbacks = FlutterYandexAds.getInterstitial(id);
    if (callbacks?.onAdLoaded != null) {
      callbacks?.onAdLoaded!();
    }
  }

  @override
  void onAdShown(String id) {
    final callbacks = FlutterYandexAds.getInterstitial(id);
    if (callbacks?.onAdShown != null) {
      callbacks?.onAdShown!();
    }
  }

  @override
  void onImpression(String id, InterstitialImpression data) {
    final callbacks = FlutterYandexAds.getInterstitial(id);
    if (callbacks?.onImpression != null) {
      callbacks?.onImpression!(data);
    }
  }
}
