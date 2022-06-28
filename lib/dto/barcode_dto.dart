import 'package:json_annotation/json_annotation.dart';
import 'package:urovo_scan_manager/enums/barcode_type.dart';

part 'barcode_dto.g.dart';

@JsonSerializable(createToJson: false)
class BarcodeDTO {
  final String value;
  final int type;
  final int length;

  const BarcodeDTO({
    required this.value,
    required this.type,
    required this.length,
  });

  /// Connect the generated [_$BarcodeDTOFromJson] function to the `fromJson`
  /// factory.
  factory BarcodeDTO.fromJson(Map<String, dynamic> json) => _$BarcodeDTOFromJson(json);
}

/// Добавляет [typeEnum] к [BarcodeDTO].
///
/// По умолчанию SDK возвращает тип баркода [type] в формате int - индекса нативного enum'а
/// встроенного в SDK. Данное расширение добавляет в DTO параметр [typeEnum]
/// который возвращает соответствующий enum на стороне flutter.
extension BarcodeDTOExtension on BarcodeDTO {
  BarcodeType get typeEnum => BarcodeType.values.firstWhere((e) => e.value == type);
}
