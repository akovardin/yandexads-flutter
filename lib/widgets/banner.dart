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
    banner = YandexAdsBanner();

    banner.make(id, width, height);

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

    banner.load(id);
  }

  final String id;
  final int width;
  final int height;
  late YandexAdsBanner banner;

  void _onAdLoaded(String id, Function callback) {
    banner.onAdLoaded(id).then((value) {
      _onAdLoaded(id, callback);

      callback();
    });
  }

  void _onAdFailedToLoad(String id, Function callback) {
    banner.onAdFailedToLoad(id).then((value) {
      _onAdFailedToLoad(id, callback);

      callback(value);
    });
  }

  void _onImpression(String id, Function callback) {
    banner.onImpression(id).then((value) {
      _onImpression(id, callback);

      callback(value);
    });
  }

  void _onAdClicked(String id, Function callback) {
    banner.onAdClicked(id).then((value) {
      _onAdClicked(id, callback);

      callback();
    });
  }

  void _onLeftApplication(String id, Function callback) {
    banner.onLeftApplication(id).then((value) {
      _onLeftApplication(id, callback);

      callback();
    });
  }

  void _onReturnedToApplication(String id, Function callback) {
    banner.onReturnedToApplication(id).then((value) {
      _onReturnedToApplication(id, callback);

      callback();
    });
  }

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
