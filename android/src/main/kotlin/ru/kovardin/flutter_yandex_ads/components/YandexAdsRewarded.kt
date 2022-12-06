package ru.kovardin.flutter_yandex_ads.components

import android.content.Context
import com.yandex.mobile.ads.common.AdRequest
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import com.yandex.mobile.ads.rewarded.Reward
import com.yandex.mobile.ads.rewarded.RewardedAd
import com.yandex.mobile.ads.rewarded.RewardedAdEventListener
import ru.kovardin.flutter_yandex_ads.pigeons.Rewarded

data class RewardedData(
    var ad: RewardedAd,
    var onAdLoaded: Rewarded.Result<Void>? = null,
    var onAdFailedToLoad: Rewarded.Result<Rewarded.RewardedError>? = null,
    var onAdShown: Rewarded.Result<Void>? = null,
    var onAdDismissed: Rewarded.Result<Void>? = null,
    var onAdClicked: Rewarded.Result<Void>? = null,
    var onLeftApplication: Rewarded.Result<Void>? = null,
    var onReturnedToApplication: Rewarded.Result<Void>? = null,
    var onImpression: Rewarded.Result<Rewarded.RewardedImpression>? = null,
    var onRewarded: Rewarded.Result<Rewarded.RewardedEvent>? = null,
)

class YandexAdsRewarded(private val context: Context): Rewarded.YandexAdsRewarded {
    private var rewards: MutableMap<String, RewardedData> = mutableMapOf()

    override fun make(id: String) {
        val interstitial = RewardedData(ad = RewardedAd(context))

        interstitial.ad.setAdUnitId(id)
        interstitial.ad.setRewardedAdEventListener(object : RewardedAdEventListener {
            override fun onAdLoaded() {
                interstitial.onAdLoaded?.success(null)
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
                val err = Rewarded.RewardedError.Builder()
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
                val builder = Rewarded.RewardedImpression.Builder()
                builder.setData(data?.rawData ?: "")
                interstitial.onImpression?.success(builder.build())
            }

            override fun onRewarded(r: Reward) {
                val builder = Rewarded.RewardedEvent.Builder()
                builder.setAmount(r.amount.toLong())
                builder.setType(r.type)
                interstitial.onRewarded?.success(builder.build())
            }
        })

        rewards.put(id, interstitial)
    }

    override fun load(id: String) {
        if (!rewards.containsKey(id)) {
            return
        }

        val request = AdRequest.Builder().build()
        rewards[id]?.ad?.loadAd(request)
    }

    override fun show(id: String) {
        rewards[id]?.ad?.show()
    }

    override fun onAdLoaded(id: String, result: Rewarded.Result<Void>?) {
        rewards[id]?.onAdLoaded = result
    }

    override fun onAdFailedToLoad(id: String, result: Rewarded.Result<Rewarded.RewardedError>?) {
        rewards[id]?.onAdFailedToLoad = result
    }

    override fun onAdShown(id: String, result: Rewarded.Result<Void>?) {
        rewards[id]?.onAdShown = result
    }

    override fun onAdDismissed(id: String, result: Rewarded.Result<Void>?) {
        rewards[id]?.onAdDismissed = result
    }

    override fun onAdClicked(id: String, result: Rewarded.Result<Void>?) {
        rewards[id]?.onAdClicked = result
    }

    override fun onLeftApplication(id: String, result: Rewarded.Result<Void>?) {
        rewards[id]?.onLeftApplication = result
    }

    override fun onReturnedToApplication(id: String, result: Rewarded.Result<Void>?) {
        rewards[id]?.onReturnedToApplication = result
    }

    override fun onImpression(
        id: String,
        result: Rewarded.Result<Rewarded.RewardedImpression>?
    ) {
        rewards[id]?.onImpression = result
    }

    override fun onRewarded(id: String, result: Rewarded.Result<Rewarded.RewardedEvent>?) {
        rewards[id]?.onRewarded = result
    }
}