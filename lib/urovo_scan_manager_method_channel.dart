import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'urovo_scan_manager_platform_interface.dart';

/// An implementation of [UrovoScanManagerPlatform] that uses method channels.
class UrovoScanManagerMethodChannel extends UrovoScanManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('urovo_scan_manager');

  @override
  Future<int> getOutputMode() async {
    return await methodChannel.invokeMethod<int>('getOutputMode') as int;
  }

  @override
  Future<bool> getScannerState() async {
    return await methodChannel.invokeMethod<int>('getScannerState') as bool;
  }
}
