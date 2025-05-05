import 'package:dart_ytmusic_api/dart_ytmusic_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist.g.dart';

@JsonSerializable()
class ArtistBasic {
  final String? artistId;
  final Map<String, dynamic>? endpoint;
  final String name;

  ArtistBasic({
    this.artistId,
    required this.name,
    this.endpoint,
  });

  // Construtor nomeado para criar uma ArtistBasic a partir de um mapa
  ArtistBasic.fromMap(Map<String, dynamic> map)
      : artistId = map['artistId'] as String?,
        name = map['name'] as String,
        endpoint = map['endpoint'];
  factory ArtistBasic.fromJson(Map<String, dynamic> json) =>
      _$ArtistBasicFromJson(json);

  /// Connect the generated [_$ArtistBasicToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ArtistBasicToJson(this);
}

class ArtistPage {
  final String name;
  final List<Section> sections;
  final String description;
  final List<Thumbnail>? thumbnails;
  final Map<String, dynamic>? playEndpoint;
  final Map<String, dynamic>? shuffleEndpoint;
  final Map<String, dynamic>? radioEndpoint;
  final String? subscribers;
  final String? channelId;

  // final List<Thumbnail> thumbnails;
  // final List<SongDetailed> topSongs;
  // final List<AlbumDetailed> topAlbums;
  // final List<AlbumDetailed> topSingles;
  // final List<VideoDetailed> topVideos;
  // final List<PlaylistDetailed> featuredOn;
  // final List<ArtistDetailed> similarArtists;

  ArtistPage({
    required this.name,
    required this.sections,
    required this.description,
    this.thumbnails,
    this.playEndpoint,
    this.radioEndpoint,
    this.shuffleEndpoint,
    this.channelId,
    this.subscribers,
  });
}
