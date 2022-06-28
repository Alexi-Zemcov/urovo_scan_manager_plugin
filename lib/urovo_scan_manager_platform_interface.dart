import 'package:flutter/foundation.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:urovo_scan_manager/dto/barcode_dto.dart';
import 'package:urovo_scan_manager/enums/output_mode.dart';
import 'package:urovo_scan_manager/urovo_scan_manager_method_channel.dart';

abstract class UrovoScanManagerPlatform extends PlatformInterface {
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

  /// Считанный баркод
  ValueListenable<BarcodeDTO?> get barcode;

  /// Constructs a UrovoScanManagerPlatform.
  UrovoScanManagerPlatform() : super(token: _token);

  /// Set the output mode of the barcode reader (either send output to text box or as Android intent).
  ///
  /// TextBox Mode allows the captured data to be sent to the text box in focus.
  /// Intent mode allows the captured data to be sent as an implicit Intent.
  /// Application interested in the scan data should register an action
  /// as ACTION_DECODE broadcast listerner. In the onReceive method, get the information.
  /// The information are barcode data, bardcode string, length of barcode data,
  /// and barcode type (symbology).
  ///
  /// Parameters
  /// mode - 0 if barcode output is to be sent as intent,
  /// 1 if barcode output is to be sent to the text box in focus. The default output mode is TextBox Mode.
  Future<bool?> switchOutputMode(OutoutMode mode) {
    throw UnimplementedError('switchOutputMode() has not been implemented.');
  }

  /// Get the current scan result output mode.
  ///
  /// Parameters:
  /// 0 if the barcode is sent as intent,
  /// 1 if barcode is sent to the text box in focus. Default 1.
  ///
  /// P.S. Однажды этот метод присылал 16843134, после переключения режим через настройки
  /// стал присылать 0 и 1
  Future<OutoutMode?> getOutputMode() {
    throw UnimplementedError('getOutputMode() has not been implemented.');
  }

  /// Get the scanner power states.
  ///
  /// True if the scanner power on, false if power off.
  Future<bool?> getScannerState() {
    throw UnimplementedError('getScannerState() has not been implemented.');
  }

  /// Turn on the power for the barcode reader.
  Future<bool?> openScanner() {
    throw UnimplementedError('openScanner() has not been implemented.');
  }

  /// Turn off the power for the barcode reader.
  Future<bool?> closeScanner() {
    throw UnimplementedError('closeScanner() has not been implemented.');
  }

  Future<void> startListening() {
    throw UnimplementedError('startListening() has not been implemented.');
  }

  Future<void> stopListening() {
    throw UnimplementedError('stopListening() has not been implemented.');
  }
}
