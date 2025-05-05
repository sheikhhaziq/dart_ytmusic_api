// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionItem _$SectionItemFromJson(Map<String, dynamic> json) => SectionItem(
      title: json['title'] as String,
      id: json['id'] as String,
      isExplicit: json['isExplicit'] as bool? ?? false,
      type: $enumDecode(_$ItemTypeEnumMap, json['type']),
      playlistId: json['playlistId'] as String?,
      duration: json['duration'] as String?,
      endpoint: json['endpoint'] as Map<String, dynamic>,
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => Thumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      artists: (json['artists'] as List<dynamic>)
          .map((e) => ArtistBasic.fromJson(e as Map<String, dynamic>))
          .toList(),
      subtitle: json['subtitle'] as String?,
      isHorizontal: json['isHorizontal'] as bool? ?? false,
      album: json['album'] == null
          ? null
          : AlbumBasic.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SectionItemToJson(SectionItem instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'isExplicit': instance.isExplicit,
      'type': instance.type,
      'playlistId': instance.playlistId,
      'duration': instance.duration,
      'endpoint': instance.endpoint,
      'thumbnails': instance.thumbnails,
      'artists': instance.artists,
      'album': instance.album,
      'subtitle': instance.subtitle,
      'isHorizontal': instance.isHorizontal,
    };

const _$ItemTypeEnumMap = {
  ItemType.song: 'MUSIC_VIDEO_TYPE_ATV',
  ItemType.video: 'MUSIC_VIDEO_TYPE_OMV',
  ItemType.videoUgc: 'MUSIC_VIDEO_TYPE_UGC',
  ItemType.playlist: 'MUSIC_PAGE_TYPE_PLAYLIST',
  ItemType.album: 'MUSIC_PAGE_TYPE_ALBUM',
  ItemType.artist: 'MUSIC_PAGE_TYPE_ARTIST',
  ItemType.episode: 'MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE',
  ItemType.podcast: 'MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE',
  ItemType.userChannel: 'MUSIC_PAGE_TYPE_USER_CHANNEL',
  ItemType.unknown: 'unknown',
};
