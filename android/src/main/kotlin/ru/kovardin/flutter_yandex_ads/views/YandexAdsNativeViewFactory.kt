package ru.kovardin.flutter_yandex_ads.views

import android.content.Context
import android.view.View
import android.widget.TextView
import com.yandex.mobile.ads.nativeads.template.NativeBannerView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import ru.kovardin.flutter_yandex_ads.components.YandexAdsNative

class YandexAdsNativeViewFactory(private val api: YandexAdsNative) : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context?, viewId: Int, args: Any?): PlatformView {
        val params = args as Map<String?, Any?>?
        val id: String = params?.get("id") as String

        val banner = api.banners[id]!!
        val empty = TextView(context)
        empty.text = ""

        return NativeView(banner = banner.view, empty);
    }
}

class NativeView(val banner: NativeBannerView?, val empty: TextView) : PlatformView {
    override fun getView(): View {
        if (banner != null) {
            return banner
        }

        return empty
    }

    override fun dispose() {}
}