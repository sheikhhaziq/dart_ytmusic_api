import 'package:dart_ytmusic_api/Modals/section.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_page.g.dart';

@JsonSerializable()
class HomePage {
  final String? continuation;
  final List<Section> sections;
  HomePage({
    this.continuation,
    required this.sections,
  });

  factory HomePage.fromJson(Map<String, dynamic> json) =>
      _$HomePageFromJson(json);

  /// Connect the generated [_$HomePageToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$HomePageToJson(this);
}
