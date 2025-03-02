import 'package:dart_ytmusic_api/Modals/album.dart';
import 'package:dart_ytmusic_api/Modals/artist.dart';
import 'package:dart_ytmusic_api/Modals/thumbnail.dart';
import 'package:dart_ytmusic_api/enums/item_type.dart';
import 'package:dart_ytmusic_api/types.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section_item.g.dart';

@JsonSerializable()
class SectionItem {
  final String title;
  final String id;
  final ItemType type;
  final String? playlistId;
  final String? duration;
  final Map<String, dynamic> endpoint;
  final List<Thumbnail> thumbnails;
  final List<ArtistBasic> artists;
  final AlbumBasic? album;
  final String? subtitle;
  final bool isHorizontal;
  SectionItem({
    required this.title,
    required this.id,
    required this.type,
    this.playlistId,
    this.duration,
    required this.endpoint,
    required this.thumbnails,
    required this.artists,
    this.subtitle,
    this.isHorizontal = false,
    this.album,
  });
  factory SectionItem.fromJson(Map<String, dynamic> json) =>
      _$SectionItemFromJson(json);

  /// Connect the generated [_$SectionItemToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SectionItemToJson(this);
}
