// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trailing_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrailingOption _$TrailingOptionFromJson(Map<String, dynamic> json) =>
    TrailingOption(
      text: json['text'] as String,
      endpoint: json['endpoint'] as Map<String, dynamic>,
      isPlayable: json['isPlayable'] as bool? ?? false,
    );

Map<String, dynamic> _$TrailingOptionToJson(TrailingOption instance) =>
    <String, dynamic>{
      'text': instance.text,
      'endpoint': instance.endpoint,
      'isPlayable': instance.isPlayable,
    };
