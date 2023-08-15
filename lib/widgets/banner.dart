import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads/components/banner.dart';

class YandexAdsBannerWidget extends StatelessWidget {
  YandexAdsBannerWidget({
    Key? key,
    required this.banner,
  });

  final YandexAdsBannerComponent banner;

  Widget build(BuildContext context) {
    const String viewType = 'yandex-ads-banner';

    final Map<String, dynamic> creationParams = <String, dynamic>{
      'id': this.banner.id,
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
