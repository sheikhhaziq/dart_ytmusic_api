import 'package:dart_ytmusic_api/dart_ytmusic_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class ProfilePage {
  final String name;
  final List<Section> sections;
  final String? description;
  final List<Thumbnail>? thumbnails;
  final String? subscribers;
  final String? channelId;

  ProfilePage({
    required this.name,
    required this.sections,
    this.description,
    this.thumbnails,
    this.channelId,
    this.subscribers,
  });

  factory ProfilePage.fromJson(Map<String, dynamic> json) =>
      _$ProfilePageFromJson(json);

  /// Connect the generated [_$ProfilePageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProfilePageToJson(this);
}
