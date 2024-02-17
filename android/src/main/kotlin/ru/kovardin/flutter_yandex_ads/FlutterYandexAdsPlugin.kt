package ru.kovardin.flutter_yandex_ads

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import ru.kovardin.flutter_yandex_ads.components.YandexAdsAppOpen
import ru.kovardin.flutter_yandex_ads.components.YandexAdsAppOpenCallbacks
import ru.kovardin.flutter_yandex_ads.components.YandexAdsBanner
import ru.kovardin.flutter_yandex_ads.components.YandexAdsInterstitial
import ru.kovardin.flutter_yandex_ads.pigeons.interstitial.YandexAdsInterstitial as Interstitial
import ru.kovardin.flutter_yandex_ads.pigeons.rewarded.YandexAdsRewarded as Rewarded
import ru.kovardin.flutter_yandex_ads.pigeons.appopen.YandexAdsAppOpen as AppOpen
import ru.kovardin.flutter_yandex_ads.pigeons.banner.YandexAdsBanner as Banner
import ru.kovardin.flutter_yandex_ads.pigeons.native.YandexAdsNative as Native
import ru.kovardin.flutter_yandex_ads.components.YandexAdsInterstitialCallbacks
import ru.kovardin.flutter_yandex_ads.components.YandexAdsNative
import ru.kovardin.flutter_yandex_ads.components.YandexAdsRewarded
import ru.kovardin.flutter_yandex_ads.components.YandexAdsRewardedCallbacks
import ru.kovardin.flutter_yandex_ads.views.YandexAdsBannerViewFactory
import ru.kovardin.flutter_yandex_ads.pigeons.YandexAdsApi
import ru.kovardin.flutter_yandex_ads.views.YandexAdsNativeViewFactory

/** FlutterYandexAdsPlugin */
class FlutterYandexAdsPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var context: Context
    private lateinit var activity: Activity
    private lateinit var messenger: BinaryMessenger
    private lateinit var appopen: YandexAdsAppOpenCallbacks
    private lateinit var interstitial: YandexAdsInterstitialCallbacks
    private lateinit var rewarded: YandexAdsRewardedCallbacks

    override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        messenger = binding.binaryMessenger
        context = binding.applicationContext

        appopen = YandexAdsAppOpenCallbacks(binding)
        interstitial = YandexAdsInterstitialCallbacks(binding)
        rewarded = YandexAdsRewardedCallbacks(binding)

        // api set
        val api = YandexApi(context)
        YandexAdsApi.setUp(messenger, api)


        val banner = YandexAdsBanner(context)
        val native = YandexAdsNative(context)

        // widgets
        binding.platformViewRegistry.registerViewFactory("yandex-ads-banner", YandexAdsBannerViewFactory(banner));
        binding.platformViewRegistry.registerViewFactory("yandex-ads-native", YandexAdsNativeViewFactory(native));

        // components
        Banner.setUp(messenger, banner)
        Native.setUp(messenger, native)

    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    }

    override fun onDetachedFromActivity() {
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity;

        val interstitial = YandexAdsInterstitial(context, activity, interstitial)
        val appopen = YandexAdsAppOpen(context, activity, appopen)
        val rewarded = YandexAdsRewarded(context, activity, rewarded)

        Interstitial.setUp(messenger, interstitial)
        AppOpen.setUp(messenger, appopen)
        Rewarded.setUp(messenger, rewarded)
    }

    override fun onDetachedFromActivityForConfigChanges() {
    }
}


