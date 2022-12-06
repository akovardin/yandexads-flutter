import Flutter
import UIKit
import YandexMobileAds

class YandexAdsBannerViewFactory: NSObject, FlutterPlatformViewFactory {
    private var api: YandexAdsBannerComponent

    init(api: YandexAdsBannerComponent) {
        self.api = api
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as! [String: Any]
        let id = params["id"] as! String
        
        let banner = api.banners[id]
        
        return BannerView(
                frame: frame,
                viewIdentifier: viewId,
                banner: banner)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class BannerView: NSObject, FlutterPlatformView {
    private var banner: BannerData!

    init(frame: CGRect, viewIdentifier viewId: Int64, banner: BannerData?) {
        super.init()
        self.banner = banner
    }

    func view() -> UIView {
        return banner.view
    }
}

