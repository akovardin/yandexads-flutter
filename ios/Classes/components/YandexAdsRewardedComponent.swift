//
// Created by Artem Kovardin on 09.03.2022.
//

import Foundation
import YandexMobileAds

struct RewardedData {
    var ad: YMARewardedAd? = nil
//    var onAdLoaded: ((FlutterError?) -> Void)? = nil
//    var onAdFailed: ((RewardedError?, FlutterError?) -> Void)? = nil
//    var onAdShownId: ((FlutterError?) -> Void)? = nil
//    var onAdDismissedId: ((FlutterError?) -> Void)? = nil
//    var onAdClickedId: ((FlutterError?) -> Void)? = nil
//    var onLeftApplicationId: ((FlutterError?) -> Void)? = nil
//    var onReturned: ((FlutterError?) -> Void)? = nil
//    var onImpressionId: ((RewardedImpression?, FlutterError?) -> Void)? = nil
//    var onRewardedId: ((RewardedEvent?, FlutterError?) -> Void)? = nil
}

class YandexAdsRewardedComponent: NSObject, YandexAdsRewarded {
    
    private var rewardeds: [String: RewardedData] = [:]
    
    func make(id: String) throws {
        
    }
    
    func load(id: String) throws {
        
    }
    
    func show(id: String) throws {
        
    }
    
    func onAdLoaded(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    func onAdFailedToLoad(id: String, completion: @escaping (Result<RewardedError, Error>) -> Void) {
        
    }
    
    func onAdFailedToShow(id: String, completion: @escaping (Result<RewardedError, Error>) -> Void) {
        
    }
    
    func onAdShown(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    func onAdDismissed(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    func onAdClicked(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    func onImpression(id: String, completion: @escaping (Result<RewardedImpression, Error>) -> Void) {
        
    }
    
    func onRewarded(id: String, completion: @escaping (Result<RewardedEvent, Error>) -> Void) {
        
    }
    
    
//    func makeId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
//        let reward = YMARewardedAd(adUnitID: id)
//        reward.delegate = self;
//        
//        rewardeds[id] = RewardedData(ad: reward)
//    }
//    
//
//    func loadId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
//        rewardeds[id]?.ad?.load()
//    }
//    
//    func showId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
//        if let controller = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
//            rewardeds[id]?.ad?.present(from: controller)
//        }
//    }
//   
//
//    func onAdLoadedId(_ id: String, completion: @escaping (FlutterError?) -> Void){
//        rewardeds[id]?.onAdLoaded = completion
//    }
//    
//    
//    func onAdFailed(toLoadId id: String, completion: @escaping (RewardedError?, FlutterError?) -> Void) {
//        rewardeds[id]?.onAdFailed = completion
//    }
//    
//    
//    func onAdShownId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
//        rewardeds[id]?.onAdShownId = completion
//    }
//    
//    
//    func onAdDismissedId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
//        rewardeds[id]?.onAdDismissedId = completion
//    }
//    
//    func onAdClickedId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
//        rewardeds[id]?.onAdClickedId = completion
//    }
//    
//    
//    func onLeftApplicationId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
//        rewardeds[id]?.onLeftApplicationId = completion
//    }
//    
//    
//    func onReturned(toApplicationId id: String, completion: @escaping (FlutterError?) -> Void) {
//        rewardeds[id]?.onReturned = completion
//    }
//    
//    
//    func onImpressionId(_ id: String, completion: @escaping (RewardedImpression?, FlutterError?) -> Void) {
//        rewardeds[id]?.onImpressionId = completion
//    }
//    
//    func onRewardedId(_ id: String, completion: @escaping (RewardedEvent?, FlutterError?) -> Void) {
//        rewardeds[id]?.onRewardedId = completion
//    }
}


//extension YandexAdsRewardedComponent: YMARewardedAdDelegate {
//    func rewardedAdDidLoad(_ ad: YMARewardedAd) {
//        if let callback = rewardeds[ad.adUnitID]?.onAdLoaded {
//            callback(nil)
//        }
//    }
//
//    func rewardedAdDidFail(toLoad ad: YMARewardedAd, error: Error) {
//        let response = RewardedError.make(
//            withCode: error._code as NSNumber,
//            description: error.localizedDescription)
//
//        if let callback = rewardeds[ad.adUnitID]?.onAdFailed {
//            callback(response, nil)
//        }
//    }
//
//    func rewardedAdWillLeaveApplication(_ ad: YMARewardedAd) {
//        if let callback = rewardeds[ad.adUnitID]?.onLeftApplicationId {
//            callback(nil)
//        }
//    }
//
//    func rewardedAdDidFail(toPresent interstitialAd: YMARewardedAd, error: Error) {
//        print("Failed to present rewarded. Error: \(error)")
//    }
//
//    func rewardedAdWillAppear(_ interstitialAd: YMARewardedAd) {
//        print("Rewarded ad will appear")
//    }
//
//    func rewardedAdDidAppear(_ interstitialAd: YMARewardedAd) {
//        print("Rewarded ad did appear")
//    }
//
//    func rewardedAdWillDisappear(_ interstitialAd: YMARewardedAd) {
//        print("Rewarded ad will disappear")
//    }
//
//    func rewardedAdDidDisappear(_ interstitialAd: YMARewardedAd) {
//        if let callback = rewardeds[interstitialAd.adUnitID]?.onAdDismissedId {
//            callback(nil)
//        }
//    }
//
//    func rewardedAd(_ interstitialAd: YMARewardedAd, willPresentScreen webBrowser: UIViewController?) {
//        if let callback = rewardeds[interstitialAd.adUnitID]?.onAdShownId {
//            callback(nil)
//        }
//    }
//
//    func rewardedAd(_ interstitialAd: YMARewardedAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
//        let response = RewardedImpression.make(withData: impressionData?.rawData ?? "")
//        
//        if let callback = rewardeds[interstitialAd.adUnitID]?.onImpressionId {
//            callback(response, nil)
//        }
//    }
//    
//    func rewardedAdDidClick(_ ad: YMARewardedAd) {
//        if let callback = rewardeds[ad.adUnitID]?.onAdClickedId {
//            callback(nil)
//        }
//    }
//    
//    func rewardedAd(_ ad: YMARewardedAd, didReward reward: YMAReward) {
//        let response = RewardedEvent.make(withAmount: reward.amount as NSNumber, type: reward.type)
//        
//        if let callback = rewardeds[ad.adUnitID]?.onRewardedId {
//            callback(response, nil)
//        }
//    }
//}
