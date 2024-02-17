package ru.kovardin.flutter_yandex_ads.components

import android.content.Context
import com.yandex.mobile.ads.banner.BannerAdEventListener
import com.yandex.mobile.ads.banner.BannerAdSize
import com.yandex.mobile.ads.banner.BannerAdView
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import ru.kovardin.flutter_yandex_ads.pigeons.banner.BannerError
import ru.kovardin.flutter_yandex_ads.pigeons.banner.BannerImpression
import ru.kovardin.flutter_yandex_ads.pigeons.banner.YandexAdsBanner as Banner

data class BannerData(
    var view: BannerAdView,
    var onAdLoaded: ((Result<Unit>) -> Unit)? = null,
    var onAdFailedToLoad: ((Result<BannerError>) -> Unit)? = null,
    var onAdClicked: ((Result<Unit>) -> Unit)? = null,
    var onLeftApplication: ((Result<Unit>) -> Unit)? = null,
    var onReturnedToApplication: ((Result<Unit>) -> Unit)? = null,
    var onImpression: ((Result<BannerImpression>) -> Unit)? = null,
)

class YandexAdsBanner(private val context: Context) : Banner {
    var banners: MutableMap<String, BannerData> = mutableMapOf()

    override fun make(id: String, width: Long, height: Long) {
        val banner = BannerData(view = BannerAdView(context))

        banner.view.setAdSize(BannerAdSize.stickySize(context, width.toInt()))
        banner.view.setAdUnitId(id)
        banner.view.setBannerAdEventListener(object : BannerAdEventListener {
            override fun onAdLoaded() {
                banner.onAdLoaded?.let { it(Result.success(Unit)) }
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
                val err = BannerError(
                    code = error.code.toLong(),
                    description = error.description,
                )

                banner.onAdFailedToLoad?.let { it(Result.success(err)) }
            }

            override fun onLeftApplication() {
                banner.onLeftApplication?.let { it(Result.success(Unit)) }
            }

            override fun onReturnedToApplication() {
                banner.onReturnedToApplication?.let { it(Result.success(Unit)) }
            }

            override fun onImpression(data: ImpressionData?) {
                val imp = BannerImpression(
                    data = data?.rawData.orEmpty(),
                )
                banner.onImpression?.let { it(Result.success(imp)) }
            }

            override fun onAdClicked() {
                banner.onAdClicked?.let { it(Result.success(Unit)) }
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

    override fun onAdFailedToLoad(id: String, callback: (Result<BannerError>) -> Unit) {
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

    override fun onImpression(id: String, callback: (Result<BannerImpression>) -> Unit) {
        banners[id]?.onImpression = callback
    }
}