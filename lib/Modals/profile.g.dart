// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfilePage _$ProfilePageFromJson(Map<String, dynamic> json) => ProfilePage(
      name: json['name'] as String,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      thumbnails: (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      channelId: json['channelId'] as String?,
      subscribers: json['subscribers'] as String?,
    );

Map<String, dynamic> _$ProfilePageToJson(ProfilePage instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sections': instance.sections,
      'description': instance.description,
      'thumbnails': instance.thumbnails,
      'subscribers': instance.subscribers,
      'channelId': instance.channelId,
    };
