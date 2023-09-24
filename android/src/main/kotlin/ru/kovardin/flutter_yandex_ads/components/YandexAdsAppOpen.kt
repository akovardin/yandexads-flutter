package ru.kovardin.flutter_yandex_ads.components

import android.app.Activity
import android.content.Context
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.ProcessLifecycleOwner
import com.yandex.mobile.ads.appopenad.AppOpenAd
import com.yandex.mobile.ads.appopenad.AppOpenAdEventListener
import com.yandex.mobile.ads.appopenad.AppOpenAdLoadListener
import com.yandex.mobile.ads.appopenad.AppOpenAdLoader
import com.yandex.mobile.ads.common.AdError
import com.yandex.mobile.ads.common.AdRequestConfiguration
import com.yandex.mobile.ads.common.AdRequestError
import com.yandex.mobile.ads.common.ImpressionData
import io.flutter.embedding.engine.plugins.FlutterPlugin
import ru.kovardin.flutter_yandex_ads.pigeons.AppOpen
import ru.kovardin.flutter_yandex_ads.pigeons.AppOpen.AppOpenError
import ru.kovardin.flutter_yandex_ads.pigeons.AppOpen.AppOpenImpression
import ru.kovardin.flutter_yandex_ads.pigeons.AppOpen.FlutterYandexAdsAppOpen

class YandexAdsAppOpen(private val context: Context, private val activity: Activity, private val callbacks: YandexAdsAppOpenCallbacks) : AppOpen.YandexAdsAppOpen {

    private var ad: AppOpenAd? = null
    override fun make(id: String) {
        val loader = AppOpenAdLoader(context)
        loader.setAdLoadListener(object : AppOpenAdLoadListener {
            override fun onAdLoaded(appOpenAd: AppOpenAd) {
                // The ad was loaded successfully. Now you can show loaded ad.
                ad = appOpenAd

                callbacks.onAdLoaded(id)

                ad?.setAdEventListener(object : AppOpenAdEventListener {
                    override fun onAdShown() {
                        callbacks.onAdShown(id)
                    }

                    override fun onAdFailedToShow(error: AdError) {
                        val err = AppOpenError.Builder()
                        err.setCode(0)
                        err.setDescription(error.description)

                        callbacks.onAdFailedToShow(id, err.build())
                    }

                    override fun onAdDismissed() {
                        callbacks.onAdDismissed(id)

                        clear()
                        make(id)
                    }

                    override fun onAdClicked() {
                        callbacks.onAdClicked(id)
                    }

                    override fun onAdImpression(data: ImpressionData?) {
                        val builder = AppOpenImpression.Builder()
                        builder.setData(data?.rawData ?: "")

                        callbacks.onImpression(id, builder.build())
                    }
                })
            }

            override fun onAdFailedToLoad(error: AdRequestError) {
                val err = AppOpenError.Builder()
                err.setCode(error.code.toLong())
                err.setDescription(error.description)

                callbacks.onAdFailedToLoad(id, err.build())
            }
        })

        // для отладки можно использовать "demo-appopenad-yandex"
        loader.loadAd(AdRequestConfiguration.Builder(id).build())

        val processLifecycleObserver = DefaultProcessLifecycleObserver(
            onProcessCameForeground = ::showAppOpenAd
        )

        ProcessLifecycleOwner.get().lifecycle.addObserver(processLifecycleObserver)
    }

    private fun showAppOpenAd() {
        ad?.show(activity)
    }

    private fun clear() {
        ad?.setAdEventListener(null)
        ad = null
    }
}

class DefaultProcessLifecycleObserver(
    private val onProcessCameForeground: () -> Unit
) : DefaultLifecycleObserver {

    override fun onStart(owner: LifecycleOwner) {
        onProcessCameForeground()
    }
}

class YandexAdsAppOpenCallbacks(binding: FlutterPlugin.FlutterPluginBinding) {

    var api: FlutterYandexAdsAppOpen? = null

    init {
        api = FlutterYandexAdsAppOpen(binding.getBinaryMessenger())
    }

    fun onAdLoaded(id: String) {
        api?.onAdLoaded(id) {}
    }

    fun onAdFailedToLoad(id: String,  error: AppOpenError) {
        api?.onAdFailedToLoad(id, error) {}
    }

    fun onAdFailedToShow(id: String, error: AppOpenError) {
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

    fun onImpression(id: String, data: AppOpenImpression) {
        api?.onImpression(id, data) {}
    }
}