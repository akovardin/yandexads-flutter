import 'package:pigeon/pigeon.dart';

class BannerError {
  late int code;
  late String description;
}

class BannerImpression {
  late String data;
}

@HostApi()
abstract class YandexAdsBanner {
  void make(String id, int width, int height);

  void load(String id);

  @async
  void onAdLoaded(String id);

  @async
  BannerError onAdFailedToLoad(String id);

  @async
  void onAdClicked(String id);

  @async
  void onLeftApplication(String id);

  @async
  void onReturnedToApplication(String id);

  @async
  BannerImpression onImpression(String id);
}
