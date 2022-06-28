// ignore_for_file: constant_identifier_names

enum BarcodeType {
  /// No decoded data.
  NONE(0),

  /// Bar codes of type Code39.
  CODE39(1),

  /// Bar codes of type Discrete 2 of 5.
  DISCRETE25(2),

  /// Bar codes of type Matrix 2 of 5.
  MATRIX25(3),

  /// Bar codes of type Interleaved 2 of 5.
  INTERLEAVED25(4),

  /// Bar codes of type Codabar.
  CODABAR(5),

  /// Reserved6 Code.
  RESERVED_6(6),

  /// Bar codes of type Code93.
  CODE93(7),

  /// Bar codes of type Code128.
  CODE128(8),

  /// Bar codes of type UPC-A.
  UPCA(9),

  /// Bar codes of type UPC-E.
  UPCE(10),

  /// Bar codes of type EAN-13.
  EAN13(11),

  /// Bar codes of type EAN-8.
  EAN8(12),

  /// Reserved13 Code.
  RESERVED_13(13),

  /// Bar codes of type MSI.
  MSI(14),

  /// Reserved15 Code.
  RESERVED_15(15),

  /// Reserved16 Code.
  RESERVED_16(16),

  /// Bar codes of type GS1 Databar-14.
  GS1_14(17),

  /// Bar codes of type GS1 Databar Limited.
  GS1_LIMIT(18),

  /// Bar codes of type GS1 Databar Expanded.
  GS1_EXP(19),

  /// Reserved20 Code.
  RESERVED_20(20),

  /// Reserved21 Code.
  RESERVED_21(21),

  /// Bar codes of type PDF-417.
  PDF417(22),

  /// Bar codes of type Datamatrix.
  DATAMATRIX(23),

  /// Bar codes of type Maxicode.
  MAXICODE(24),

  /// Bar codes of type Trioptic.
  TRIOPTIC(25),

  /// Bar codes of type Code32.
  CODE32(26),

  /// Reserved27 Code.
  RESERVED_27(27),

  /// Reserved28 Code.
  RESERVED_28(28),

  /// Bar codes of type Micropdf417.
  MICROPDF417(29),

  /// Reserved30 Code.
  RESERVED_30(30),

  /// Bar codes of type QR.
  QRCODE(31),

  /// Bar codes of type Aztec.
  AZTEC(32),

  /// Reserved33 Code.
  RESERVED_33(33),

  /// Bar codes of type POSTAL_PLANET.
  POSTAL_PLANET(34),

  /// Bar codes of type POSTAL_POSTNET.
  POSTAL_POSTNET(35),

  /// Bar codes of type POSTAL_4STATE.
  POSTAL_4STATE(36),

  /// Bar codes of type POSTAL_UPUFICS.
  POSTAL_UPUFICS(37),

  /// Bar codes of type POSTAL_ROYALMAIL.
  POSTAL_ROYALMAIL(38),

  /// Bar codes of type POSTAL_AUSTRALIAN.
  POSTAL_AUSTRALIAN(39),

  /// Bar codes of type POSTAL_KIX.
  POSTAL_KIX(40),

  /// Bar codes of type POSTAL_JAPAN.
  POSTAL_JAPAN(41),

  /// Bar codes of type GS1-128.
  GS1_128(42),

  /// Composite bar codes of type CC-C.
  COMPOSITE_CC_C(43),

  /// Composite bar codes of type CC-A/B.
  COMPOSITE_CC_AB(44),

  /// Bar codes of type Chinese 2 of 5.
  CHINESE25(45),

  /// Bar codes of type Code11.
  CODE11(46),

  /// Bar codes of type UPC-E1.
  UPCE1(47),

  /// Composite bar codes of type TLC-39.
  COMPOSITE_TLC39(48),

  /// Bar codes of type Hanxin.
  HANXIN(49),

  /// Bar codes of type DOTCODE.
  DOTCODE(50);

  final int value;
  const BarcodeType(this.value);
}
