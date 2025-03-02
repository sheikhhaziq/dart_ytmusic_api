import 'package:dart_ytmusic_api/Modals/section_item.dart';
import 'package:dart_ytmusic_api/Modals/trailing_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section.g.dart';

@JsonSerializable()
class Section {
  final String? title;
  final List<SectionItem> contents;
  final TrailingOption? trailingOption;

  Section({
    this.title,
    required this.contents,
    this.trailingOption,
  });

  // Section.fromMap(Map<String, dynamic> map)
  //     : title = map['title'] as String,
  //       contents = map['contents'] as List<SectionItem>,;
  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  /// Connect the generated [_$SectionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
