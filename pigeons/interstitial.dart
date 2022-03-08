import 'package:pigeon/pigeon.dart';

@HostApi()
abstract class YandexAdsInterstitial {
  void config(String id);
  void load();
  void show();
}
