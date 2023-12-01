import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_yandex_ads_method_channel.dart';

abstract class FlutterYandexAdsPlatform extends PlatformInterface {
  /// Constructs a FlutterYandexAdsPlatform.
  FlutterYandexAdsPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterYandexAdsPlatform _instance = MethodChannelFlutterYandexAds();

  /// The default instance of [FlutterYandexAdsPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterYandexAds].
  static FlutterYandexAdsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterYandexAdsPlatform] when
  /// they register themselves.
  static set instance(FlutterYandexAdsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
