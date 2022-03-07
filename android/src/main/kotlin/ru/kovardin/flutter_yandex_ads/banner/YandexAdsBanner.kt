package ru.kovardin.flutter_yandex_ads.banner

import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import com.yandex.mobile.ads.banner.AdSize
import com.yandex.mobile.ads.banner.BannerAdEventListener
import com.yandex.mobile.ads.banner.BannerAdView
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class YandexAdsBanner : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return FlutterPlatformView(context, 1);
    }
}

class FlutterPlatformView(context: Context, id: Int) : PlatformView {
//    private val textView: TextView
    private val banner: BannerAdView

    init {

        banner = BannerAdView(context);
        banner.setAdSize(AdSize.stickySize(AdSize.FULL_WIDTH))
        banner.setBlockId("R-M-1582183-1")
        banner.setBannerAdEventListener(object : BannerAdEventListener {
            override fun onAdLoaded() {
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
            }

            override fun onLeftApplication() {
            }

            override fun onReturnedToApplication() {
            }
        })


        val request: AdRequest = AdRequest.Builder().build()
        banner.loadAd(request)


//        textView = TextView(context)
//        textView.textSize = 14f
//        textView.setBackgroundColor(Color.rgb(255, 255, 255))
//        textView.text = "Rendered on a native Android view (id: $id)"
    }

    override fun getView(): View {
        return banner;
    }

    override fun dispose() {}
}
