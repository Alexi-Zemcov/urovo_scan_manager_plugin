import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:urovo_scan_manager/dto/barcode_dto.dart';
import 'package:urovo_scan_manager/enums/beep_sound.dart';
import 'package:urovo_scan_manager/enums/output_mode.dart';
import 'package:urovo_scan_manager/urovo_scan_manager_platform_interface.dart';

/// An implementation of [UrovoScanManagerPlatform] that uses method channels.
class UrovoScanManagerMethodChannel extends UrovoScanManagerPlatform {
  /// The method channel used to interact with the native platform.
  final _methodChannel = const MethodChannel('urovo_scan_manager');

  final _barcode = StreamController<BarcodeDTO?>.broadcast();

  @override
  Stream<BarcodeDTO?> get barcode => _barcode.stream;

  UrovoScanManagerMethodChannel() {
    _methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'barcodeScanned':
          final barcode = BarcodeDTO.fromJson(Map<String, Object?>.from(call.arguments as Map));
          _barcode.add(barcode);
          break;
        default:
          throw UnimplementedError('Unimplemented method: ${call.method}');
      }
    });
  }

  @override
  void dispose() {
    _barcode.close();
  }

  @override
  Future<bool?> switchOutputMode(OutputMode mode) async {
    return _methodChannel.invokeMethod<bool>('switchOutputMode', mode.value);
  }

  @override
  Future<OutputMode?> getOutputMode() async {
    final result = await _methodChannel.invokeMethod<int>('getOutputMode');
    return result == null ? null : OutputMode.values.firstWhereOrNull((e) => e.value == result);
  }

  @override
  Future<bool?> getScannerState() async {
    return _methodChannel.invokeMethod<bool>('getScannerState');
  }

  @override
  Future<bool?> openScanner() async {
    return _methodChannel.invokeMethod<bool>('openScanner');
  }

  @override
  Future<bool?> closeScanner() async {
    return _methodChannel.invokeMethod<bool>('closeScanner');
  }

  @override
  void startListening() {
    _methodChannel.invokeMethod<void>('startListening');
  }

  @override
  void stopListening() {
    _methodChannel.invokeMethod<void>('stopListening');
  }

  @override
  Future<int?> switchBeepSound({required BeepSound beepSounb}) {
    return _methodChannel.invokeMethod<int>('switchBeepSound', beepSounb.index);
  }

  @override
  Future<BeepSound?> getBeepSoundState() async {
    final index = await _methodChannel.invokeMethod<int>('getBeepSoundState');
    return BeepSound.values.firstWhereOrNull((e) => e.value == index);
  }
}
