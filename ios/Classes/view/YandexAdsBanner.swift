import Flutter
import UIKit
import YandexMobileAds

class YandexAdsBanner: NSObject, FlutterPlatformViewFactory {
    private var api: YandexApi

    init(api: YandexApi) {
        self.api = api
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return Banner(
                frame: frame,
                viewIdentifier: viewId,
                arguments: args,
                api: api)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class Banner: NSObject, FlutterPlatformView {
    private var banner: YMAAdView!
    private var api: YandexApi!
    private var id: String = ""

    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, api api: YandexApi?) {
        super.init()

        let params = args as! [String: String]
        let id = params["id"]

        self.api = api
        self.id = id ?? ""

        banner = YMAAdView(adUnitID: id ?? "", adSize: YMAAdSize.fixedSize(with: .init(width: 320, height: 100)))
        banner.delegate = self
        banner.removeFromSuperview()
        banner.loadAd()
    }

    func view() -> UIView {
        return banner
    }
}

extension Banner: YMAAdViewDelegate {
    func adViewDidLoad(_ adView: YMAAdView) {
        let response = EventResponse()

        if let callback = api.callbacks[EventKey(id: id, name: "onAdLoaded", type: EventType.BANNER.rawValue)] {
            callback(response, nil)
        }
    }

    func adViewDidFailLoading(_ adView: YMAAdView, error: Error) {
        print("Ad failed loading. Error: \(error)")
    }

    func adViewWillLeaveApplication(_ adView: YMAAdView) {
        print("Ad will leave application")
    }

    func adView(_ adView: YMAAdView, willPresentScreen viewController: UIViewController?) {
        print("Ad will present screen")
    }

    func adView(_ adView: YMAAdView, didDismissScreen viewController: UIViewController?) {
        print("Ad did dismiss screen")
    }

    func adView(_ adView: YMAAdView, didTrackImpressionWith impressionData: YMAImpressionData?) {
        print("Ad did dismiss screen")
    }
}

