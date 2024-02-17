package ru.kovardin.flutter_yandex_ads.components

import android.app.Activity
import android.content.Context
import com.yandex.mobile.ads.common.AdError
import com.yandex.mobile.ads.common.AdRequestConfiguration
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.interstitial.InterstitialAd
import com.yandex.mobile.ads.interstitial.InterstitialAdLoader
import com.yandex.mobile.ads.rewarded.Reward
import com.yandex.mobile.ads.rewarded.RewardedAd
import com.yandex.mobile.ads.rewarded.RewardedAdEventListener
import com.yandex.mobile.ads.rewarded.RewardedAdLoadListener
import com.yandex.mobile.ads.rewarded.RewardedAdLoader
import io.flutter.embedding.engine.plugins.FlutterPlugin
import ru.kovardin.flutter_yandex_ads.pigeons.interstitial.FlutterYandexAdsInterstitial
import ru.kovardin.flutter_yandex_ads.pigeons.interstitial.InterstitialError
import ru.kovardin.flutter_yandex_ads.pigeons.interstitial.InterstitialImpression
import ru.kovardin.flutter_yandex_ads.pigeons.rewarded.FlutterYandexAdsRewarded
import ru.kovardin.flutter_yandex_ads.pigeons.rewarded.RewardedError
import ru.kovardin.flutter_yandex_ads.pigeons.rewarded.RewardedEvent
import ru.kovardin.flutter_yandex_ads.pigeons.rewarded.RewardedImpression

import ru.kovardin.flutter_yandex_ads.pigeons.rewarded.YandexAdsRewarded as Rewarded

data class RewardedData(
    var rewarded: RewardedAd? = null,
    var loader: RewardedAdLoader? = null,
)

class YandexAdsRewarded(private val context: Context, private val activity: Activity, private val callbacks: YandexAdsRewardedCallbacks): Rewarded {
    private var rewards: MutableMap<String, RewardedData> = mutableMapOf()

    override fun make(id: String) {
        val loader = RewardedAdLoader(context)
        val ad = RewardedData(loader = loader)

        ad.loader?.apply {
            setAdLoadListener(object : RewardedAdLoadListener {
                override fun onAdLoaded(rewarded: RewardedAd) {
                    // save rewardedAd to a local variable
                    // now rewardedAd is ready to show
                    ad.rewarded = rewarded
                    callbacks.onAdLoaded(id)

                    rewarded.setAdEventListener(object : RewardedAdEventListener {
                        override fun onAdShown() {
                            callbacks.onAdShown(id)
                        }

                        override fun onAdFailedToShow(error: AdError) {
                            val err = RewardedError(
                                code = 0,
                                description = error.description,
                            )

                            callbacks.onAdFailedToShow(id, err)
                        }

                        override fun onAdDismissed() {
                            callbacks.onAdDismissed(id)
                        }

                        override fun onAdClicked() {
                            callbacks.onAdClicked(id)
                        }

                        override fun onAdImpression(data: ImpressionData?) {
                            val imp = RewardedImpression(
                                data = data?.rawData.orEmpty()
                            )

                            callbacks.onImpression(id, imp)
                        }

                        override fun onRewarded(r: Reward) {
                            val rew = RewardedEvent(
                                amount = r.amount.toLong(),
                                type = r.type,
                            )

                            callbacks.onRewarded(id, rew)

                        }
                    })
                }

                override fun onAdFailedToLoad(error: AdRequestError) {
                    val err = RewardedError(
                        code = error.code.toLong(),
                        description = error.description,
                    )

                    callbacks.onAdFailedToLoad(id, err)
                }
            })
        }

        rewards.put(id, ad)
    }

    override fun load(id: String) {
        if (!rewards.containsKey(id)) {
            return
        }

        rewards[id]?.loader?.loadAd(AdRequestConfiguration.Builder(id).build())
    }

    override fun show(id: String) {
        rewards[id]?.rewarded?.show(activity)
    }
}


class YandexAdsRewardedCallbacks(binding: FlutterPlugin.FlutterPluginBinding) {

    var api: FlutterYandexAdsRewarded? = null

    init {
        api = FlutterYandexAdsRewarded(binding.getBinaryMessenger())
    }

    fun onAdLoaded(id: String) {
        api?.onAdLoaded(id) {}
    }

    fun onAdFailedToLoad(id: String,  error: RewardedError) {
        api?.onAdFailedToLoad(id, error) {}
    }

    fun onAdFailedToShow(id: String, error: RewardedError) {
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

    fun onImpression(id: String, data: RewardedImpression) {
        api?.onImpression(id, data) {}
    }

    fun onRewarded(id: String, data: RewardedEvent) {
        api?.onRewarded(id, data) {}
    }
}