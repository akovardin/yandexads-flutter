
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_yandex_ads/pigeons/yandex.dart';
import 'package:flutter_yandex_ads/widgets/banner.dart';

class FlutterYandexAds {

  static void initialize() {
    (new YandexAdsApi()).initialize();
  }
}
