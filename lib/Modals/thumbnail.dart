import 'package:json_annotation/json_annotation.dart';
part 'thumbnail.g.dart';

@JsonSerializable()
class Thumbnail {
  final String url;
  final int width;
  final int height;

  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  // Construtor nomeado para criar uma Thumbnail a partir de um mapa
  Thumbnail.fromMap(Map<String, dynamic> map)
      : url = map['url'] as String,
        width = map['width'] as int,
        height = map['height'] as int;
  factory Thumbnail.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailFromJson(json);

  /// Connect the generated [_$ThumbnailToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ThumbnailToJson(this);
}
