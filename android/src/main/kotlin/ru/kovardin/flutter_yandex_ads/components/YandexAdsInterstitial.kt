package ru.kovardin.flutter_yandex_ads.components

import android.util.Log
import ru.kovardin.flutter_yandex_ads.pigeons.Interstitial

class YandexAdsInterstitial : Interstitial.YandexAdsInterstitial {
    override fun load() {
        Log.d("interstitial", "load")
    }
}