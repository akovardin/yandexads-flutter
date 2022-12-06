import 'package:pigeon/pigeon.dart';

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
