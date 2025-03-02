import 'package:dart_ytmusic_api/Modals/artist.dart';
import 'package:dart_ytmusic_api/Modals/section.dart';
import 'package:dart_ytmusic_api/Modals/thumbnail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'playlist.g.dart';

@JsonSerializable()
class PlaylistPage {
  final String playlistId;
  final String title;
  final String subtitle;
  final Map<String, dynamic>? playEndpoint;
  final Map<String, dynamic>? shuffleEndpoint;
  final Map<String, dynamic>? radioEndpoint;
  final ArtistBasic artist;
  final String secondSubtitle;
  final List<Thumbnail> thumbnails;
  final String? description;
  final List<Section> sections;

  PlaylistPage({
    required this.playlistId,
    required this.title,
    required this.artist,
    required this.subtitle,
    this.playEndpoint,
    this.shuffleEndpoint,
    this.radioEndpoint,
    required this.secondSubtitle,
    required this.thumbnails,
    this.description,
    required this.sections,
  });

  factory PlaylistPage.fromJson(Map<String, dynamic> json) =>
      _$PlaylistPageFromJson(json);

  /// Connect the generated [_$PlaylistPageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PlaylistPageToJson(this);
}
