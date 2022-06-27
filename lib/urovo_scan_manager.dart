import 'urovo_scan_manager_platform_interface.dart';

class UrovoScanManager {
  /// Get the current scan result output mode.
  ///
  /// Parameters:
  /// 0 if the barcode is sent as intent,
  /// 1 if barcode is sent to the text box in focus. Default 1.
  ///
  /// P.S. Однажды этот метод присылал 16843134, после переключения режим через настройки
  /// стал присылать 0 и 1.
  Future<int> getOutputMode() {
    return UrovoScanManagerPlatform.instance.getOutputMode();
  }

  Future<bool> getScannerState() {
    return UrovoScanManagerPlatform.instance.getScannerState();
  }
}
