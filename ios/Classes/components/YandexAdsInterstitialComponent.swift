//
// Created by Artem Kovardin on 09.03.2022.
//

import Foundation
import YandexMobileAds
import Flutter

struct InterstitialData {
    var loader: YMAInterstitialAdLoader? = nil
    var ad: YMAInterstitialAd? = nil
}

class YandexAdsInterstitialComponent: NSObject, YandexAdsInterstitial {
    
    private var interstitials: [String: InterstitialData] = [:]
    
    private var callbacks: FlutterYandexAdsInterstitial
    
    init(callbacks: FlutterYandexAdsInterstitial) {
        self.callbacks = callbacks
    }
    
    
    func make(id: String) throws {
        let loader = YMAInterstitialAdLoader()
        loader.delegate = self
        interstitials[id] = InterstitialData(loader: loader)
        
    }
    

    func load(id: String) {
        let configuration = YMAAdRequestConfiguration(adUnitID: id)
        interstitials[id]?.loader?.loadAd(with: configuration)
        
    }
    
    func show(id: String) {
        if let controller = UIApplication.shared.delegate?.window??.rootViewController as? FlutterViewController {
            interstitials[id]?.ad?.show(from: controller)
        }
    }
}


extension YandexAdsInterstitialComponent: YMAInterstitialAdLoaderDelegate {
    func interstitialAdLoader(_ adLoader: YMAInterstitialAdLoader, didLoad interstitialAd: YMAInterstitialAd) {
        let id = interstitialAd.adInfo?.adUnitId ?? ""
        interstitials[id]?.ad = interstitialAd
        interstitials[id]?.ad?.delegate = self
        callbacks.onAdLoaded(id: id) {}
    }
    
    func interstitialAdLoader(_ adLoader: YMAInterstitialAdLoader, didFailToLoadWithError error: YMAAdRequestError) {
        callbacks.onAdFailedToLoad(id: error.adUnitId ?? "",
                                   err: InterstitialError(code: 0, description: error.error.localizedDescription),
                                   completion: {})
    }
}

extension YandexAdsInterstitialComponent: YMAInterstitialAdDelegate {
   
    func interstitialAd(_ interstitialAd: YMAInterstitialAd, didFailToShowWithError error: Error) {
        let id = interstitialAd.adInfo?.adUnitId ?? ""
        callbacks.onAdFailedToShow(id: id,
                                   err: InterstitialError(code: 0, description: error.localizedDescription),
                                   completion: {})
    }

    func interstitialAdDidShow(_ interstitialAd: YMAInterstitialAd) {
        let id = interstitialAd.adInfo?.adUnitId ?? ""
        callbacks.onAdShown(id: id) {}
    }

    func interstitialAdDidDismiss(_ interstitialAd: YMAInterstitialAd) {
        let id = interstitialAd.adInfo?.adUnitId ?? ""
        callbacks.onAdDismissed(id: id) {}
    }

    func interstitialAdDidClick(_ interstitialAd: YMAInterstitialAd) {
        let id = interstitialAd.adInfo?.adUnitId ?? ""
        callbacks.onAdClicked(id: id) {}
    }

    func interstitialAd(_ interstitialAd: YMAInterstitialAd, didTrackImpressionWith impressionData: YMAImpressionData?) {
        let id = interstitialAd.adInfo?.adUnitId ?? ""
        callbacks.onImpression(id: id, data: InterstitialImpression(data: impressionData?.rawData ?? ""), completion: {})
    }
}
