import 'package:json_annotation/json_annotation.dart';

part 'item_type.g.dart';

@JsonEnum(alwaysCreate: true)
enum ItemType {
  @JsonValue('MUSIC_VIDEO_TYPE_ATV')
  song,

  @JsonValue('MUSIC_VIDEO_TYPE_OMV')
  video,

  @JsonValue('MUSIC_VIDEO_TYPE_UGC') // This will not be used directly
  videoUgc, // Separate internal value for duplicate types

  @JsonValue('MUSIC_PAGE_TYPE_PLAYLIST')
  playlist,

  @JsonValue('MUSIC_PAGE_TYPE_ALBUM')
  album,

  @JsonValue("MUSIC_PAGE_TYPE_ARTIST")
  artist,

  @JsonValue('MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE')
  episode,

  @JsonValue('MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE')
  podcast,

  @JsonValue("MUSIC_PAGE_TYPE_USER_CHANNEL")
  userChannel,

  @JsonValue('unknown')
  unknown;

  // Custom mapping for multiple JSON values
  static final Map<String, ItemType> _customMapping = {
    'MUSIC_VIDEO_TYPE_UGC': ItemType.video,
    'MUSIC_VIDEO_TYPE_OMV': ItemType.video, // Maps OMV to the same enum
    'MUSIC_VIDEO_TYPE_ATV': ItemType.song,
    'MUSIC_PAGE_TYPE_PLAYLIST': ItemType.playlist,
    'MUSIC_PAGE_TYPE_ALBUM': ItemType.album,
    'MUSIC_PAGE_TYPE_ARTIST': ItemType.artist,
    'MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE': ItemType.podcast,
    'MUSIC_PAGE_TYPE_NON_MUSIC_AUDIO_TRACK_PAGE': ItemType.episode,
    "MUSIC_PAGE_TYPE_USER_CHANNEL": ItemType.userChannel,
  };

  // Convert from JSON
  static ItemType fromString(String? value) =>
      _customMapping[value] ?? ItemType.unknown;

  // Convert to JSON
  String toJson() {
    return _$ItemTypeEnumMap[this]!;
  }
}
