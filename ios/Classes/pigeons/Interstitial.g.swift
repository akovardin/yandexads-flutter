// Autogenerated from Pigeon (v14.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation
#if os(iOS)
import Flutter
#elseif os(macOS)
import FlutterMacOS
#else
#error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)"
  ]
}

private func createConnectionError(withChannelName channelName: String) -> FlutterError {
  return FlutterError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct InterstitialError {
  var code: Int64
  var description: String

  static func fromList(_ list: [Any?]) -> InterstitialError? {
    let code = list[0] is Int64 ? list[0] as! Int64 : Int64(list[0] as! Int32)
    let description = list[1] as! String

    return InterstitialError(
      code: code,
      description: description
    )
  }
  func toList() -> [Any?] {
    return [
      code,
      description,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct InterstitialImpression {
  var data: String

  static func fromList(_ list: [Any?]) -> InterstitialImpression? {
    let data = list[0] as! String

    return InterstitialImpression(
      data: data
    )
  }
  func toList() -> [Any?] {
    return [
      data,
    ]
  }
}
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol YandexAdsInterstitial {
  func make(id: String) throws
  func load(id: String) throws
  func show(id: String) throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class YandexAdsInterstitialSetup {
  /// The codec used by YandexAdsInterstitial.
  /// Sets up an instance of `YandexAdsInterstitial` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: YandexAdsInterstitial?) {
    let makeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_yandex_ads.YandexAdsInterstitial.make", binaryMessenger: binaryMessenger)
    if let api = api {
      makeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          try api.make(id: idArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      makeChannel.setMessageHandler(nil)
    }
    let loadChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_yandex_ads.YandexAdsInterstitial.load", binaryMessenger: binaryMessenger)
    if let api = api {
      loadChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          try api.load(id: idArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      loadChannel.setMessageHandler(nil)
    }
    let showChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_yandex_ads.YandexAdsInterstitial.show", binaryMessenger: binaryMessenger)
    if let api = api {
      showChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          try api.show(id: idArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      showChannel.setMessageHandler(nil)
    }
  }
}
private class FlutterYandexAdsInterstitialCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
      case 128:
        return InterstitialError.fromList(self.readValue() as! [Any?])
      case 129:
        return InterstitialImpression.fromList(self.readValue() as! [Any?])
      default:
        return super.readValue(ofType: type)
    }
  }
}

private class FlutterYandexAdsInterstitialCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? InterstitialError {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? InterstitialImpression {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class FlutterYandexAdsInterstitialCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return FlutterYandexAdsInterstitialCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return FlutterYandexAdsInterstitialCodecWriter(data: data)
  }
}

class FlutterYandexAdsInterstitialCodec: FlutterStandardMessageCodec {
  static let shared = FlutterYandexAdsInterstitialCodec(readerWriter: FlutterYandexAdsInterstitialCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol FlutterYandexAdsInterstitialProtocol {
  func onAdLoaded(id idArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onAdFailedToLoad(id idArg: String, err errArg: InterstitialError, completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onAdFailedToShow(id idArg: String, err errArg: InterstitialError, completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onAdShown(id idArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onAdDismissed(id idArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onAdClicked(id idArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onImpression(id idArg: String, data dataArg: InterstitialImpression, completion: @escaping (Result<Void, FlutterError>) -> Void)
}
class FlutterYandexAdsInterstitial: FlutterYandexAdsInterstitialProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger){
    self.binaryMessenger = binaryMessenger
  }
  var codec: FlutterStandardMessageCodec {
    return FlutterYandexAdsInterstitialCodec.shared
  }
  func onAdLoaded(id idArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.flutter_yandex_ads.FlutterYandexAdsInterstitial.onAdLoaded"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([idArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName:channelName)))
        return
      }
      if (listResponse.count > 1) {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)));
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onAdFailedToLoad(id idArg: String, err errArg: InterstitialError, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.flutter_yandex_ads.FlutterYandexAdsInterstitial.onAdFailedToLoad"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([idArg, errArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName:channelName)))
        return
      }
      if (listResponse.count > 1) {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)));
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onAdFailedToShow(id idArg: String, err errArg: InterstitialError, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.flutter_yandex_ads.FlutterYandexAdsInterstitial.onAdFailedToShow"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([idArg, errArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName:channelName)))
        return
      }
      if (listResponse.count > 1) {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)));
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onAdShown(id idArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.flutter_yandex_ads.FlutterYandexAdsInterstitial.onAdShown"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([idArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName:channelName)))
        return
      }
      if (listResponse.count > 1) {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)));
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onAdDismissed(id idArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.flutter_yandex_ads.FlutterYandexAdsInterstitial.onAdDismissed"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([idArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName:channelName)))
        return
      }
      if (listResponse.count > 1) {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)));
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onAdClicked(id idArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.flutter_yandex_ads.FlutterYandexAdsInterstitial.onAdClicked"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([idArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName:channelName)))
        return
      }
      if (listResponse.count > 1) {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)));
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onImpression(id idArg: String, data dataArg: InterstitialImpression, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.flutter_yandex_ads.FlutterYandexAdsInterstitial.onImpression"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([idArg, dataArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName:channelName)))
        return
      }
      if (listResponse.count > 1) {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)));
      } else {
        completion(.success(Void()))
      }
    }
  }
}
