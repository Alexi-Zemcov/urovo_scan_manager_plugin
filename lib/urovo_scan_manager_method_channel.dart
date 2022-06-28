import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:urovo_scan_manager/dto/barcode_dto.dart';

import 'urovo_scan_manager_platform_interface.dart';

/// An implementation of [UrovoScanManagerPlatform] that uses method channels.
class UrovoScanManagerMethodChannel extends UrovoScanManagerPlatform {
  final _barcode = ValueNotifier<BarcodeDTO?>(null);

  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('urovo_scan_manager');

  UrovoScanManagerMethodChannel() {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'barcodeScanned':
          final jsonMap = jsonDecode(call.arguments);
          _barcode.value = BarcodeDTO.fromJson(jsonMap);
          break;
        default:
          throw UnimplementedError('Unimplemented method: ${call.method}');
      }
    });
  }

  @override
  ValueListenable<BarcodeDTO?> get barcode => _barcode;

  @override
  Future<int?> getOutputMode() async {
    return await methodChannel.invokeMethod<int>('getOutputMode');
  }

  @override
  Future<bool?> getScannerState() async {
    return await methodChannel.invokeMethod<bool>('getScannerState');
  }

  @override
  Future<bool?> openScanner() async {
    return await methodChannel.invokeMethod<bool>('openScanner');
  }

  @override
  Future<bool?> closeScanner() async {
    return await methodChannel.invokeMethod<bool>('closeScanner');
  }

  @override
  Future<bool?> startListening() async {
    return await methodChannel.invokeMethod<bool>('startListening');
  }

  @override
  Future<bool?> stopListening() async {
    return await methodChannel.invokeMethod<bool>('stopListening');
  }
}
