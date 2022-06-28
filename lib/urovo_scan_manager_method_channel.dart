import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:urovo_scan_manager/dto/barcode_dto.dart';
import 'package:urovo_scan_manager/enums/output_mode.dart';
import 'package:urovo_scan_manager/urovo_scan_manager_platform_interface.dart';

/// An implementation of [UrovoScanManagerPlatform] that uses method channels.
class UrovoScanManagerMethodChannel extends UrovoScanManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('urovo_scan_manager');

  final _barcode = ValueNotifier<BarcodeDTO?>(null);

  @override
  ValueListenable<BarcodeDTO?> get barcode => _barcode;

  UrovoScanManagerMethodChannel() {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'barcodeScanned':
          final jsonMap = jsonDecode(call.arguments.toString()) as Map<String, Object?>;
          _barcode.value = BarcodeDTO.fromJson(jsonMap);
          break;
        default:
          throw UnimplementedError('Unimplemented method: ${call.method}');
      }
    });
  }

  @override
  Future<bool?> switchOutputMode(OutoutMode mode) async {
    return methodChannel.invokeMethod<bool>('switchOutputMode', mode.value);
  }

  @override
  Future<OutoutMode?> getOutputMode() async {
    final result = await methodChannel.invokeMethod<int>('getOutputMode');
    return result == null ? null : OutoutMode.values.firstWhere((e) => e.value == result);
  }

  @override
  Future<bool?> getScannerState() async {
    return methodChannel.invokeMethod<bool>('getScannerState');
  }

  @override
  Future<bool?> openScanner() async {
    return methodChannel.invokeMethod<bool>('openScanner');
  }

  @override
  Future<bool?> closeScanner() async {
    return methodChannel.invokeMethod<bool>('closeScanner');
  }

  @override
  Future<void> startListening() async {
    await methodChannel.invokeMethod<void>('startListening');
  }

  @override
  Future<void> stopListening() async {
    await methodChannel.invokeMethod<void>('stopListening');
  }
}
