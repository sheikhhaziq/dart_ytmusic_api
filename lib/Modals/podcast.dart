import 'package:dart_ytmusic_api/Modals/artist.dart';
import 'package:dart_ytmusic_api/Modals/section.dart';
import 'package:dart_ytmusic_api/Modals/thumbnail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'podcast.g.dart';

@JsonSerializable()
class PodcastPage {
  final String podcastId;
  final String title;
  final String subtitle;
  // final Map<String, dynamic>? playEndpoint;
  // final Map<String, dynamic>? shuffleEndpoint;
  // final Map<String, dynamic>? radioEndpoint;
  // final ArtistBasic artist;
  final String secondSubtitle;
  final List<Thumbnail> thumbnails;
  final String? description;
  final List<Section> sections;
  final String? continuation;

  PodcastPage({
    required this.podcastId,
    required this.title,
    // required this.artist,
    required this.subtitle,
    // this.playEndpoint,
    // this.shuffleEndpoint,
    // this.radioEndpoint,
    required this.secondSubtitle,
    required this.thumbnails,
    this.description,
    required this.sections,
    this.continuation,
  });

  copyWith({
    String? podcastId,
    String? title,
    String? subtitle,
    Map<String, dynamic>? playEndpoint,
    Map<String, dynamic>? shuffleEndpoint,
    Map<String, dynamic>? radioEndpoint,
    ArtistBasic? artist,
    String? secondSubtitle,
    List<Thumbnail>? thumbnails,
    String? description,
    List<Section>? sections,
    String? continuation,
  }) =>
      PodcastPage(
        podcastId: podcastId ?? this.podcastId,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        // playEndpoint: playEndpoint ?? this.playEndpoint,
        // shuffleEndpoint: shuffleEndpoint ?? this.shuffleEndpoint,
        // radioEndpoint: radioEndpoint ?? this.radioEndpoint,
        // artist: artist ?? this.artist,
        secondSubtitle: secondSubtitle ?? this.secondSubtitle,
        thumbnails: thumbnails ?? this.thumbnails,
        description: description ?? this.description,
        sections: sections ?? this.sections,
        continuation: continuation ?? this.continuation,
      );

  factory PodcastPage.fromJson(Map<String, dynamic> json) =>
      _$PodcastPageFromJson(json);

  /// Connect the generated [_$PodcastPageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PodcastPageToJson(this);
}
