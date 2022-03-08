import Flutter
import UIKit

public class SwiftFlutterYandexAdsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let messenger : FlutterBinaryMessenger = registrar.messenger()

    // api setup
    let api : YandexAdsApi & NSObjectProtocol = YandexApi()
    YandexAdsApiSetup(messenger, api)

    // widgets
    registrar.register(YandexAdsBanner(messenger: messenger), withId: "yandex-ads-banner")

    // components
    // todo
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
