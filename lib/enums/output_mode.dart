enum OutoutMode {
  /// Barcode output is to be sent as intent.
  intent(0),

  /// Barcode output is to be sent to the text box in focus. The default output mode is TextBox Mode.
  textBox(1);

  final int value;
  const OutoutMode(this.value);
}
