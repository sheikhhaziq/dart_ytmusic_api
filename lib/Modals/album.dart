import 'package:dart_ytmusic_api/Modals/artist.dart';
import 'package:dart_ytmusic_api/Modals/section.dart';
import 'package:dart_ytmusic_api/Modals/thumbnail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album.g.dart';

@JsonSerializable()
class AlbumBasic {
  final String albumId;
  final String name;

  final Map<String, dynamic>? endpoint;

  AlbumBasic({required this.albumId, required this.name, this.endpoint});

  // Construtor nomeado para criar uma AlbumBasic a partir de um mapa
  AlbumBasic.fromMap(Map<String, dynamic> map)
      : albumId = map['albumId'] as String,
        name = map['name'] as String,
        endpoint = map['endpoint'];
  factory AlbumBasic.fromJson(Map<String, dynamic> json) =>
      _$AlbumBasicFromJson(json);

  /// Connect the generated [_$AlbumBasicToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AlbumBasicToJson(this);
}
@JsonSerializable()
class AlbumPage {
  final String playlistId;
  final String title;
  final String subtitle;
  final Map<String, dynamic>? playEndpoint;
  final Map<String, dynamic>? playPlaylistEndpoint;
  final Map<String, dynamic>? shuffleEndpoint;
  final Map<String, dynamic>? radioEndpoint;
  final List<ArtistBasic> artists;
  final String secondSubtitle;
  final List<Thumbnail> thumbnails;
  final String? description;
  final List<Section> sections;

  AlbumPage({
    required this.playlistId,
    required this.title,
    required this.artists,
    required this.subtitle,
    this.playEndpoint,
    this.playPlaylistEndpoint,
    this.shuffleEndpoint,
    this.radioEndpoint,
    required this.secondSubtitle,
    required this.thumbnails,
    this.description,
    required this.sections,
  });

  factory AlbumPage.fromJson(Map<String, dynamic> json) =>
      _$AlbumPageFromJson(json);

  /// Connect the generated [_$AlbumPageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AlbumPageToJson(this);
}
