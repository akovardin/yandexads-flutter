import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/pigeons/native.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/ru/kovardin/flutter_yandex_ads/pigeons/native/Native.kt',
  kotlinOptions: KotlinOptions(
    package: 'ru.kovardin.flutter_yandex_ads.pigeons.native',
  ),
  dartPackageName: 'flutter_yandex_ads',
  swiftOut: 'ios/Classes/pigeons/Native.g.swift',
  swiftOptions: SwiftOptions(),
))
class NativeError {
  late int code;
  late String description;
}

class NativeImpression {
  late String data;
}

@HostApi()
abstract class YandexAdsNative {
  void make(String id);

  void load(String id, int width, int height);

  @async
  void onAdLoaded(String id);

  @async
  NativeError onAdFailedToLoad(String id);

  @async
  void onAdClicked(String id);

  @async
  void onLeftApplication(String id);

  @async
  void onReturnedToApplication(String id);

  @async
  NativeImpression onImpression(String id);
}
