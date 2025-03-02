import 'package:json_annotation/json_annotation.dart';

part 'trailing_option.g.dart';

@JsonSerializable()
class TrailingOption {
  final String text;
  final Map<String, dynamic> endpoint;
  final bool isPlayable;
  TrailingOption({
    required this.text,
    required this.endpoint,
    this.isPlayable = false,
  });
  factory TrailingOption.fromJson(Map<String, dynamic> json) =>
      _$TrailingOptionFromJson(json);

  /// Connect the generated [_$TrailingOptionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TrailingOptionToJson(this);
}
