import 'package:flutter_yandex_ads/pigeons/yandex.dart';

class FlutterYandexAds {
  final api = YandexAdsApi();

  void initialize() {
    api.initialize();
  }

  void setOnAdLoaded(String id, String type, Function onAdLoaded) {
    api.onAdLoaded(EventRequest(id: id, name: 'onAdLoaded', type: type)).then((value) {
      onAdLoaded();
    });
  }

  void setOnAdFailedToLoad(String id, String type, Function onAdFailedToLoad) {
    api.onAdFailedToLoad(EventRequest(id: id, name: 'onAdFailedToLoad', type: type)).then((value) {
      onAdFailedToLoad(AdLoadError(
        code: value.code ?? 0,
        description: value.description ?? '',
      ));
    });
  }

  void setOnImpression(String id, String type, Function onImpression) {
    api.onImpression(EventRequest(id: id, name: 'onImpression', type: type)).then((value) {
      onImpression(value.data);
    });
  }

  void setOnAdCLicked(String id, String type, Function onAdClicked) {
    api.onAdClicked(EventRequest(id: id, name: 'onAdClicked', type: type)).then((value) {
      onAdClicked();
    });
  }

  void setOnLeftApplication(String id, String type, Function onLeftApplication) {
    api.onLeftApplication(EventRequest(id: id, name: 'onLeftApplication', type: type)).then((value) {
      onLeftApplication();
    });
  }

  void setOnReturnedToApplication(String id, String type, Function onReturnedToApplication) {
    api.onReturnedToApplication(EventRequest(id: id, name: 'onReturnedToApplication', type: type)).then((value) {
      onReturnedToApplication();
    });
  }
}

class AdLoadError {
  final int code;
  final String description;

  AdLoadError({required this.code, required this.description});
}

class EventTypes {
  static final BANNER = 'banner';
  static final INTERSTITIAL = 'interstitial';
  static final NATIVE = 'native';
  static final REWARDED = 'rewarded';
}
