//
//  YandexAdsBannerComponent.swift
//  flutter_yandex_ads
//
//  Created by Artem Kovardin on 05.12.2022.
//

import Foundation
import YandexMobileAds
import Flutter


struct BannerData {
    var view: YMAAdView!
    var onAdLoaded: ((Result<Void, Error>) -> Void)? = nil
    var onAdFailed: ((Result<BannerError, Error>) -> Void)? = nil
    var onAdClickedId: ((Result<Void, Error>) -> Void)? = nil
    var onLeftApplicationId: ((Result<Void, Error>) -> Void)? = nil
    var onReturned: ((Result<Void, Error>) -> Void)? = nil
    var onImpressionId: ((Result<BannerImpression, Error>) -> Void)? = nil
}

class YandexAdsBannerComponent: NSObject, YandexAdsBanner {

    var banners: [String: BannerData] = [:]
    
    func make(id: String, width: Int64, height: Int64) throws {
        let banner = BannerData(
            view: YMAAdView(
                adUnitID: id,
                adSize: YMABannerAdSize.inlineSize(
                    withWidth: CGFloat(width),
                    maxHeight: CGFloat(height)))
        )
        
        banner.view.delegate = self
        banner.view.removeFromSuperview()
        
        banners[id] = banner
    }
    
    func load(id: String) throws {
        banners[id]?.view.loadAd()
    }
    
    func onAdLoaded(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        banners[id]?.onAdLoaded = completion
    }
    
    func onAdFailedToLoad(id: String, completion: @escaping (Result<BannerError, Error>) -> Void) {
        banners[id]?.onAdFailed = completion
    }
    
    func onAdClicked(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        banners[id]?.onAdClickedId = completion
    }
    
    func onLeftApplication(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        banners[id]?.onLeftApplicationId = completion
    }
    
    func onReturnedToApplication(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        banners[id]?.onReturned = completion
    }
    
    func onImpression(id: String, completion: @escaping (Result<BannerImpression, Error>) -> Void) {
        banners[id]?.onImpressionId = completion
    }
}


extension YandexAdsBannerComponent: YMAAdViewDelegate {
    func adViewDidLoad(_ adView: YMAAdView) {
        if let callback =  banners[adView.adUnitID]?.onAdLoaded {
            callback(Result.success(()))
        }
    }

    func adViewDidFailLoading(_ adView: YMAAdView, error: Error) {
        let response = BannerError(
            code: Int64(error._code),
            description: error.localizedDescription)

        if let callback =  banners[adView.adUnitID]?.onAdFailed  {
            callback(Result.success(response))
        }
    }

    func adViewDidClick(_ adView: YMAAdView) {
        if let callback = banners[adView.adUnitID]?.onAdClickedId  {
            callback(Result.success(()))
        }
    }

    func adViewWillLeaveApplication(_ adView: YMAAdView) {
        if let callback = banners[adView.adUnitID]?.onLeftApplicationId  {
            callback(Result.success(()))
        }
    }

    func adView(_ adView: YMAAdView, didTrackImpressionWith impressionData: YMAImpressionData?) {
        let response = BannerImpression(data: impressionData?.rawData ?? "")
        
        if let callback = banners[adView.adUnitID]?.onImpressionId  {
            callback(Result.success(response))
        }
    }
}
