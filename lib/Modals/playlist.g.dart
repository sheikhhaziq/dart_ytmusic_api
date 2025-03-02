// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistPage _$PlaylistPageFromJson(Map<String, dynamic> json) => PlaylistPage(
      playlistId: json['playlistId'] as String,
      title: json['title'] as String,
      artist: ArtistBasic.fromJson(json['artist'] as Map<String, dynamic>),
      subtitle: json['subtitle'] as String,
      playEndpoint: json['playEndpoint'] as Map<String, dynamic>?,
      shuffleEndpoint: json['shuffleEndpoint'] as Map<String, dynamic>?,
      radioEndpoint: json['radioEndpoint'] as Map<String, dynamic>?,
      secondSubtitle: json['secondSubtitle'] as String,
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['description'] as String?,
      sections: (json['sections'] as List<dynamic>)
          .map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistPageToJson(PlaylistPage instance) =>
    <String, dynamic>{
      'playlistId': instance.playlistId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'playEndpoint': instance.playEndpoint,
      'shuffleEndpoint': instance.shuffleEndpoint,
      'radioEndpoint': instance.radioEndpoint,
      'artist': instance.artist,
      'secondSubtitle': instance.secondSubtitle,
      'thumbnails': instance.thumbnails,
      'description': instance.description,
      'sections': instance.sections.map((section) => section.toJson()),
    };
