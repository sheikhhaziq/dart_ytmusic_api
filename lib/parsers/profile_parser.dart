import 'package:dart_ytmusic_api/Modals/modals.dart';
import 'package:dart_ytmusic_api/parsers/parser.dart';
import 'package:dart_ytmusic_api/utils/traverse.dart';

class ProfileParser {
  static ProfilePage parse(dynamic data) {
    final List contents = traverse(data, [
      'contents',
      'singleColumnBrowseResultsRenderer',
      'tabs',
      'tabRenderer',
      'sectionListRenderer',
      'contents'
    ]);

    final header = data['header'];
    final thumbs = traverseList(header, ["thumbnail", "thumbnails"])
        .map((item) => Thumbnail.fromMap(item))
        .toList();
    return ProfilePage(
      name: traverseString(header, ["title", "text"]) ?? '',
      description: traverseString(header, ["description", "text"]),
      subscribers: traverseString(
          header, ["subscriptionButton", "subscriberCountText", "text"]),
      channelId: traverseString(header, ["subscriptionButton", "channelId"]),
      thumbnails: thumbs.isNotEmpty ? thumbs : null,
      sections: contents
          .map(Parser.parseSection)
          .where((e) => e != null)
          .toList()
          .cast<Section>(),
    );
  }
}
