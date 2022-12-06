package ru.kovardin.flutter_yandex_ads.components

import android.content.Context
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.interstitial.InterstitialAd
import com.yandex.mobile.ads.interstitial.InterstitialAdEventListener
import ru.kovardin.flutter_yandex_ads.pigeons.Interstitial

data class InterstitialData(
    var ad: InterstitialAd,
    var onAdLoaded: Interstitial.Result<Void>? = null,
    var onAdFailedToLoad: Interstitial.Result<Interstitial.InterstitialError>? = null,
    var onAdShown: Interstitial.Result<Void>? = null,
    var onAdDismissed: Interstitial.Result<Void>? = null,
    var onAdClicked: Interstitial.Result<Void>? = null,
    var onLeftApplication: Interstitial.Result<Void>? = null,
    var onReturnedToApplication: Interstitial.Result<Void>? = null,
    var onImpression: Interstitial.Result<Interstitial.InterstitialImpression>? = null,
)

class YandexAdsInterstitial(private val context: Context) : Interstitial.YandexAdsInterstitial {
    private var interstitials: MutableMap<String, InterstitialData> = mutableMapOf()

    override fun make(id: String) {
        val interstitial = InterstitialData(ad = InterstitialAd(context))

        interstitial.ad.setAdUnitId(id)
        interstitial.ad.setInterstitialAdEventListener(object : InterstitialAdEventListener {
            override fun onAdLoaded() {
                interstitial.onAdLoaded?.success(null)
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
                val err = Interstitial.InterstitialError.Builder()
                err.setCode(error.code.toLong())
                err.setDescription(error.description)

                interstitial.onAdFailedToLoad?.success(err.build())
            }

            override fun onAdShown() {
                interstitial.onAdShown?.success(null)
            }

            override fun onAdDismissed() {
                interstitial.onAdDismissed?.success(null)
            }

            override fun onAdClicked() {
                interstitial.onAdClicked?.success(null)
            }

            override fun onLeftApplication() {
                interstitial.onLeftApplication?.success(null)
            }

            override fun onReturnedToApplication() {
                interstitial.onReturnedToApplication?.success(null)
            }

            override fun onImpression(data: ImpressionData?) {
                val builder = Interstitial.InterstitialImpression.Builder()
                builder.setData(data?.rawData ?: "")
                interstitial.onImpression?.success(builder.build())
            }
        })

        interstitials.put(id, interstitial)
    }

    override fun load(id: String) {
        if (!interstitials.containsKey(id)) {
            return
        }

        val request = AdRequest.Builder().build()
        interstitials[id]?.ad?.loadAd(request)
    }

    override fun show(id: String) {
        interstitials[id]?.ad?.show()
    }

    override fun onAdLoaded(id: String, result: Interstitial.Result<Void>?) {
        interstitials[id]?.onAdLoaded = result
    }

    override fun onAdFailedToLoad(id: String, result: Interstitial.Result<Interstitial.InterstitialError>?) {
        interstitials[id]?.onAdFailedToLoad = result
    }

    override fun onAdShown(id: String, result: Interstitial.Result<Void>?) {
        interstitials[id]?.onAdShown = result
    }

    override fun onAdDismissed(id: String, result: Interstitial.Result<Void>?) {
        interstitials[id]?.onAdDismissed = result
    }

    override fun onAdClicked(id: String, result: Interstitial.Result<Void>?) {
        interstitials[id]?.onAdClicked = result
    }

    override fun onLeftApplication(id: String, result: Interstitial.Result<Void>?) {
        interstitials[id]?.onLeftApplication = result
    }

    override fun onReturnedToApplication(id: String, result: Interstitial.Result<Void>?) {
        interstitials[id]?.onReturnedToApplication = result
    }

    override fun onImpression(
        id: String,
        result: Interstitial.Result<Interstitial.InterstitialImpression>?
    ) {
        interstitials[id]?.onImpression = result
    }
}