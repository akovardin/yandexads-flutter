import Flutter
import UIKit

public class SwiftFlutterYandexAdsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger : FlutterBinaryMessenger = registrar.messenger()

    // api setup
    let api = YandexApi()
    YandexAdsApiSetup(messenger, api)
      
    let interstitial = YandexAdsInterstitialComponent()
    let reewarded = YandexAdsRewardedComponent()
    let banner = YandexAdsBannerComponent()
    let native = YandexAdsNativeComponent()

    // widgets
    registrar.register(YandexAdsBannerViewFactory(api: banner), withId: "yandex-ads-banner")
    registrar.register(YandexAdsNativeViewFactory(api: native), withId: "yandex-ads-native")

    // components
    YandexAdsInterstitialSetup(messenger, interstitial)
    YandexAdsRewardedSetup(messenger, reewarded)
    YandexAdsBannerSetup(messenger, banner)
    YandexAdsNativeSetup(messenger, native)

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
