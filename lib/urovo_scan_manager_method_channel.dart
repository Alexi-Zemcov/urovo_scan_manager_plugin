import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'urovo_scan_manager_platform_interface.dart';

/// An implementation of [UrovoScanManagerPlatform] that uses method channels.
class UrovoScanManagerMethodChannel extends UrovoScanManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('urovo_scan_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> share(String message) {
    return methodChannel.invokeMethod<void>('share', {'message': message});
  }
}
