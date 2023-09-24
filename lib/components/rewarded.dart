import 'package:flutter_yandex_ads/pigeons/rewarded.dart';

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

    rewarded.make(id);

    if (onAdLoaded != null) {
      _onAdLoaded(id, onAdLoaded);
    }

    if (onAdFailedToLoad != null) {
      _onAdFailedToLoad(id, onAdFailedToLoad);
    }

    if (onAdFailedToShow != null) {
      _onAdFailedToShow(id, onAdFailedToShow);
    }

    if (onImpression != null) {
      _onImpression(id, onImpression);
    }

    if (onAdClicked != null) {
      _onAdClicked(id, onAdClicked);
    }

    if (onAdShown != null) {
      _onAdShown(id, onAdShown);
    }

    if (onAdDismissed != null) {
      _onAdDismissed(id, onAdDismissed);
    }

    if (onRewarded != null) {
      _onRewarded(id, onRewarded);
    }
  }

  void _onAdLoaded(String id, Function callback) {
    rewarded.onAdLoaded(id).then((value) {
      _onAdLoaded(id, callback);

      callback();
    });
  }

  void _onAdFailedToLoad(String id, Function callback) {
    rewarded.onAdFailedToLoad(id).then((value) {
      _onAdFailedToLoad(id, callback);

      callback(value);
    });
  }

  void _onAdFailedToShow(String id, Function callback) {
    rewarded.onAdFailedToShow(id).then((value) {
      _onAdFailedToShow(id, callback);

      callback(value);
    });
  }

  void _onImpression(String id, Function callback) {
    rewarded.onImpression(id).then((value) {
      _onImpression(id, callback);

      callback(value);
    });
  }

  void _onAdClicked(String id, Function callback) {
    rewarded.onAdClicked(id).then((value) {
      _onAdClicked(id, callback);

      callback();
    });
  }

  void _onAdShown(String id, Function callback) {
    rewarded.onAdShown(id).then((value) {
      _onAdShown(id, callback);

      callback();
    });
  }

  void _onAdDismissed(String id, Function callback) {
    rewarded.onAdDismissed(id).then((value) {
      _onAdDismissed(id, callback);

      callback();
    });
  }

  void _onRewarded(String id, Function callback) {
    rewarded.onRewarded(id).then((value) {
      _onRewarded(id, callback);

      callback(value);
    });
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
