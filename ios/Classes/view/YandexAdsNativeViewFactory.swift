import Flutter
import UIKit
import YandexMobileAds

class YandexAdsNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var api: YandexAdsNativeComponent

    init(api: YandexAdsNativeComponent) {
        self.api = api
        super.init()
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as! [String: Any]
        let id = params["id"] as! String
        
        let native = api.banners[id]
        
        return NativeView(
                frame: frame,
                viewIdentifier: viewId,
                native: native)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class NativeView: NSObject, FlutterPlatformView {
    private var native: NativeData? = nil

    init(frame: CGRect, viewIdentifier viewId: Int64, native: NativeData?) {
        super.init()
        self.native = native
    }

    func view() -> UIView {
        return native?.view ?? UIView()
    }
}

