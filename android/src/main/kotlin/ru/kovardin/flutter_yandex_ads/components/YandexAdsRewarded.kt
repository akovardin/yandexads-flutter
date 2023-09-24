package ru.kovardin.flutter_yandex_ads.components

import android.app.Activity
import android.content.Context
import com.yandex.mobile.ads.common.AdError
import com.yandex.mobile.ads.common.AdRequestConfiguration
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.rewarded.Reward
import com.yandex.mobile.ads.rewarded.RewardedAd
import com.yandex.mobile.ads.rewarded.RewardedAdEventListener
import com.yandex.mobile.ads.rewarded.RewardedAdLoadListener
import com.yandex.mobile.ads.rewarded.RewardedAdLoader
import ru.kovardin.flutter_yandex_ads.pigeons.Rewarded

data class RewardedData(
    var rewarded: RewardedAd? = null,
    var loader: RewardedAdLoader? = null,
    var onAdLoaded: Rewarded.Result<Void>? = null,
    var onAdFailedToLoad: Rewarded.Result<Rewarded.RewardedError>? = null,
    var onAdFailedToShow: Rewarded.Result<Rewarded.RewardedError>? = null,
    var onAdShown: Rewarded.Result<Void>? = null,
    var onAdDismissed: Rewarded.Result<Void>? = null,
    var onAdClicked: Rewarded.Result<Void>? = null,
    var onImpression: Rewarded.Result<Rewarded.RewardedImpression>? = null,
    var onRewarded: Rewarded.Result<Rewarded.RewardedEvent>? = null,
)

class YandexAdsRewarded(private val context: Context, private val activity: Activity): Rewarded.YandexAdsRewarded {
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
                    ad.onAdLoaded?.success(null)

                    rewarded.setAdEventListener(object : RewardedAdEventListener {
                        override fun onAdShown() {
                            ad.onAdShown?.success(null)
                        }

                        override fun onAdFailedToShow(error: AdError) {
                            val err = Rewarded.RewardedError.Builder()
                            err.setCode(0)
                            err.setDescription(error.description)

                            ad.onAdFailedToShow?.success(err.build())
                        }

                        override fun onAdDismissed() {
                            ad.onAdDismissed?.success(null)
                        }

                        override fun onAdClicked() {
                            ad.onAdClicked?.success(null)
                        }

                        override fun onAdImpression(data: ImpressionData?) {
                            val builder = Rewarded.RewardedImpression.Builder()
                            builder.setData(data?.rawData ?: "")
                            ad.onImpression?.success(builder.build())
                        }

                        override fun onRewarded(r: Reward) {
                            val builder = Rewarded.RewardedEvent.Builder()
                            builder.setAmount(r.amount.toLong())
                            builder.setType(r.type)
                            ad.onRewarded?.success(builder.build())
                        }
                    })
                }

                override fun onAdFailedToLoad(error: AdRequestError) {
                    val err = Rewarded.RewardedError.Builder()
                    err.setCode(error.code.toLong())
                    err.setDescription(error.description)

                    ad.onAdFailedToLoad?.success(err.build())
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

    override fun onAdLoaded(id: String, result: Rewarded.Result<Void>) {
        rewards[id]?.onAdLoaded = result
    }

    override fun onAdFailedToLoad(id: String, result: Rewarded.Result<Rewarded.RewardedError>) {
        rewards[id]?.onAdFailedToLoad = result
    }

    override fun onAdFailedToShow(id: String, result: Rewarded.Result<Rewarded.RewardedError>) {
        rewards[id]?.onAdFailedToLoad = result
    }

    override fun onAdShown(id: String, result: Rewarded.Result<Void>) {
        rewards[id]?.onAdShown = result
    }

    override fun onAdDismissed(id: String, result: Rewarded.Result<Void>) {
        rewards[id]?.onAdDismissed = result
    }

    override fun onAdClicked(id: String, result: Rewarded.Result<Void>) {
        rewards[id]?.onAdClicked = result
    }

    override fun onImpression(
        id: String,
        result: Rewarded.Result<Rewarded.RewardedImpression>
    ) {
        rewards[id]?.onImpression = result
    }

    override fun onRewarded(id: String, result: Rewarded.Result<Rewarded.RewardedEvent>) {
        rewards[id]?.onRewarded = result
    }
}