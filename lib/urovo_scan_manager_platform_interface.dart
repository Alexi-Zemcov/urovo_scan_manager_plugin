import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'urovo_scan_manager_method_channel.dart';

abstract class UrovoScanManagerPlatform extends PlatformInterface {
  /// Constructs a UrovoScanManagerPlatform.
  UrovoScanManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static UrovoScanManagerPlatform _instance = UrovoScanManagerMethodChannel();

  /// The default instance of [UrovoScanManagerPlatform] to use.
  ///
  /// Defaults to [UrovoScanManagerMethodChannel].
  static UrovoScanManagerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UrovoScanManagerPlatform] when
  /// they register themselves.
  static set instance(UrovoScanManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> share(String message) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
