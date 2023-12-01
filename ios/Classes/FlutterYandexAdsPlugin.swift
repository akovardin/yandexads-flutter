import Flutter
import UIKit

public class FlutterYandexAdsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
      let messenger : FlutterBinaryMessenger = registrar.messenger()

      // api setup
      let api = YandexApi()
      YandexAdsApiSetup.setUp(binaryMessenger: messenger, api: api)

      let interstitial = YandexAdsInterstitialComponent(callbacks: FlutterYandexAdsInterstitial(binaryMessenger: messenger))
      let rewarded = YandexAdsRewardedComponent()
      let banner = YandexAdsBannerComponent()
      let native = YandexAdsNativeComponent()

      // widgets
      registrar.register(YandexAdsBannerViewFactory(api: banner), withId: "yandex-ads-banner")
      registrar.register(YandexAdsNativeViewFactory(api: native), withId: "yandex-ads-native")

      // components
      YandexAdsInterstitialSetup.setUp(binaryMessenger: messenger, api: interstitial)
      YandexAdsRewardedSetup.setUp(binaryMessenger: messenger, api: rewarded)
      YandexAdsBannerSetup.setUp(binaryMessenger: messenger, api: banner)
      YandexAdsNativeSetup.setUp(binaryMessenger: messenger, api: native)

    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      result("iOS " + UIDevice.current.systemVersion)
    }
}
