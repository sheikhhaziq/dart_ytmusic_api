// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistBasic _$ArtistBasicFromJson(Map<String, dynamic> json) => ArtistBasic(
      artistId: json['artistId'] as String?,
      name: json['name'] as String,
      endpoint: json['endpoint'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ArtistBasicToJson(ArtistBasic instance) =>
    <String, dynamic>{
      'artistId': instance.artistId,
      'endpoint': instance.endpoint,
      'name': instance.name,
    };
