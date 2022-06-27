import 'package:flutter/foundation.dart';
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

  /// Считанный баркод
  ValueListenable<Map<String, Object?>?> get barcode;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UrovoScanManagerPlatform] when
  /// they register themselves.
  static set instance(UrovoScanManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Get the current scan result output mode.
  ///
  /// Parameters:
  /// 0 if the barcode is sent as intent,
  /// 1 if barcode is sent to the text box in focus. Default 1.
  ///
  /// P.S. Однажды этот метод присылал 16843134, после переключения режим через настройки
  /// стал присылать 0 и 1
  Future<int?> getOutputMode() {
    throw UnimplementedError('getOutputMode() has not been implemented.');
  }

  /// Get the scanner power states.
  ///
  /// True if the scanner power on, false if power off.
  Future<bool?> getScannerState() {
    throw UnimplementedError('getScannerState() has not been implemented.');
  }

  Future<void> openScanner() {
    throw UnimplementedError('openScanner() has not been implemented.');
  }

  Future<void> closeScanner() {
    throw UnimplementedError('closeScanner() has not been implemented.');
  }

  Future<void> startListening() {
    throw UnimplementedError('startListening() has not been implemented.');
  }

  Future<void> stopListening() {
    throw UnimplementedError('stopListening() has not been implemented.');
  }
}
