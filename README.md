# flutter_yandex_ads

Yandex ADS package

## Getting Started

Add to AndroidManifest.xml

```xml
<uses-permission android:name="com.google.android.gms.permission.AD_ID" tools:node="remove"/>
```


## Advanced development

Generate pigeons files fo

```
flutter pub run pigeon \
  --input pigeons/yandex.dart \
  --dart_out lib/pigeons/yandex.dart \
  --java_out ./android/src/main/kotlin/ru/kovardin/flutter_yandex_ads/pigeons/Yandex.java \
  --java_package "ru.kovardin.flutter_yandex_ads.pigeons"
