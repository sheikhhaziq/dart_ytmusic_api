import 'package:dart_ytmusic_api/Modals/section_item.dart';
import 'package:dart_ytmusic_api/Modals/trailing_option.dart';
import 'package:dart_ytmusic_api/enums/section_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section.g.dart';

@JsonSerializable()
class Section {
  final String? title;
  final SectionType type;
  final List<SectionItem> contents;
  final TrailingOption? trailingOption;
  final String? continuation;

  Section({
    this.title,
    this.type = SectionType.row,
    required this.contents,
    this.trailingOption,
    this.continuation,
  });

  Section copyWith({
    String? title,
    SectionType? type,
    List<SectionItem>? contents,
    TrailingOption? trailingOption,
    String? continuation,
  }) =>
      Section(
        title: title ?? this.title,
        type: type ?? this.type,
        contents: contents ?? this.contents,
        trailingOption: trailingOption ?? this.trailingOption,
        continuation: continuation ?? this.continuation,
      );

  // Section.fromMap(Map<String, dynamic> map)
  //     : title = map['title'] as String,
  //       contents = map['contents'] as List<SectionItem>,;
  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  /// Connect the generated [_$SectionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
