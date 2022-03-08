import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_yandex_ads/widgets/banner.dart';
import 'package:flutter_yandex_ads/yandex.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterYandexAds ads = new FlutterYandexAds();

  @override
  void initState() {
    super.initState();
    ads.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Yandex ADS'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Banner'),
            Container(
              height: 100,
              child: YandexAdsBannerWidget(
                ads: ads,
                // id: 'R-M-1582183-1',
                id: 'R-M-DEMO-320x50',
                onAdLoaded: () {
                  print('onAdLoaded');
                },
                onAdFailedToLoad: (AdLoadError err) {
                  print('onAdFailedToLoad code: ${err.code}, description: ${err.description}');
                },
                onImpression: (String? data) {
                  print("on ad impression ${data ?? ''}");
                },
                onAdClicked: () {
                  print('onAdClicked');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
