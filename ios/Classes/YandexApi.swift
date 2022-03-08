import Flutter
import UIKit

class YandexApi: NSObject, YandexAdsApi {
    func initializeWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
    }

    func onAdLoadedRequest(_ request: EventRequest?, completion: @escaping (EventResponse?, FlutterError?) -> Void) {
    }

    func onAdFailed(toLoad request: EventRequest?, completion: @escaping (EventResponse?, FlutterError?) -> Void) {
    }

    func onImpressionRequest(_ request: EventRequest?, completion: @escaping (EventResponse?, FlutterError?) -> Void) {
    }


    func onAdClickedRequest(_ request: EventRequest?, completion: @escaping (EventResponse?, FlutterError?) -> Void) {
    }

    func onLeftApplicationRequest(_ request: EventRequest?, completion: @escaping (EventResponse?, FlutterError?) -> Void) {
    }

    func onReturned(toApplicationRequest request: EventRequest?, completion: @escaping (EventResponse?, FlutterError?) -> Void) {
    }

    func onAdShownRequest(_ request: EventRequest?, completion: @escaping (EventResponse?, FlutterError?) -> Void) {
    }

    func onAdDismissedRequest(_ request: EventRequest?, completion: @escaping (EventResponse?, FlutterError?) -> Void) {
    }
}
