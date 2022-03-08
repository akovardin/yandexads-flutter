import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads/yandex.dart';

class YandexAdsBannerWidget extends StatelessWidget {
  YandexAdsBannerWidget({
    Key? key,
    Function? onAdLoaded,
    Function? onAdFailedToLoad,
    Function? onImpression,
    Function? onAdClicked,
    Function? onLeftApplication,
    Function? onReturnedToApplication,
    required this.id,
    required this.ads,
  }) : super(key: key) {
    if (onAdLoaded != null) {
      ads.setOnAdLoaded(id, onAdLoaded);
    }

    if (onAdFailedToLoad != null) {
      ads.setOnAdFailedToLoad(id, onAdFailedToLoad);
    }

    if (onImpression != null) {
      ads.setOnImpression(id, onImpression);
    }

    if (onAdClicked != null) {
      ads.setOnAdCLicked(id, onAdClicked);
    }

    if (onLeftApplication != null) {
      ads.setOnLeftApplication(id, onLeftApplication);
    }

    if (onReturnedToApplication != null) {
      ads.setOnReturnedToApplication(id, onReturnedToApplication);
    }
  }

  final String id;
  final FlutterYandexAds ads;

  Widget build(BuildContext context) {
    const String viewType = 'yandex-ads-banner';

    final Map<String, dynamic> creationParams = <String, dynamic>{
      'id': id,
    };

    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
