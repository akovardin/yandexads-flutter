package ru.kovardin.flutter_yandex_ads.components

import android.content.Context
import android.util.Log
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.interstitial.InterstitialAd
import com.yandex.mobile.ads.interstitial.InterstitialAdEventListener
import ru.kovardin.flutter_yandex_ads.EventKey
import ru.kovardin.flutter_yandex_ads.EventType
import ru.kovardin.flutter_yandex_ads.YandexApi
import ru.kovardin.flutter_yandex_ads.pigeons.Interstitial
import ru.kovardin.flutter_yandex_ads.pigeons.Yandex


class YandexAdsInterstitial(private val api: YandexApi, private val context: Context) : Interstitial.YandexAdsInterstitial {
    private lateinit var interstitial: InterstitialAd
    override fun config(id: String?) {
        interstitial = InterstitialAd(context)
        interstitial.setAdUnitId(id ?: "")
        interstitial.setInterstitialAdEventListener(object : InterstitialAdEventListener {
            override fun onAdLoaded() {
                val builder = Yandex.EventResponse.Builder()

                val response = builder.build()
                api.callbacks.get(EventKey(id = id ?: "", name = "onAdLoaded", type = EventType.INTERSTITIAL.toString()))?.success(response)
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
                val builder = Yandex.EventResponse.Builder()
                builder.setCode(error.code.toLong())
                builder.setDescription(error.description)

                val response = builder.build()
                api.callbacks.get(EventKey(id = id ?: "", name = "onAdFailedToLoad", type = EventType.INTERSTITIAL.toString()))?.success(response)
            }

            override fun onAdShown() {
            }

            override fun onAdDismissed() {
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
    }


    override fun load() {
        Log.d("interstitial", "load")

        val request = AdRequest.Builder().build()
        interstitial.loadAd(request)
    }

    override fun show() {
        interstitial.show()
    }
}