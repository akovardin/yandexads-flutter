package ru.kovardin.flutter_yandex_ads.components

import android.app.Activity
import android.content.Context
import com.yandex.mobile.ads.common.AdError
import com.yandex.mobile.ads.common.AdRequestConfiguration
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.interstitial.InterstitialAd
import com.yandex.mobile.ads.interstitial.InterstitialAdEventListener
import com.yandex.mobile.ads.interstitial.InterstitialAdLoadListener
import com.yandex.mobile.ads.interstitial.InterstitialAdLoader
import io.flutter.embedding.engine.plugins.FlutterPlugin
import ru.kovardin.flutter_yandex_ads.pigeons.Interstitial
import ru.kovardin.flutter_yandex_ads.pigeons.Interstitial.InterstitialError
import ru.kovardin.flutter_yandex_ads.pigeons.Interstitial.InterstitialImpression

data class InterstitialData(
    var interstitial: InterstitialAd? = null,
    var loader: InterstitialAdLoader? = null,
)

class YandexAdsInterstitial(private val context: Context, private val activity: Activity, private val callbacks: YandexAdsInterstitialCallbacks) : Interstitial.YandexAdsInterstitial {
    private var interstitials: MutableMap<String, InterstitialData> = mutableMapOf()

    override fun make(id: String) {
        val loader = InterstitialAdLoader(context)
        val ad = InterstitialData(loader = loader)

        ad.loader?.apply {
            setAdLoadListener(object : InterstitialAdLoadListener {
                override fun onAdLoaded(interstitial: InterstitialAd) {
                    // save rewardedAd to a local variable
                    // now rewardedAd is ready to show
                    ad.interstitial = interstitial
                    callbacks.onAdLoaded(id)

                    ad.interstitial?.setAdEventListener(object : InterstitialAdEventListener {
                        override fun onAdShown() {
                            callbacks.onAdShown(id)
                        }

                        override fun onAdFailedToShow(error: AdError) {
                            val err = InterstitialError.Builder()
                            err.setCode(0)
                            err.setDescription(error.description)

                            callbacks.onAdFailedToShow(id, err.build())
                        }

                        override fun onAdDismissed() {
                            callbacks.onAdDismissed(id)
                        }

                        override fun onAdClicked() {
                            callbacks.onAdClicked(id)
                        }

                        override fun onAdImpression(data: ImpressionData?) {
                            val builder = InterstitialImpression.Builder()
                            builder.setData(data?.rawData ?: "")

                            callbacks.onImpression(id, builder.build())
                        }
                    })
                }

                override fun onAdFailedToLoad(error: AdRequestError) {
                    val err = InterstitialError.Builder()
                    err.setCode(error.code.toLong())
                    err.setDescription(error.description)

                    callbacks.onAdFailedToLoad(id, err.build())
                }
            })
        }

        interstitials.put(id, ad)
    }

    override fun load(id: String) {
        if (!interstitials.containsKey(id)) {
            return
        }

        interstitials[id]?.loader?.loadAd(AdRequestConfiguration.Builder(id).build())
    }

    override fun show(id: String) {
        interstitials[id]?.interstitial?.show(activity)
    }
}


class YandexAdsInterstitialCallbacks(binding: FlutterPlugin.FlutterPluginBinding) {

    var api: Interstitial.FlutterYandexAdsInterstitial? = null

    init {
        api = Interstitial.FlutterYandexAdsInterstitial(binding.getBinaryMessenger())
    }

    fun onAdLoaded(id: String) {
        api?.onAdLoaded(id) {}
    }

    fun onAdFailedToLoad(id: String,  error: InterstitialError) {
        api?.onAdFailedToLoad(id, error) {}
    }

    fun onAdFailedToShow(id: String, error: InterstitialError) {
        api?.onAdFailedToLoad(id, error) {}
    }

    fun onAdShown(id: String) {
        api?.onAdShown(id) {}
    }

    fun onAdDismissed(id: String) {
        api?.onAdDismissed(id) {}
    }

    fun onAdClicked(id: String) {
        api?.onAdClicked(id) {}
    }

    fun onImpression(id: String, data: InterstitialImpression) {
        api?.onImpression(id, data) {}
    }
}