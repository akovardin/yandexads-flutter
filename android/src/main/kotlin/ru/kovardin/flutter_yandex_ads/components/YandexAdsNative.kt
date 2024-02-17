package ru.kovardin.flutter_yandex_ads.components

import android.content.Context
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.nativeads.NativeAd
import com.yandex.mobile.ads.nativeads.NativeAdEventListener
import com.yandex.mobile.ads.nativeads.NativeAdLoadListener
import com.yandex.mobile.ads.nativeads.NativeAdLoader
import com.yandex.mobile.ads.nativeads.NativeAdRequestConfiguration
import com.yandex.mobile.ads.nativeads.template.NativeBannerView
import ru.kovardin.flutter_yandex_ads.pigeons.native.NativeError
import ru.kovardin.flutter_yandex_ads.pigeons.native.NativeImpression
import ru.kovardin.flutter_yandex_ads.pigeons.native.YandexAdsNative as Native

data class NativeData(
    var view: NativeBannerView? = null,
    var params: MutableMap<String, String>? = null,
    var onAdLoaded: ((Result<Unit>) -> Unit)? = null,
    var onAdFailedToLoad: ((Result<NativeError>) -> Unit)? = null,
    var onAdClicked: ((Result<Unit>) -> Unit)? = null,
    var onLeftApplication: ((Result<Unit>) -> Unit)? = null,
    var onReturnedToApplication: ((Result<Unit>) -> Unit)? = null,
    var onImpression: ((Result<NativeImpression>) -> Unit)? = null,
)

class YandexAdsNative(private val context: Context) : Native {
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
                        banners[id]?.onAdClicked?.let { it(Result.success(Unit)) }
                    }

                    override fun onLeftApplication() {
                        banners[id]?.onLeftApplication?.let { it(Result.success(Unit)) }
                    }

                    override fun onReturnedToApplication() {
                        banners[id]?.onReturnedToApplication?.let { it(Result.success(Unit)) }
                    }

                    override fun onImpression(data: ImpressionData?) {
                        val imp = NativeImpression(
                            data = data?.rawData.orEmpty(),
                        )
                        banners[id]?.onImpression?.let { it(Result.success(imp)) }
                    }
                })

                banners[id]?.view = NativeBannerView(context)
                banners[id]?.view?.setAd(nativeAd)

                banners[id]?.onAdLoaded?.let { it(Result.success(Unit)) }
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
                val err = NativeError(
                    code = error.code.toLong(),
                    description = error.description,
                )

                banners[id]?.onAdFailedToLoad?.let { it(Result.success(err)) }
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

    override fun onAdLoaded(id: String, callback: (Result<Unit>) -> Unit) {
        banners[id]?.onAdLoaded = callback
    }

    override fun onAdFailedToLoad(id: String, callback: (Result<NativeError>) -> Unit) {
        banners[id]?.onAdFailedToLoad = callback
    }

    override fun onAdClicked(id: String, callback: (Result<Unit>) -> Unit) {
        banners[id]?.onAdClicked = callback
    }

    override fun onLeftApplication(id: String, callback: (Result<Unit>) -> Unit) {
        banners[id]?.onLeftApplication = callback
    }

    override fun onReturnedToApplication(id: String, callback: (Result<Unit>) -> Unit) {
        banners[id]?.onReturnedToApplication = callback
    }

    override fun onImpression(id: String, callback: (Result<NativeImpression>) -> Unit) {
        banners[id]?.onImpression = callback
    }
}