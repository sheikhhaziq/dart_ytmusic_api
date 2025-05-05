// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
      title: json['title'] as String?,
      type: $enumDecodeNullable(_$SectionTypeEnumMap, json['type']) ??
          SectionType.row,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => SectionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      trailingOption: json['trailingOption'] == null
          ? null
          : TrailingOption.fromJson(
              json['trailingOption'] as Map<String, dynamic>),
      continuation: json['continuation'] as String?,
    );

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'title': instance.title,
      'type': _$SectionTypeEnumMap[instance.type]!,
      'contents': instance.contents,
      'trailingOption': instance.trailingOption,
      'continuation': instance.continuation,
    };

const _$SectionTypeEnumMap = {
  SectionType.row: 'row',
  SectionType.singleColumn: 'singleColumn',
  SectionType.multiColumn: 'multiColumn',
};
