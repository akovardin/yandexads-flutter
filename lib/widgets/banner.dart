import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads/pigeons/banner.dart';

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
    required this.width,
    required this.height,
  }) : super(key: key) {
    var banner = YandexAdsBanner();

    banner.make(id, width, height);

    if (onAdLoaded != null) {
      banner.onAdLoaded(id).then((value) {
        onAdLoaded();
      });
    }

    if (onAdFailedToLoad != null) {
      banner.onAdFailedToLoad(id).then((value) {
        onAdFailedToLoad(value);
      });
    }

    if (onImpression != null) {
      banner.onImpression(id).then((value) {
        onImpression(value);
      });
    }

    if (onAdClicked != null) {
      banner.onAdClicked(id).then((value) {
        onAdClicked();
      });
    }

    if (onLeftApplication != null) {
      banner.onLeftApplication(id).then((value) {
        onLeftApplication();
      });
    }

    if (onReturnedToApplication != null) {
      banner.onReturnedToApplication(id).then((value) {
        onReturnedToApplication();
      });
    }

    banner.load(id);
  }

  final String id;
  final int width;
  final int height;

  Widget build(BuildContext context) {
    const String viewType = 'yandex-ads-banner';

    final Map<String, dynamic> creationParams = <String, dynamic>{
      'id': id,
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      case TargetPlatform.iOS:
        return UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        );
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }
}
