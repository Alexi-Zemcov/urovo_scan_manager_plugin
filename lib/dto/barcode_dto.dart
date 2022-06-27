import 'package:json_annotation/json_annotation.dart';

part 'barcode_dto.g.dart';

@JsonSerializable()
class BarcodeDTO {
  const BarcodeDTO({
    required this.barcodeString,
    required this.barcodeType,
    required this.barcodeLength,
  });

  final String barcodeString;
  final int barcodeType;
  final int barcodeLength;

  /// Connect the generated [_$BarcodeDTOFromJson] function to the `fromJson`
  /// factory.
  factory BarcodeDTO.fromJson(Map<String, dynamic> json) => _$BarcodeDTOFromJson(json);

  /// Connect the generated [_$BarcodeDTOToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$BarcodeDTOToJson(this);
}

// class Uint8ListConverter implements JsonConverter<Uint8List?, List<int>?> {
//   const Uint8ListConverter();
//
//   @override
//   Uint8List? fromJson(List<int>? json) {
//     return json == null ? null : Uint8List.fromList(json);
//   }
//
//   @override
//   List<int>? toJson(Uint8List? object) {
//     return object?.toList();
//   }
// }
