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
