package ru.kovardin.flutter_yandex_ads

import android.content.Context
import android.util.Log
import com.yandex.mobile.ads.common.InitializationListener
import com.yandex.mobile.ads.common.MobileAds
import ru.kovardin.flutter_yandex_ads.pigeons.Yandex

class YandexApi(private val context: Context): Yandex.YandexAdsApi {

    override fun initialize() {
        MobileAds.enableDebugErrorIndicator(true);
        MobileAds.enableLogging(true);
        MobileAds.initialize(context) {
            Log.d("initialize", "initialize");
        }
    }
}
