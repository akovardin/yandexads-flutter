# flutter_yandex_ads

Yandex ADS for flutter applicaitions

[Donnations](https://www.tinkoff.ru/cf/6xz8n4h0LzO)

## Roadmap

Android
- [x] Banner
- [x] Interstitial
- [x] Native
- [x] Rewarded

iOS
- [x] Banner
- [x] Interstitial
- [x] Native
- [x] Rewarded


## Getting Started

Install package

```yaml
flutter_yandex_ads:
  git:
    url: https://gitflic.ru/project/kovardin/flutter-yandex-ads.git
```

For android add to AndroidManifest.xml

```xml

<uses-permission android:name="com.google.android.gms.permission.AD_ID" tools:node="remove"/>
```

For AdMob on android add this code:

```xml
<meta-data
   android:name="com.google.android.gms.ads.APPLICATION_ID"
   android:value="ca-app-pub-3940256099942544~1458002511"/>
```

where `ca-app-pub-3940256099942544~1458002511` is app id from admob

## Mediation

For AdMob mediation integration, add the following code on ios in to Info.plist:

```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-3940256099942544~1458002511</string>
```

For SKAdNetwork on ios add this code to Info.plist:

```xml
<key>SKAdNetworkItems</key>
<array>
<!-- Yandex Ads -->
<dict>
    <key>SKAdNetworkIdentifier</key>
    <string>zq492l623r.skadnetwork</string>
</dict>
<dict>
    <!-- AdMob -->
    <key>SKAdNetworkIdentifier</key>
    <string>cstr6suwn9.skadnetwork</string>
</dict>
<dict>
    <!-- MyTarget -->
    <key>SKAdNetworkIdentifier</key>
    <string>n9x2a789qt.skadnetwork</string>
</dict>
<dict>
    <!-- MyTarget -->
    <key>SKAdNetworkIdentifier</key>
    <string>r26jy69rpl.skadnetwork</string>
</dict>
<dict>
    <!-- Start.io -->
    <key>SKAdNetworkIdentifier</key>
    <string>5l3tpt7t6e.skadnetwork</string>
</dict>
<dict>
    <!-- UnityAds -->
    <key>SKAdNetworkIdentifier</key>
    <string>4dzt52r2t5.skadnetwork</string>
</dict>
<dict>
    <!-- IronSource -->
    <key>SKAdNetworkIdentifier</key>
    <string>su67r6k2v3.skadnetwork</string>
</dict>
<dict>
    <!-- Applovin -->
    <key>SKAdNetworkIdentifier</key>
    <string>ludvb6z3bs.skadnetwork</string>
</dict>
<dict>
    <!-- Mintegral -->
    <key>SKAdNetworkIdentifier</key>
    <string>KBD757YWX3.skadnetwork</string>
</dict>
</array>
```
And set for ios in Podfile

```
use_frameworks! :linkage => :static
```


Call initialization in main.dart

```
FlutterYandexAds.initialize();
```

### Banner

Create banner:

```
var banner = YandexAdsBannerComponent(
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
  ),
);

banner.load();
```

Create banner widget:

```
Container(
  height: 100,
  child: YandexAdsBannerWidget(
    banner: banner,
  ),
)
```

### Native

Create native widget:

```
Container(
  height: 100,
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
)
```

### Interstitial

Create interstitial component:

```
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
```

### Rewarded

Create rewarded component:

```
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
```
