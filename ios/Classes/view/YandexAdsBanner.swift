import Flutter
import UIKit
import YandexMobileAds

class YandexAdsBanner: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return Banner(
                frame: frame,
                viewIdentifier: viewId,
                arguments: args,
                binaryMessenger: messenger)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class Banner: NSObject, FlutterPlatformView {
    private var banner: YMAAdView!

    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger messenger: FlutterBinaryMessenger?) {
        super.init()

        let params = args as! [String: String]
        let id = params["id"]

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
        print("Ad loaded")
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

