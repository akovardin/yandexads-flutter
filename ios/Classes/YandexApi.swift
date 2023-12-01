import Flutter
import UIKit
import AppTrackingTransparency

class YandexApi: NSObject, YandexAdsApi {
    func initialize() throws {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                // Start ad loading
            }
        } else {
            // Fallback on earlier versions
        }
    }
}
