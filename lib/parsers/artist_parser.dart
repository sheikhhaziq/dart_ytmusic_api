import 'package:dart_ytmusic_api/parsers/parser.dart';
import 'package:dart_ytmusic_api/utils/traverse.dart';

import '../Modals/modals.dart';

class ArtistParser {
  static ArtistPage parse(dynamic data) {
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
    final shuffle =
        traverse(header, ["playButton", "navigationEndpoint", "watchEndpoint"]);
    final radio = traverse(
        header, ["startRadioButton", "navigationEndpoint", "watchEndpoint"]);
    return ArtistPage(
        name: traverseString(header, ["title", "text"]) ?? '',
        description: traverseString(header, ["description", "text"]) ?? '',
        subscribers: traverseString(
            header, ["subscriptionButton", "subscriberCountText", "text"]),
        channelId: traverseString(header, ["subscriptionButton", "channelId"]),
        thumbnails: thumbs.isNotEmpty ? thumbs : null,
        shuffleEndpoint: shuffle is Map ? shuffle.cast() : null,
        radioEndpoint: radio is Map ? radio.cast() : null,
        sections: contents
            .map(Parser.parseSection)
            .where((e) => e != null)
            .toList()
            .cast<Section>());
  }

//   static ArtistDetailed parseSearchResult(dynamic item) {
//     final columns = traverseList(item, ["flexColumns", "runs"])
//         .expand((e) => e is List ? e : [e])
//         .toList();

//     // No specific way to identify the title
//     final title = columns[0];

//     return ArtistDetailed(
//       type: "ARTIST",
//       artistId: traverseString(item, ["browseId"]) ?? '',
//       name: traverseString(title, ["text"]) ?? '',
//       thumbnails: traverseList(item, ["thumbnails"])
//           .map((item) => Thumbnail.fromMap(item))
//           .toList(),
//     );
//   }

//   static ArtistDetailed parseSimilarArtists(dynamic item) {
//     return ArtistDetailed(
//       type: "ARTIST",
//       artistId: traverseString(item, ["browseId"]) ?? '',
//       name: traverseString(item, ["runs", "text"]) ?? '',
//       thumbnails: traverseList(item, ["thumbnails"])
//           .map((item) => Thumbnail.fromMap(item))
//           .toList(),
//     );
//   }
}
