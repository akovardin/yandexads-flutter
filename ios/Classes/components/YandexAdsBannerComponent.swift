//
//  YandexAdsBannerComponent.swift
//  flutter_yandex_ads
//
//  Created by Artem Kovardin on 05.12.2022.
//

import Foundation
import YandexMobileAds


struct BannerData {
    var view: YMAAdView!
    var onAdLoaded: ((FlutterError?) -> Void)? = nil
    var onAdFailed: ((BannerError?, FlutterError?) -> Void)? = nil
    var onAdShownId: ((FlutterError?) -> Void)? = nil
    var onAdDismissedId: ((FlutterError?) -> Void)? = nil
    var onAdClickedId: ((FlutterError?) -> Void)? = nil
    var onLeftApplicationId: ((FlutterError?) -> Void)? = nil
    var onReturned: ((FlutterError?) -> Void)? = nil
    var onImpressionId: ((BannerImpression?, FlutterError?) -> Void)? = nil
}

class YandexAdsBannerComponent: NSObject, YandexAdsBanner {
    var banners: [String: BannerData] = [:]
    
    func makeId(_ id: String, width: NSNumber, height: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        let banner = BannerData(
            view: YMAAdView(adUnitID: id, adSize: YMAAdSize.flexibleSize(with: .init(width: width.intValue, height: height.intValue)))
        )
        
        banner.view.delegate = self
        banner.view.removeFromSuperview()
        
        banners[id] = banner
    }
    
    func loadId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        banners[id]?.view.loadAd()
    }
    
    func onAdLoadedId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        banners[id]?.onAdLoaded = completion
    }
    
    func onAdFailed(toLoadId id: String, completion: @escaping (BannerError?, FlutterError?) -> Void) {
        banners[id]?.onAdFailed = completion
    }
    
    func onAdClickedId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        banners[id]?.onAdClickedId = completion
    }
    
    func onLeftApplicationId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        banners[id]?.onLeftApplicationId = completion
    }
    
    
    func onReturned(toApplicationId id: String, completion: @escaping (FlutterError?) -> Void) {
        banners[id]?.onReturned = completion
    }
    
    func onImpressionId(_ id: String, completion: @escaping (BannerImpression?, FlutterError?) -> Void) {
        banners[id]?.onImpressionId = completion
    }
}


extension YandexAdsBannerComponent: YMAAdViewDelegate {
    func adViewDidLoad(_ adView: YMAAdView) {
        if let callback =  banners[adView.adUnitID]?.onAdLoaded {
            callback(nil)
        }
    }

    func adViewDidFailLoading(_ adView: YMAAdView, error: Error) {
        let response = BannerError.make(
            withCode: error._code as NSNumber,
            description: error.localizedDescription)

        if let callback =  banners[adView.adUnitID]?.onAdFailed  {
            callback(response, nil)
        }
    }

    func adViewDidClick(_ adView: YMAAdView) {
        if let callback = banners[adView.adUnitID]?.onLeftApplicationId  {
            callback(nil)
        }
    }

    func adViewWillLeaveApplication(_ adView: YMAAdView) {
        if let callback = banners[adView.adUnitID]?.onAdClickedId  {
            callback(nil)
        }
    }

    func adView(_ adView: YMAAdView, willPresentScreen viewController: UIViewController?) {
        if let callback = banners[adView.adUnitID]?.onAdShownId  {
            callback(nil)
        }
    }

    func adView(_ adView: YMAAdView, didDismissScreen viewController: UIViewController?) {
        if let callback = banners[adView.adUnitID]?.onAdDismissedId  {
            callback(nil)
        }
    }

    func adView(_ adView: YMAAdView, didTrackImpressionWith impressionData: YMAImpressionData?) {
        let response = BannerImpression.make(withData: impressionData?.rawData ?? "")
        
        if let callback = banners[adView.adUnitID]?.onImpressionId  {
            callback(response, nil)
        }
    }
}
