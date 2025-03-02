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
