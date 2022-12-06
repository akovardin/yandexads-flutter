package ru.kovardin.flutter_yandex_ads.views

import android.content.Context
import android.view.View
import com.yandex.mobile.ads.banner.BannerAdView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import ru.kovardin.flutter_yandex_ads.components.YandexAdsBanner

class YandexAdsBannerViewFactory(private val api: YandexAdsBanner) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<String?, Any?>?
        val id: String = params?.get("id") as String

        val banner = api.banners[id]!!

        return BannerView(banner = banner.view);
    }
}

class BannerView(val banner: BannerAdView) : PlatformView {
    override fun getView(): View {
        return banner
    }

    override fun dispose() {}
}
