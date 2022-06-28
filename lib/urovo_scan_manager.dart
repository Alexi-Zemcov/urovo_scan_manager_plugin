import 'package:flutter/foundation.dart';
import 'package:urovo_scan_manager/dto/barcode_dto.dart';
import 'package:urovo_scan_manager/enums/output_mode.dart';
import 'package:urovo_scan_manager/urovo_scan_manager_platform_interface.dart';

class UrovoScanManager {
  final _isBarcodeListening = ValueNotifier(false);

  /// Вспомогательная переменная которая сообщает подписались ли мы на прослушивание [barcode].
  ///
  /// По умолчанию false. Взводится в true при вызове метода [startListening],
  /// в false при вызове [stopListening].
  ValueListenable<bool> get isBarcodeListening => _isBarcodeListening;

  /// Когда и уведомляет при получении
  ValueListenable<BarcodeDTO?> get barcode => UrovoScanManagerPlatform.instance.barcode;

  /// Set the output mode of the barcode reader (either send output to text box or as Android intent).
  ///
  /// TextBox Mode allows the captured data to be sent to the text box in focus.
  /// Intent mode allows the captured data to be sent as an implicit Intent.
  /// Application interested in the scan data should register an action
  /// as ACTION_DECODE broadcast listerner. In the onReceive method, get the information.
  /// The information are barcode data, bardcode string, length of barcode data,
  /// and barcode type (symbology).
  ///
  /// Parameters:
  /// mode - 0 if barcode output is to be sent as intent,
  /// 1 if barcode output is to be sent to the text box in focus. The default output mode is TextBox Mode.
  Future<bool?> switchOutputMode(OutoutMode mode) {
    return UrovoScanManagerPlatform.instance.switchOutputMode(mode);
  }

  /// Get the current scan result output mode.
  ///
  /// Parameters:
  /// 0 if the barcode is sent as intent,
  /// 1 if barcode is sent to the text box in focus. Default 1.
  ///
  /// P.S. Однажды этот метод присылал 16843134, после переключения режим через настройки
  /// стал присылать 0 и 1.
  Future<OutoutMode?> getOutputMode() {
    return UrovoScanManagerPlatform.instance.getOutputMode();
  }

  /// Get the scanner power states.
  ///
  /// True if the scanner power on, false if power off.
  Future<bool?> getScannerState() {
    return UrovoScanManagerPlatform.instance.getScannerState();
  }

  /// Turn on the power for the barcode reader.
  Future<void> openScanner() {
    return UrovoScanManagerPlatform.instance.openScanner();
  }

  /// Turn off the power for the barcode reader.
  Future<void> closeScanner() {
    return UrovoScanManagerPlatform.instance.closeScanner();
  }

  Future<void> startListening() async {
    await UrovoScanManagerPlatform.instance.startListening();
    _isBarcodeListening.value = true;
  }

  Future<void> stopListening() async {
    await UrovoScanManagerPlatform.instance.stopListening();
    _isBarcodeListening.value = false;
  }
}
