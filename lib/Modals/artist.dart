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
