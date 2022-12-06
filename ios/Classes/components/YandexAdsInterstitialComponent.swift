//
// Created by Artem Kovardin on 09.03.2022.
//

import Foundation
import YandexMobileAds

struct InterstitialData {
    var ad: YMAInterstitialAd? = nil
    var onAdLoaded: ((FlutterError?) -> Void)? = nil
    var onAdFailed: ((InterstitialError?, FlutterError?) -> Void)? = nil
    var onAdShownId: ((FlutterError?) -> Void)? = nil
    var onAdDismissedId: ((FlutterError?) -> Void)? = nil
    var onAdClickedId: ((FlutterError?) -> Void)? = nil
    var onLeftApplicationId: ((FlutterError?) -> Void)? = nil
    var onReturned: ((FlutterError?) -> Void)? = nil
    var onImpressionId: ((InterstitialImpression?, FlutterError?) -> Void)? = nil
}

class YandexAdsInterstitialComponent: NSObject, YandexAdsInterstitial {
    private var interstitials: [String: InterstitialData] = [:]
    
    
    func makeId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let interstitial = YMAInterstitialAd(adUnitID: id)
        interstitial.delegate = self;
        
        interstitials[id] = InterstitialData(ad: interstitial)
    }
    

    func loadId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        interstitials[id]?.ad?.load()
    }
    
    func showId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        if let controller = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
            interstitials[id]?.ad?.present(from: controller)
        }
    }
   

    func onAdLoadedId(_ id: String, completion: @escaping (FlutterError?) -> Void){
        interstitials[id]?.onAdLoaded = completion
    }
    
    
    func onAdFailed(toLoadId id: String, completion: @escaping (InterstitialError?, FlutterError?) -> Void) {
        interstitials[id]?.onAdFailed = completion
    }
    
    
    func onAdShownId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        interstitials[id]?.onAdShownId = completion
    }
    
    
    func onAdDismissedId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        interstitials[id]?.onAdDismissedId = completion
    }
    
    func onAdClickedId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        interstitials[id]?.onAdClickedId = completion
    }
    
    
    func onLeftApplicationId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        interstitials[id]?.onLeftApplicationId = completion
    }
    
    
    func onReturned(toApplicationId id: String, completion: @escaping (FlutterError?) -> Void) {
        interstitials[id]?.onReturned = completion
    }
    
    
    func onImpressionId(_ id: String, completion: @escaping (InterstitialImpression?, FlutterError?) -> Void) {
        interstitials[id]?.onImpressionId = completion
    }
}


extension YandexAdsInterstitialComponent: YMAInterstitialAdDelegate {

    func interstitialAdDidLoad(_ interstitialAd: YMAInterstitialAd) {
        if let callback = interstitials[interstitialAd.adUnitID]?.onAdLoaded {
            callback(nil)
        }
    }

    func interstitialAdDidFail(toLoad interstitialAd: YMAInterstitialAd, error: Error) {
        let response = InterstitialError.make(
            withCode: error._code as NSNumber,
            description: error.localizedDescription)

        if let callback = interstitials[interstitialAd.adUnitID]?.onAdFailed {
            callback(response, nil)
        }
    }

    func interstitialAdWillLeaveApplication(_ interstitialAd: YMAInterstitialAd) {
        if let callback = interstitials[interstitialAd.adUnitID]?.onLeftApplicationId {
            callback(nil)
        }
    }

    func interstitialAdDidFail(toPresent interstitialAd: YMAInterstitialAd, error: Error) {
        print("Failed to present interstitial. Error: \(error)")
    }

    func interstitialAdWillAppear(_ interstitialAd: YMAInterstitialAd) {
        print("Interstitial ad will appear")
    }

    func interstitialAdDidAppear(_ interstitialAd: YMAInterstitialAd) {
        print("Interstitial ad did appear")
    }

    func interstitialAdWillDisappear(_ interstitialAd: YMAInterstitialAd) {
        print("Interstitial ad will disappear")
    }

    func interstitialAdDidDisappear(_ interstitialAd: YMAInterstitialAd) {
        if let callback = interstitials[interstitialAd.adUnitID]?.onAdDismissedId {
            callback(nil)
        }
    }

    func interstitialAd(_ interstitialAd: YMAInterstitialAd, willPresentScreen webBrowser: UIViewController?) {
        if let callback = interstitials[interstitialAd.adUnitID]?.onAdShownId {
            callback(nil)
        }
    }

    func interstitialAd(_ interstitialAd: YMAInterstitialAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
        let response = InterstitialImpression.make(withData: impressionData?.rawData ?? "")
        
        if let callback = interstitials[interstitialAd.adUnitID]?.onImpressionId {
            callback(response, nil)
        }
    }
    
    func interstitialAdDidClick(_ interstitialAd: YMAInterstitialAd) {
        if let callback = interstitials[interstitialAd.adUnitID]?.onAdClickedId {
            callback(nil)
        }
    }
}
