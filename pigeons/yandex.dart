import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeons/yandex.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/ru/kovardin/flutter_yandex_ads/pigeons/Yandex.kt',
  kotlinOptions: KotlinOptions(
    package: 'ru.kovardin.flutter_yandex_ads.pigeons',
  ),
  dartPackageName: 'flutter_yandex_ads',
  swiftOut: 'ios/Classes/pigeons/Yandex.g.swift',
  swiftOptions: SwiftOptions(),
))
@HostApi()
abstract class YandexAdsApi {
  void initialize();
}
