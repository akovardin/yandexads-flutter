package ru.kovardin.flutter_yandex_ads.components

import android.content.Context
import com.yandex.mobile.ads.banner.BannerAdEventListener
import com.yandex.mobile.ads.banner.BannerAdSize
import com.yandex.mobile.ads.banner.BannerAdView
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import ru.kovardin.flutter_yandex_ads.pigeons.banner.YandexAdsBanner as Banner

data class BannerData(
    var view: BannerAdView,
    var onAdLoaded: ((Result<Unit>) -> Unit)? = null,
    var onAdFailedToLoad: Banner.Result<Banner.BannerError>? = null,
    var onAdShown: Banner.Result<Void>? = null,
    var onAdDismissed: Banner.Result<Void>? = null,
    var onAdClicked: Banner.Result<Void>? = null,
    var onLeftApplication: Banner.Result<Void>? = null,
    var onReturnedToApplication: Banner.Result<Void>? = null,
    var onImpression: Banner.Result<Banner.BannerImpression>? = null,
)

class YandexAdsBanner(private val context: Context): Banner {
    var banners: MutableMap<String, BannerData> = mutableMapOf()

    override fun make(id: String, width: Long, height: Long) {
        val banner = BannerData(view = BannerAdView(context))

        banner.view.setAdSize(BannerAdSize.stickySize(context, width.toInt()))
        banner.view.setAdUnitId(id)
        banner.view.setBannerAdEventListener(object : BannerAdEventListener {
            override fun onAdLoaded() {
                if (banner.onAdLoaded != null) {
                    banner.onAdLoaded()
                }
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
                val builder = Banner.BannerError.Builder()
                builder.setCode(error.code.toLong())
                builder.setDescription(error.description)

                banner.onAdFailedToLoad?.success(builder.build())
            }

            override fun onLeftApplication() {
                banner.onLeftApplication?.success(null)
            }

            override fun onReturnedToApplication() {
                banner.onReturnedToApplication?.success(null)
            }

            override fun onImpression(data: ImpressionData?) {
                val builder = Banner.BannerImpression.Builder()
                builder.setData(data?.rawData ?: "")
                banner.onImpression?.success(builder.build())
            }

            override fun onAdClicked() {
                banner.onAdClicked?.success(null)
            }
        })

        banners.put(id, banner)
    }

    override fun load(id: String) {
        banners[id]?.view?.loadAd(AdRequest.Builder().build())
    }

    override fun onAdLoaded(id: String, callback: (Result<Unit>) -> Unit) {

        banners[id]?.onAdLoaded = callback
    }

    override fun onAdFailedToLoad(id: String, result: Banner.Result<Banner.BannerError>) {
        banners[id]?.onAdFailedToLoad = result
    }

    override fun onAdClicked(id: String, result: Banner.Result<Void>) {
        banners[id]?.onAdClicked = result
    }

    override fun onLeftApplication(id: String, result: Banner.Result<Void>) {
        banners[id]?.onLeftApplication = result
    }

    override fun onReturnedToApplication(id: String, result: Banner.Result<Void>) {
        banners[id]?.onReturnedToApplication = result
    }

    override fun onImpression(id: String, result: Banner.Result<Banner.BannerImpression>) {
        banners[id]?.onImpression = result
    }
}