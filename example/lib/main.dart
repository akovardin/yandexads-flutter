import 'package:flutter/material.dart';
import 'package:flutter_yandex_ads/components/banner.dart';
import 'package:flutter_yandex_ads/components/interstitial.dart';
import 'package:flutter_yandex_ads/components/rewarded.dart';
import 'package:flutter_yandex_ads/pigeons/banner.dart';
import 'package:flutter_yandex_ads/pigeons/interstitial.dart';
import 'package:flutter_yandex_ads/pigeons/rewarded.dart';
import 'package:flutter_yandex_ads/widgets/banner.dart';
import 'package:flutter_yandex_ads/widgets/native.dart';
import 'package:flutter_yandex_ads/yandex.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    FlutterYandexAds.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Yandex ADS'),
            ),
            bottomNavigationBar: const TabBar(
              tabs: [
                Tab(child: Text('Banner', style: TextStyle(color: Colors.black54, fontSize: 12))),
                Tab(child: Text('Interstitial', style: TextStyle(color: Colors.black54, fontSize: 12))),
                Tab(child: Text('Native', style: TextStyle(color: Colors.black54, fontSize: 12))),
                Tab(child: Text('Rewarded', style: TextStyle(color: Colors.black54, fontSize: 12))),
              ],
            ),
            body: const TabBarView(
              children: [
                BannerScreen(),
                InterstitialScreen(),
                NativeScreen(),
                RewardedScreen(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BannerScreen extends StatefulWidget {
  const BannerScreen({Key? key}) : super(key: key);

  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  late YandexAdsBannerComponent banner;

  @override
  void initState() {
    super.initState();

    banner = YandexAdsBannerComponent(
      width: 320,
      height: 100,
      id: 'R-M-DEMO-320x50',
      onAdLoaded: () {
        print('banner onAdLoaded');
      },
      onAdFailedToLoad: (BannerError err) {
        print('banner onAdFailedToLoad code: ${err.code}, description: ${err.description}');
      },
      onImpression: (BannerImpression? data) {
        print("banner onImpression ${data?.data}");
      },
      onAdClicked: () {
        print('banner onAdClicked');
      },
    );

    banner.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Banner'),
        SizedBox(
          height: 100,
          child: YandexAdsBannerWidget(
            banner: banner,
          ),
        ),
      ],
    );
  }
}

class NativeScreen extends StatefulWidget {
  const NativeScreen({Key? key}) : super(key: key);

  @override
  State<NativeScreen> createState() => _NativeScreenState();
}

class _NativeScreenState extends State<NativeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Native'),
        SizedBox(
          height: 300,
          child: YandexAdsNativeWidget(
            id: 'R-M-DEMO-native-i',
            onAdLoaded: () {
              print('native onAdLoaded');
            },
            onAdFailedToLoad: (BannerError err) {
              print('native onAdFailedToLoad code: ${err.code}, description: ${err.description}');
            },
            onImpression: (BannerImpression? data) {
              print("native onImpression ${data?.data}");
            },
            onAdClicked: () {
              print('native onAdClicked');
            },
          ),
        ),
      ],
    );
  }
}

class InterstitialScreen extends StatefulWidget {
  const InterstitialScreen({Key? key}) : super(key: key);

  @override
  _InterstitialScreenState createState() => _InterstitialScreenState();
}

class _InterstitialScreenState extends State<InterstitialScreen> {
  late YandexAdsInterstitialComponent interstitial;

  @override
  void initState() {
    super.initState();

    interstitial = YandexAdsInterstitialComponent(
      id: 'R-M-338238-18',
      onAdLoaded: () {
        print('interstitial onAdLoaded');
      },
      onAdFailedToLoad: (InterstitialError err) {
        print('interstitial onAdFailedToLoad code: ${err.code}, description: ${err.description}');
      },
      onAdDismissed: () {
        print("interstitial onAdDismissed");
      },
      onAdShown: () {
        print("interstitial onAdShown");
      },
      onImpression: (InterstitialImpression? data) {
        print('interstitial onImpression ${data?.data}');
      },
    );

    interstitial.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Interstitial'),
        ElevatedButton(
          onPressed: () {
            interstitial.show();
          },
          child: const Text('show'),
        ),
      ],
    );
  }
}

class RewardedScreen extends StatefulWidget {
  const RewardedScreen({Key? key}) : super(key: key);

  @override
  State<RewardedScreen> createState() => _RewardedScreenState();
}

class _RewardedScreenState extends State<RewardedScreen> {
  late YandexAdsRewardedComponent rewarded;

  @override
  void initState() {
    super.initState();

    rewarded = YandexAdsRewardedComponent(
        id: 'R-M-DEMO-rewarded-client-side-rtb',
        onAdLoaded: () {
          print('rewarded onAdLoaded');
        },
        onAdFailedToLoad: (InterstitialError err) {
          print('rewarded onAdFailedToLoad code: ${err.code}, description: ${err.description}');
        },
        onAdDismissed: () {
          print("rewarded onAdDismissed");
        },
        onAdShown: () {
          print("rewarded onAdShown");
        },
        onImpression: (RewardedImpression? data) {
          print('rewarded onImpression ${data?.data}');
        },
        onRewarded: (RewardedEvent? data) {
          print('rewarded onRewarded amount ${data?.amount}, type ${data?.type}');
        });

    rewarded.load();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Rewarded'),
        ElevatedButton(
          onPressed: () {
            rewarded.show();
          },
          child: const Text('show'),
        ),
      ],
    );
  }
}
