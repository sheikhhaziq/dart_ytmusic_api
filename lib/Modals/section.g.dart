// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Section _$SectionFromJson(Map<String, dynamic> json) => Section(
      title: json['title'] as String?,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => SectionItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      trailingOption: json['trailingOption'] == null
          ? null
          : TrailingOption.fromJson(
              json['trailingOption'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionToJson(Section instance) => <String, dynamic>{
      'title': instance.title,
      'contents': instance.contents.map((content) => content.toJson()),
      'trailingOption': instance.trailingOption,
    };
