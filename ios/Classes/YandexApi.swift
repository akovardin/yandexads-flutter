import Flutter
import UIKit
import AppTrackingTransparency

class YandexApi: NSObject, YandexAdsApi {
    func initializeWithError(_ error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                // Start ad loading
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
