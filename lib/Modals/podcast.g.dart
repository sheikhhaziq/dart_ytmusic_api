// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PodcastPage _$PodcastPageFromJson(Map<String, dynamic> json) => PodcastPage(
      podcastId: json['podcastId'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      secondSubtitle: json['secondSubtitle'] as String,
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
      continuation: json['continuation'] as String?,
    );

Map<String, dynamic> _$PodcastPageToJson(PodcastPage instance) =>
    <String, dynamic>{
      'podcastId': instance.podcastId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'secondSubtitle': instance.secondSubtitle,
      'thumbnails': instance.thumbnails,
      'description': instance.description,
      'sections': instance.sections,
      'continuation': instance.continuation,
    };
