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
      _onAdLoaded(id, onAdLoaded);
    }

    if (onAdFailedToLoad != null) {
      _onAdFailedToLoad(id, onAdFailedToLoad);
    }

    if (onImpression != null) {
      _onImpression(id, onImpression);
    }

    if (onAdClicked != null) {
      _onAdClicked(id, onAdClicked);
    }

    if (onLeftApplication != null) {
      _onLeftApplication(id, onLeftApplication);
    }

    if (onReturnedToApplication != null) {
      _onReturnedToApplication(id, onReturnedToApplication);
    }

    if (onAdShown != null) {
      _onAdShown(id, onAdShown);
    }

    if (onAdDismissed != null) {
      _onAdDismissed(id, onAdDismissed);
    }
  }

  final String id;
  late YandexAdsInterstitial interstitial;

  void _onAdLoaded(String id, Function callback) {
    interstitial.onAdLoaded(id).then((value) {
      _onAdLoaded(id, callback);

      callback();
    });
  }

  void _onAdFailedToLoad(String id, Function callback) {
    interstitial.onAdFailedToLoad(id).then((value) {
      _onAdFailedToLoad(id, callback);

      callback(value);
    });
  }

  void _onImpression(String id, Function callback) {
    interstitial.onImpression(id).then((value) {
      _onImpression(id, callback);

      callback(value);
    });
  }

  void _onAdClicked(String id, Function callback) {
    interstitial.onAdClicked(id).then((value) {
      _onAdClicked(id, callback);

      callback();
    });
  }

  void _onLeftApplication(String id, Function callback) {
    interstitial.onLeftApplication(id).then((value) {
      _onLeftApplication(id, callback);

      callback();
    });
  }

  void _onReturnedToApplication(String id, Function callback) {
    interstitial.onReturnedToApplication(id).then((value) {
      _onReturnedToApplication(id, callback);

      callback();
    });
  }

  void _onAdShown(String id, Function callback) {
    interstitial.onAdShown(id).then((value) {
      _onAdShown(id, callback);

      callback();
    });
  }

  void _onAdDismissed(String id, Function callback) {
    interstitial.onAdDismissed(id).then((value) {
      _onAdDismissed(id, callback);

      callback();
    });
  }

  void load() {
    interstitial.load(id);
  }

  void show() {
    interstitial.show(id);
  }
}
