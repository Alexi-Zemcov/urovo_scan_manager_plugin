import 'package:urovo_scan_manager/dto/barcode_dto.dart';
import 'package:urovo_scan_manager/enums/beep_sound.dart';
import 'package:urovo_scan_manager/enums/output_mode.dart';
import 'package:urovo_scan_manager/urovo_scan_manager_platform_interface.dart';

/// Плагин для работы со сканером встроенным в android устройства фирмы Urovo.
class UrovoScanManager {
  // TODO(zemcov): создай сет настроек по-умолчанию

  /// Вспомогательная переменная которая сообщает подписались ли мы на прослушивание [barcode].
  ///
  /// По умолчанию false. Взводится в true при вызове метода [startListening],
  /// в false при вызове [stopListening].
  bool get isBarcodeListening => _isBarcodeListening;

  /// Уведомляет слушателей об успешном сканировании и передаёт данные в формате [BarcodeDTO].
  ///
  /// Для того чтобы обновления приходили необходимо выполнить 3 условия:
  ///
  /// 1) Сканер должен быть включен. Проверить текущее состояние можно вызвав метод [getScannerState].
  /// Включить сканер можно вызвав метод [openScanner], выключить - [closeScanner].
  /// Важно учесть что пользователь может выключить сканер через системные настройки устройства
  /// во время выполнения программы!
  ///
  /// 2) [OutputMode] сканера должен быть установлен в состояние [OutputMode.intent].
  /// Проверить текущее состояние можно вызвав метод [getOutputMode],
  /// установить новое методом [switchOutputMode].
  /// Важно учесть что пользователь может поменять это значение через системные настройки устройства
  /// во время выполнения программы!
  ///
  /// 3) Подписаться на получение обновлений вызвав метод [startListening].
  /// Отписаться можно вызвав метод [stopListening]. Проверить текущее состояние (подписан или нет)
  /// возможно с помощью геттера [isBarcodeListening].
  Stream<BarcodeDTO?> get barcode => UrovoScanManagerPlatform.instance.barcode;

  bool _isBarcodeListening = false;

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
  Future<void> switchOutputMode(OutputMode mode) async {
    final isSuccess =
        await UrovoScanManagerPlatform.instance.switchOutputMode(mode) ?? false;
    if (!isSuccess) throw Exception('Cannot switch output mode');
  }

  /// Get the current scan result output mode.
  ///
  /// Parameters:
  /// 0 if the barcode is sent as intent,
  /// 1 if barcode is sent to the text box in focus. Default 1.
  ///
  /// P.S. Однажды этот метод присылал 16843134, после переключения режим через настройки
  /// стал присылать 0 и 1.
  Future<OutputMode?> getOutputMode() {
    return UrovoScanManagerPlatform.instance.getOutputMode();
  }

  /// Get the scanner power states.
  ///
  /// True if the scanner power on, false if power off.
  Future<bool?> getScannerState() async {
    return UrovoScanManagerPlatform.instance.getScannerState();
  }

  /// Turn on the power for the barcode reader.
  Future<void> openScanner() async {
    final isSuccess = await UrovoScanManagerPlatform.instance.openScanner();
    if (isSuccess != true) throw Exception('Cannot turn on the scanner');
  }

  /// Turn off the power for the barcode reader.
  Future<void> closeScanner() async {
    final isSuccess = await UrovoScanManagerPlatform.instance.closeScanner();
    if (isSuccess != true) throw Exception('Cannot turn off the scanner');
  }

  /// Подписаться на получение обновлений [barcode] при успешном сканировании.
  void startListening() {
    UrovoScanManagerPlatform.instance.startListening();
    _isBarcodeListening = true;
  }

  /// Отписаться от получения обновлений [barcode] при успешном сканировании.
  void stopListening() {
    UrovoScanManagerPlatform.instance.stopListening();
    _isBarcodeListening = false;
  }

  /// Очищает внутренние Notifier'ы от слушателей.
  void dispose() {
    UrovoScanManagerPlatform.instance.dispose();
  }

  /// Переключает режим Beep Sound при успешном сканировании.
  Future<void> switchBeepSound({required BeepSound beepSound}) async {
    final statusCode = await UrovoScanManagerPlatform.instance
        .switchBeepSound(beepSounb: beepSound);
    if (statusCode == -1) throw Exception('Cannot switch beep sound');
  }

  /// Возвращает состояние переключателя beepSound.
  Future<BeepSound?> getBeepSoundState() async {
    return UrovoScanManagerPlatform.instance.getBeepSoundState();
  }
}
