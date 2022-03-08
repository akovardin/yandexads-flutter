import 'package:flutter_yandex_ads/pigeons/yandex.dart';

class FlutterYandexAds {
  final api = YandexAdsApi();

  void initialize() {
    api.initialize();
  }

  void setOnAdLoaded(String id, Function onAdLoaded) {
    api.onAdLoaded(EventRequest(id: id, name: 'onAdLoaded')).then((value) {
      onAdLoaded();
    });
  }

  void setOnAdFailedToLoad(String id, Function onAdFailedToLoad) {
    api.onAdFailedToLoad(EventRequest(id: id, name: 'onAdFailedToLoad')).then((value) {
      onAdFailedToLoad(AdLoadError(
        code: value.code ?? 0,
        description: value.description ?? '',
      ));
    });
  }

  void setOnImpression(String id, Function onImpression) {
    api.onImpression(EventRequest(id: id, name: 'onImpression')).then((value) {
      onImpression(value.data);
    });
  }

  void setOnAdCLicked(String id, Function onAdClicked) {
    api.onAdClicked(EventRequest(id: id, name: 'onAdClicked')).then((value) {
      onAdClicked();
    });
  }

  void setOnLeftApplication(String id, Function onLeftApplication) {
    api.onLeftApplication(EventRequest(id: id, name: 'onLeftApplication')).then((value) {
      onLeftApplication();
    });
  }

  void setOnReturnedToApplication(String id, Function onReturnedToApplication) {
    api.onReturnedToApplication(EventRequest(id: id, name: 'onReturnedToApplication')).then((value) {
      onReturnedToApplication();
    });
  }
}

class AdLoadError {
  final int code;
  final String description;

  AdLoadError({required this.code, required this.description});
}
