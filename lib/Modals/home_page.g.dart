// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePage _$HomePageFromJson(Map<String, dynamic> json) => HomePage(
      continuation: json['continuation'] as String?,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomePageToJson(HomePage instance) => <String, dynamic>{
      'continuation': instance.continuation,
      'sections': instance.sections,
    };
