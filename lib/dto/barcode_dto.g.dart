// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarcodeDTO _$BarcodeDTOFromJson(Map<String, dynamic> json) => BarcodeDTO(
      barcodeString: json['barcodeString'] as String,
      barcodeType: json['barcodeType'] as int,
      barcodeLength: json['barcodeLength'] as int,
    );

Map<String, dynamic> _$BarcodeDTOToJson(BarcodeDTO instance) => <String, dynamic>{
      'barcodeString': instance.barcodeString,
      'barcodeType': instance.barcodeType,
      'barcodeLength': instance.barcodeLength,
    };
