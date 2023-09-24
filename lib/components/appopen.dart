import 'package:flutter_yandex_ads/pigeons/appopen.dart';
import 'package:flutter_yandex_ads/yandex.dart';

class YandexAdsAppOpenComponent {
  YandexAdsAppOpenComponent({
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onAdFailedToShow,
    Function? onImpression,
    Function? onAdClicked,
    Function? onAdShown,
    Function? onAdDismissed,
    required this.id,
  }) {
    appopen = YandexAdsAppOpen();

    FlutterYandexAds.addAppOpen(
        id,
        YandexAdsAppOpenCallbacks(
          onAdLoaded: onAdLoaded,
          onAdFailedToLoad: onAdFailedToLoad,
          onAdFailedToShow: onAdFailedToShow,
          onImpression: onImpression,
          onAdClicked: onAdClicked,
          onAdShown: onAdShown,
          onAdDismissed: onAdDismissed,
        ));

    appopen.make(id);
  }

  final String id;
  late YandexAdsAppOpen appopen;
}

class FlutterYandexAdsAppOpenCallbacks implements FlutterYandexAdsAppOpen {
  @override
  void onAdClicked(String id) {
    final callbacks = FlutterYandexAds.getAppOpen(id);
    if (callbacks?.onAdClicked != null) {
      callbacks?.onAdClicked!();
    }
  }

  @override
  void onAdDismissed(String id) {
    final callbacks = FlutterYandexAds.getAppOpen(id);
    if (callbacks?.onAdDismissed != null) {
      callbacks?.onAdDismissed!();
    }
  }

  @override
  void onAdFailedToLoad(String id, AppOpenError err) {
    final callbacks = FlutterYandexAds.getAppOpen(id);
    if (callbacks?.onAdFailedToLoad != null) {
      callbacks?.onAdFailedToLoad!(err);
    }
  }

  @override
  void onAdFailedToShow(String id, AppOpenError err) {
    final callbacks = FlutterYandexAds.getAppOpen(id);
    if (callbacks?.onAdFailedToShow != null) {
      callbacks?.onAdFailedToShow!(err);
    }
  }

  @override
  void onAdLoaded(String id) {
    final callbacks = FlutterYandexAds.getAppOpen(id);
    if (callbacks?.onAdLoaded != null) {
      callbacks?.onAdLoaded!();
    }
  }

  @override
  void onAdShown(String id) {
    final callbacks = FlutterYandexAds.getAppOpen(id);
    if (callbacks?.onAdShown != null) {
      callbacks?.onAdShown!();
    }
  }

  @override
  void onImpression(String id, AppOpenImpression data) {
    final callbacks = FlutterYandexAds.getAppOpen(id);
    if (callbacks?.onImpression != null) {
      callbacks?.onImpression!();
    }
  }
}
