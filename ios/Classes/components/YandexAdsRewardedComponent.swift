//
// Created by Artem Kovardin on 09.03.2022.
//

import Foundation
import YandexMobileAds
import Flutter

struct RewardedData {
    var loader: YMARewardedAdLoader? = nil
    var ad: YMARewardedAd? = nil
}


class YandexAdsRewardedComponent: NSObject, YandexAdsRewarded {
    
    private var rewardeds: [String: RewardedData] = [:]
    
    private var callbacks: FlutterYandexAdsRewarded
    
    init(callbacks: FlutterYandexAdsRewarded) {
        self.callbacks = callbacks
    }
    
    func make(id: String) throws {
        let loader = YMARewardedAdLoader()
        loader.delegate = self
        rewardeds[id] = RewardedData(loader: loader)
        
    }
    

    func load(id: String) {
        let configuration = YMAAdRequestConfiguration(adUnitID: id)
        rewardeds[id]?.loader?.loadAd(with: configuration)
        
    }
    
    func show(id: String) {
        if let controller = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
            rewardeds[id]?.ad?.show(from: controller)
        }
    }
}

extension YandexAdsRewardedComponent: YMARewardedAdLoaderDelegate {
    
    func rewardedAdLoader(_ adLoader: YMARewardedAdLoader, didLoad rewardedAd: YMARewardedAd) {
        let id = rewardedAd.adInfo?.adUnitId ?? ""
        rewardeds[id]?.ad = rewardedAd
        rewardeds[id]?.ad?.delegate = self
        callbacks.onAdLoaded(id: id) {_ in }
    }
    
    func rewardedAdLoader(_ adLoader: YMARewardedAdLoader, didFailToLoadWithError error: YMAAdRequestError) {
        callbacks.onAdFailedToLoad(
            id: error.adUnitId ?? "",
            err: RewardedError(code: 0, description: error.error.localizedDescription),
            completion: {_ in }
        )
    }
}


extension YandexAdsRewardedComponent: YMARewardedAdDelegate {
   
    func interstitialAd(_ rewardedAd: YMARewardedAd, didFailToShowWithError error: Error) {
        let id = rewardedAd.adInfo?.adUnitId ?? ""
        callbacks.onAdFailedToShow(
            id: id,
            err: RewardedError(code: 0, description: error.localizedDescription),
            completion: {_ in }
        )
    }

    func interstitialAdDidShow(_ rewardedAd: YMARewardedAd) {
        let id = rewardedAd.adInfo?.adUnitId ?? ""
        callbacks.onAdShown(id: id) {_ in }
    }

    func interstitialAdDidDismiss(_ rewardedAd: YMARewardedAd) {
        let id = rewardedAd.adInfo?.adUnitId ?? ""
        callbacks.onAdDismissed(id: id) {_ in }
    }

    func interstitialAdDidClick(_ rewardedAd: YMARewardedAd) {
        let id = rewardedAd.adInfo?.adUnitId ?? ""
        callbacks.onAdClicked(id: id) {_ in }
    }

    func interstitialAd(_ rewardedAd: YMARewardedAd, didTrackRewardedWith impressionData: YMAImpressionData?) {
        let id = rewardedAd.adInfo?.adUnitId ?? ""
        callbacks.onImpression(
            id: id,
            data: RewardedImpression(data: impressionData?.rawData ?? ""),
            completion: {_ in }
        )
    }
    
    func rewardedAd(_ rewardedAd: YMARewardedAd, didReward reward: YMAReward) {
        let id = rewardedAd.adInfo?.adUnitId ?? ""
        callbacks.onRewarded(
            id: id,
            reward: RewardedEvent(amount: Int64(reward.amount), type: reward.type),
            completion: {_ in }
        )
    }
}
