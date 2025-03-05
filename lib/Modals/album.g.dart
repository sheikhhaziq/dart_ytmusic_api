// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumBasic _$AlbumBasicFromJson(Map<String, dynamic> json) => AlbumBasic(
      albumId: json['albumId'] as String,
      name: json['name'] as String,
      endpoint: json['endpoint'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$AlbumBasicToJson(AlbumBasic instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'name': instance.name,
      'endpoint': instance.endpoint,
    };

AlbumPage _$AlbumPageFromJson(Map<String, dynamic> json) => AlbumPage(
      playlistId: json['playlistId'] as String,
      title: json['title'] as String,
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistBasic.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtitle: json['subtitle'] as String,
      playEndpoint: json['playEndpoint'] as Map<String, dynamic>?,
      playPlaylistEndpoint:
          json['playPlaylistEndpoint'] as Map<String, dynamic>?,
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

Map<String, dynamic> _$AlbumPageToJson(AlbumPage instance) => <String, dynamic>{
      'playlistId': instance.playlistId,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'playEndpoint': instance.playEndpoint,
      'playPlaylistEndpoint': instance.playPlaylistEndpoint,
      'shuffleEndpoint': instance.shuffleEndpoint,
      'radioEndpoint': instance.radioEndpoint,
      'artists': instance.artists,
      'secondSubtitle': instance.secondSubtitle,
      'thumbnails': instance.thumbnails,
      'description': instance.description,
      'sections': instance.sections,
    };
