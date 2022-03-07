package ru.kovardin.flutter_yandex_ads

import android.content.Context
import android.util.Log
import com.yandex.mobile.ads.common.InitializationListener
import com.yandex.mobile.ads.common.MobileAds
import ru.kovardin.flutter_yandex_ads.pigeons.Yandex

// https://stackoverflow.com/questions/60048704/how-to-get-activity-and-context-in-flutter-plugin
class YandexApi(private val context: Context): Yandex.YandexAdsApi {
    override fun initialize() {
        MobileAds.initialize(context, InitializationListener {
            Log.d("initialize", "initialize");
        })
    }
}
