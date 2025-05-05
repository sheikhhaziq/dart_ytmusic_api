import 'package:dart_ytmusic_api/Modals/section.dart';
import 'package:dart_ytmusic_api/parsers/parser.dart';
import 'package:dart_ytmusic_api/utils/traverse.dart';

class SearchParser {
  static Section parseMore(dynamic data) {
    // [title, selected, content, tabIdentifier, trackingParams]
    final contents = traverse(data, [
      'contents',
      'tabbedSearchResultsRenderer',
      'tabs',
      'tabRenderer',
      'sectionListRenderer',
      'contents'
    ]);

    return Parser.parseSection(contents[0]) as Section;
  }

  static Section parseMoreContinuation(data) {
    return Parser.parseSection(data['continuationContents']) as Section;
  }
}
