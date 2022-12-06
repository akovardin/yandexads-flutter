package ru.kovardin.flutter_yandex_ads

import android.app.Activity
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import ru.kovardin.flutter_yandex_ads.components.YandexAdsBanner
import ru.kovardin.flutter_yandex_ads.components.YandexAdsInterstitial
import ru.kovardin.flutter_yandex_ads.components.YandexAdsNative
import ru.kovardin.flutter_yandex_ads.components.YandexAdsRewarded
import ru.kovardin.flutter_yandex_ads.pigeons.Banner
import ru.kovardin.flutter_yandex_ads.pigeons.Interstitial
import ru.kovardin.flutter_yandex_ads.pigeons.Native
import ru.kovardin.flutter_yandex_ads.pigeons.Rewarded
import ru.kovardin.flutter_yandex_ads.views.YandexAdsBannerViewFactory
import ru.kovardin.flutter_yandex_ads.pigeons.Yandex
import ru.kovardin.flutter_yandex_ads.views.YandexAdsNativeViewFactory

/** FlutterYandexAdsPlugin */
class FlutterYandexAdsPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var context: Context
  private lateinit var activity: Activity

  override fun onAttachedToEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    context = binding.applicationContext

    // api set
    val api = YandexApi(context)
    Yandex.YandexAdsApi.setup(binding.binaryMessenger, api)

    val interstitial = YandexAdsInterstitial(context)
    val rewarded = YandexAdsRewarded(context)
    val banner = YandexAdsBanner(context)
    val native = YandexAdsNative(context)

    // components
    Interstitial.YandexAdsInterstitial.setup(binding.binaryMessenger, interstitial)
    Rewarded.YandexAdsRewarded.setup(binding.binaryMessenger, rewarded)
    Banner.YandexAdsBanner.setup(binding.binaryMessenger, banner)
    Native.YandexAdsNative.setup(binding.binaryMessenger, native)

    // widgets
    binding.platformViewRegistry.registerViewFactory("yandex-ads-banner", YandexAdsBannerViewFactory(banner));
    binding.platformViewRegistry.registerViewFactory("yandex-ads-native", YandexAdsNativeViewFactory(native));
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
  }

  override fun onDetachedFromActivityForConfigChanges() {
  }
}


