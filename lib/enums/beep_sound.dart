/// Свойства доступные для изменений.
///
/// Как использовать их на платформе подробнее здесь:
/// https://www.urovo.com/developer/android/device/ScanManager.html#setParameterInts(int[],%20int[]).
///
/// ENUM скопирован из библиотеки. Подробное описание каждого метода и его значений здесь:
/// https://www.urovo.com/developer/android/device/scanner/configuration/PropertyID.html
/// А здесь можно проверить соотношение названия с индексом:
/// https://www.urovo.com/developer/constant-values.html#android.device.scanner.configuration.PropertyID.GOOD_READ_BEEP_ENABLE
enum BeepSound {
  none(0),
  short(1),
  sharp(2);

  final int value;

  const BeepSound(this.value);
}
