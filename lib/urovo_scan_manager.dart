import 'package:flutter/foundation.dart';

import 'urovo_scan_manager_platform_interface.dart';

class UrovoScanManager {
  ValueListenable<Map<String, dynamic>?> get barcode => UrovoScanManagerPlatform.instance.barcode;

  /// Get the current scan result output mode.
  ///
  /// Parameters:
  /// 0 if the barcode is sent as intent,
  /// 1 if barcode is sent to the text box in focus. Default 1.
  ///
  /// P.S. Однажды этот метод присылал 16843134, после переключения режим через настройки
  /// стал присылать 0 и 1.
  Future<int?> getOutputMode() {
    return UrovoScanManagerPlatform.instance.getOutputMode();
  }

  /// Get the scanner power states.
  ///
  /// True if the scanner power on, false if power off.
  Future<bool?> getScannerState() {
    return UrovoScanManagerPlatform.instance.getScannerState();
  }

  Future<void> openScanner() {
    return UrovoScanManagerPlatform.instance.openScanner();
  }

  Future<void> closeScanner() {
    return UrovoScanManagerPlatform.instance.closeScanner();
  }

  Future<void> startListening() {
    return UrovoScanManagerPlatform.instance.startListening();
  }

  Future<void> stopListening() {
    return UrovoScanManagerPlatform.instance.stopListening();
  }
}
