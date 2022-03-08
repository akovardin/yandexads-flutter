package ru.kovardin.flutter_yandex_ads.views

import android.content.Context
import android.view.View
import com.yandex.mobile.ads.banner.AdSize
import com.yandex.mobile.ads.banner.BannerAdEventListener
import com.yandex.mobile.ads.banner.BannerAdView
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class YandexAdsNative: PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        return Native(context, 1);
    }
}

class Native(context: Context, id: Int) : PlatformView {
    //    private val textView: TextView
    private val banner: BannerAdView

    init {

        banner = BannerAdView(context);
        banner.setAdSize(AdSize.BANNER_320x50)
        banner.setAdUnitId("R-M-1582183-1")
        banner.setBannerAdEventListener(object : BannerAdEventListener {
            override fun onAdLoaded() {
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
            }

            override fun onAdClicked() {
            }

            override fun onLeftApplication() {
            }

            override fun onReturnedToApplication() {
            }

            override fun onImpression(data: ImpressionData?) {
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