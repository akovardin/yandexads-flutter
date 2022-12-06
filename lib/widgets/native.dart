import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads/pigeons/native.dart';

class YandexAdsNativeWidget extends StatefulWidget {
  YandexAdsNativeWidget({
    Key? key,
    required this.id,
    this.onAdLoaded,
    this.onAdFailedToLoad,
    this.onImpression,
    this.onAdClicked,
    this.onLeftApplication,
    this.onReturnedToApplication,
    this.width = 0,
    this.height = 0,
  }) : super(key: key);

  final String id;
  final int width;
  final int height;
  Function? onAdLoaded;
  Function? onAdFailedToLoad;
  Function? onImpression;
  Function? onAdClicked;
  Function? onLeftApplication;
  Function? onReturnedToApplication;

  @override
  State<YandexAdsNativeWidget> createState() => _YandexAdsNativeWidgetState();
}

class _YandexAdsNativeWidgetState extends State<YandexAdsNativeWidget> {
  bool loaded = false;

  @override
  void initState() {
    var native = YandexAdsNative();

    native.make(widget.id);

    if (widget.onAdLoaded != null) {
      native.onAdLoaded(widget.id).then((value) {
        setState(() {
          loaded = true;
        });
        widget.onAdLoaded!();
      });
    }

    if (widget.onAdFailedToLoad != null) {
      native.onAdFailedToLoad(widget.id).then((value) {
        widget.onAdFailedToLoad!(value);
      });
    }

    if (widget.onImpression != null) {
      native.onImpression(widget.id).then((value) {
        widget.onImpression!(value);
      });
    }

    if (widget.onAdClicked != null) {
      native.onAdClicked(widget.id).then((value) {
        widget.onAdClicked!();
      });
    }

    if (widget.onLeftApplication != null) {
      native.onLeftApplication(widget.id).then((value) {
        widget.onLeftApplication!();
      });
    }

    if (widget.onReturnedToApplication != null) {
      native.onReturnedToApplication(widget.id).then((value) {
        widget.onReturnedToApplication!();
      });
    }

    native.load(widget.id, widget.width, widget.height);
  }

  Widget build(BuildContext context) {
    const String viewType = 'yandex-ads-native';

    final Map<String, dynamic> creationParams = <String, dynamic>{
      'id': widget.id,
    };

    if (!loaded) {
      return const Text("loading..");
    } else {
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
}
