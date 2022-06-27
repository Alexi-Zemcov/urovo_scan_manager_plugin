import 'urovo_scan_manager_platform_interface.dart';

class UrovoScanManager {
  Future<String?> getPlatformVersion() {
    return UrovoScanManagerPlatform.instance.getPlatformVersion();
  }

  Future<void> share(String message) {
    return UrovoScanManagerPlatform.instance.share(message);
  }
}
