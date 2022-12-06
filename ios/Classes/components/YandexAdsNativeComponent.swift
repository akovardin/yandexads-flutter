//
//  YandexAdsNativeComponent.swift
//  flutter_yandex_ads
//
//  Created by Artem Kovardin on 06.12.2022.
//

import Foundation
import YandexMobileAds


struct NativeData {
    var view: YMANativeBannerView? = nil
    var delegate: YandexAdsNativeLoadedDelegate? = nil
    var onAdLoaded: ((FlutterError?) -> Void)? = nil
    var onAdFailed: ((NativeError?, FlutterError?) -> Void)? = nil
    var onAdShown: ((FlutterError?) -> Void)? = nil
    var onAdDismissed: ((FlutterError?) -> Void)? = nil
    var onAdClicked: ((FlutterError?) -> Void)? = nil
    var onLeftApplication: ((FlutterError?) -> Void)? = nil
    var onReturned: ((FlutterError?) -> Void)? = nil
    var onImpression: ((NativeImpression?, FlutterError?) -> Void)? = nil
}

class YandexAdsNativeComponent: NSObject, YandexAdsNative {
    var banners: [String: NativeData] = [:]
    let loader = YMANativeAdLoader()
    
    func makeId(_ id: String, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
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
    
    func loadId(_ id: String, width: NSNumber, height: NSNumber, error: AutoreleasingUnsafeMutablePointer<FlutterError?>) {
        
        if (banners[id]?.delegate != nil) {
            loader.delegate = banners[id]?.delegate
        }
        
        let configuration = YMAMutableNativeAdRequestConfiguration(adUnitID: id)
        
        if (width.intValue > 0 || height.intValue > 0 ) {
            configuration.parameters = [
                "preferable-height": width.stringValue,
                "preferable-width": height.stringValue,
            ]
        }
        configuration.shouldLoadImagesAutomatically = true
        
        loader.loadAd(with: configuration)
    }
    
    func onAdFailed(toLoadId id: String, completion: @escaping (NativeError?, FlutterError?) -> Void) {
        banners[id]?.onAdFailed = completion
    }
    
    func onAdLoadedId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        banners[id]?.onAdLoaded = completion
    }
    
    
    func onAdClickedId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        banners[id]?.onAdClicked = completion
    }
    
    func onLeftApplicationId(_ id: String, completion: @escaping (FlutterError?) -> Void) {
        banners[id]?.onLeftApplication = completion
    }
    
    func onReturned(toApplicationId id: String, completion: @escaping (FlutterError?) -> Void) {
        banners[id]?.onReturned = completion
    }
    
    func onImpressionId(_ id: String, completion: @escaping (NativeImpression?, FlutterError?) -> Void) {
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
            callback(nil)
        }
    }
    
    func nativeAdLoader(_ loader: YMANativeAdLoader, didFailLoadingWithError error: Error) {
        let response = NativeError.make(
            withCode: error._code as NSNumber,
            description: error.localizedDescription)
        
        if let callback =  component.banners[id]?.onAdFailed {
            callback(response, nil)
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
        print("Native ad will present")
    }
    
    func nativeAdWillLeaveApplication(_ ad: YMANativeAd) {
        if let callback =  component.banners[id]?.onLeftApplication {
            callback(nil)
        }
    }
    
    func nativeAdDidClick(_ ad: YMANativeAd) {
        if let callback =  component.banners[id]?.onAdClicked {
            callback(nil)
        }
    }
    
    func nativeAd(_ ad: YMANativeAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
        let response = NativeImpression.make(withData: impressionData?.rawData ?? "")
        
        if let callback =  component.banners[id]?.onImpression {
            callback(response, nil)
        }
    }
}
