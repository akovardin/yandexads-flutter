package ru.kovardin.flutter_yandex_ads.components

import android.content.Context
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.nativeads.*
import com.yandex.mobile.ads.nativeads.template.NativeBannerView
import ru.kovardin.flutter_yandex_ads.pigeons.Native

data class NativeData(
    var view: NativeBannerView? = null,
    var params: MutableMap<String, String>? = null,
    var onAdLoaded: Native.Result<Void>? = null,
    var onAdFailedToLoad: Native.Result<Native.NativeError>? = null,
    var onAdShown: Native.Result<Void>? = null,
    var onAdDismissed: Native.Result<Void>? = null,
    var onAdClicked: Native.Result<Void>? = null,
    var onLeftApplication: Native.Result<Void>? = null,
    var onReturnedToApplication: Native.Result<Void>? = null,
    var onImpression: Native.Result<Native.NativeImpression>? = null,
)

class YandexAdsNative(private val context: Context) : Native.YandexAdsNative {
    var banners: MutableMap<String, NativeData> = mutableMapOf()

    override fun make(id: String) {
        val native = NativeData()

        banners.put(id, native)
    }

    override fun load(id: String, width: Long, height: Long) {
        val loader = NativeAdLoader(context)

        loader.setNativeAdLoadListener(object : NativeAdLoadListener {
            override fun onAdLoaded(nativeAd: NativeAd) {
                nativeAd.setNativeAdEventListener(object : NativeAdEventListener {
                    override fun onAdClicked() {
                        banners[id]?.onAdClicked?.success(null)
                    }

                    override fun onLeftApplication() {
                        banners[id]?.onLeftApplication?.success(null)
                    }

                    override fun onReturnedToApplication() {
                        banners[id]?.onReturnedToApplication?.success(null)
                    }

                    override fun onImpression(data: ImpressionData?) {
                        val builder = Native.NativeImpression.Builder()
                        builder.setData(data?.rawData ?: "")
                        banners[id]?.onImpression?.success(builder.build())
                    }
                })

                banners[id]?.view = NativeBannerView(context)
                banners[id]?.view?.setAd(nativeAd)

                banners[id]?.onAdLoaded?.success(null)
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
                val builder = Native.NativeError.Builder()
                builder.setCode(error.code.toLong())
                builder.setDescription(error.description)

                banners[id]?.onAdFailedToLoad?.success(builder.build())
            }
        })

        val config = NativeAdRequestConfiguration.Builder(id)

        if (width > 0 || height > 0) {
            val params: MutableMap<String, String> = mutableMapOf()
            params.put("preferable-width", width.toString())
            params.put("preferable-height", height.toString())

            config.setParameters(params)
        }

        loader.loadAd(config.build())
    }

    override fun onAdLoaded(id: String, result: Native.Result<Void>) {
        banners[id]?.onAdLoaded = result
    }

    override fun onAdFailedToLoad(id: String, result: Native.Result<Native.NativeError>) {
        banners[id]?.onAdFailedToLoad = result
    }

    override fun onAdClicked(id: String, result: Native.Result<Void>) {
        banners[id]?.onAdClicked = result
    }

    override fun onLeftApplication(id: String, result: Native.Result<Void>) {
        banners[id]?.onLeftApplication = result
    }

    override fun onReturnedToApplication(id: String, result: Native.Result<Void>) {
        banners[id]?.onReturnedToApplication = result
    }

    override fun onImpression(id: String, result: Native.Result<Native.NativeImpression>) {
        banners[id]?.onImpression = result
    }
}