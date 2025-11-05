// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dimensions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Dimensions _$DimensionsFromJson(Map<String, dynamic> json) => _Dimensions(
  height: (json['height'] as num).toDouble(),
  width: (json['width'] as num).toDouble(),
  depth: (json['depth'] as num).toDouble(),
);

Map<String, dynamic> _$DimensionsToJson(_Dimensions instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'depth': instance.depth,
    };
