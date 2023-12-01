//
//  YandexAdsNativeComponent.swift
//  flutter_yandex_ads
//
//  Created by Artem Kovardin on 06.12.2022.
//

import Foundation
import YandexMobileAds
import Flutter


struct NativeData {
    var view: YMANativeBannerView? = nil
    var delegate: YandexAdsNativeLoadedDelegate? = nil
    var onAdLoaded: ((Result<Void, Error>) -> Void)? = nil
    var onAdFailed: ((Result<NativeError, Error>) -> Void)? = nil
    var onAdClicked: ((Result<Void, Error>) -> Void)? = nil
    var onAdShown: ((Result<Void, Error>) -> Void)? = nil
    var onLeftApplication: ((Result<Void, Error>) -> Void)? = nil
    var onReturned: ((Result<Void, Error>) -> Void)? = nil
    var onImpression: ((Result<NativeImpression, Error>) -> Void)? = nil
}

class YandexAdsNativeComponent: NSObject, YandexAdsNative {
    var banners: [String: NativeData] = [:]
    let loader = YMANativeAdLoader()
    
    func make(id: String) throws {
        banners[id] = NativeData(
            view: YMANativeBannerView(),
            delegate: YandexAdsNativeLoadedDelegate(
                id: id,
                nativeDelegate: YandexAdsNativeDelegate(
                    id: id,
                    component: self
                ),
                component: self
            )
        )
    }
    
    func load(id: String, width: Int64, height: Int64) throws {
        if (banners[id]?.delegate != nil) {
            loader.delegate = banners[id]?.delegate
        }
        
        let configuration = YMAMutableNativeAdRequestConfiguration(adUnitID: id)
        
        if (width > 0 || height > 0 ) {
            configuration.parameters = [
                "preferable-height": "\(width)",
                "preferable-width": "\(height)",
            ]
        }
        configuration.shouldLoadImagesAutomatically = true
        
        loader.loadAd(with: configuration)
    }
    
    func onAdLoaded(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        banners[id]?.onAdLoaded = completion
    }
    
    func onAdFailedToLoad(id: String, completion: @escaping (Result<NativeError, Error>) -> Void) {
        banners[id]?.onAdFailed = completion
    }
    
    func onAdClicked(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        banners[id]?.onAdClicked = completion
    }
    
    func onLeftApplication(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        banners[id]?.onLeftApplication = completion
    }
    
    func onReturnedToApplication(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        banners[id]?.onReturned = completion
    }
    
    func onImpression(id: String, completion: @escaping (Result<NativeImpression, Error>) -> Void) {
        banners[id]?.onImpression = completion
    }
}

extension YandexAdsNativeComponent: YMANativeAdLoaderDelegate {
    func nativeAdLoader(_ loader: YMANativeAdLoader, didLoad ad: YMANativeAd) {
        print(ad)
    }
    
    func nativeAdLoader(_ loader: YMANativeAdLoader, didFailLoadingWithError error: Error) {
        print(error)
    }
}

class YandexAdsNativeLoadedDelegate: NSObject, YMANativeAdLoaderDelegate {

    var id: String
    var nativeDelegate: YMANativeAdDelegate
    var component: YandexAdsNativeComponent
    
    init(id: String, nativeDelegate: YMANativeAdDelegate, component: YandexAdsNativeComponent) {
        self.id = id
        self.nativeDelegate = nativeDelegate
        self.component = component
    }
    
    func nativeAdLoader(_ loader: YMANativeAdLoader, didLoad ad: YMANativeAd) {
        ad.delegate = nativeDelegate
        
        component.banners[id]?.view?.ad = ad
        
        if let callback =  component.banners[id]?.onAdLoaded {
            callback(Result.success(()))
        }
    }
    
    func nativeAdLoader(_ loader: YMANativeAdLoader, didFailLoadingWithError error: Error) {
        let response = NativeError(
            code: Int64(error._code),
            description: error.localizedDescription)
        
        if let callback =  component.banners[id]?.onAdFailed {
            callback(Result.success(response))
        }
    }
}

class YandexAdsNativeDelegate: NSObject, YMANativeAdDelegate {
    var id: String
    var component: YandexAdsNativeComponent
    
    init(id: String, component: YandexAdsNativeComponent) {
        self.id = id
        self.component = component
    }
    
    func nativeAd(_ ad: YMANativeAd, didDismissScreen viewController: UIViewController?) {
        print("Native ad did dismiss")
    }
    
    func nativeAd(_ ad: YMANativeAd, willPresentScreen viewController: UIViewController?) {
        if let callback =  component.banners[id]?.onReturned {
            callback(Result.success(()))
        }
    }
    
    func nativeAdWillLeaveApplication(_ ad: YMANativeAd) {
        if let callback =  component.banners[id]?.onLeftApplication {
            callback(Result.success(()))
        }
    }
    
    func nativeAdDidClick(_ ad: YMANativeAd) {
        if let callback =  component.banners[id]?.onAdClicked {
            callback(Result.success(()))
        }
    }
    
    func nativeAd(_ ad: YMANativeAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
        let response = NativeImpression(data: impressionData?.rawData ?? "")
        
        if let callback =  component.banners[id]?.onImpression {
            callback(Result.success(response))
        }
    }
}
