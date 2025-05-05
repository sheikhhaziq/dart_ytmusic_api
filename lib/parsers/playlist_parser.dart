import 'package:dart_ytmusic_api/Modals/modals.dart';
import 'package:dart_ytmusic_api/parsers/parser.dart';
import 'package:dart_ytmusic_api/utils/filters.dart';
import 'package:dart_ytmusic_api/utils/traverse.dart';

class PlaylistParser {
  static PlaylistPage parse(dynamic data) {
    final secContents = traverse(data, [
      'contents',
      'twoColumnBrowseResultsRenderer',
      'secondaryContents',
      'sectionListRenderer'
    ]);
    final continuation =
        traverseString(secContents, ['continuations', 'continuation']);

    final artist = traverse(data, ["tabs", "straplineTextOne"]);

    /// ["thumbnail","buttons", "title","subtitle","trackingParams","description", "secondSubtitle","facepile"];
    final header = traverse(data, [
      'contents',
      'tabs',
      'content',
      'sectionListRenderer',
      'contents',
      'musicResponsiveHeaderRenderer'
    ]);

    final sections = traverse(secContents, ['contents']);
    final playEndpoint = traverse(header['buttons'],
        ['musicPlayButtonRenderer', 'playNavigationEndpoint', 'watchEndpoint']);
    final buttons = traverseList(header['buttons'],
        ['menuRenderer', 'items', 'menuNavigationItemRenderer']);
    return PlaylistPage(
      playlistId: 'playlistId',
      continuation: continuation,
      title: traverseString(header['title'], ["text"]) ?? '',
      subtitle: traverseList(header['subtitle'], ['runs', 'text']).join(),
      secondSubtitle:
          traverseList(header['secondSubtitle'], ['runs', 'text']).join(),
      description:
          traverseString(header['description'], ['description', 'text']),
      playEndpoint: playEndpoint is Map ? playEndpoint.cast() : null,
      shuffleEndpoint: buttons.firstWhere(isShuffle,
          orElse: () => null)?['navigationEndpoint']?['watchPlaylistEndpoint'],
      radioEndpoint: buttons.firstWhere(isRadio,
          orElse: () => null)?['navigationEndpoint']?['watchPlaylistEndpoint'],
      artist: ArtistBasic(
        name: traverseString(artist, ["text"]) ?? '',
        artistId: traverseString(artist, ["browseId"]),
      ),
      thumbnails: traverseList(header, ['thumbnail', 'thumbnail', 'thumbnails'])
          .map((item) => Thumbnail.fromMap(item))
          .toList(),
      sections: sections
          .map(Parser.parseSection)
          .where((e) => e != null)
          .cast<Section>()
          .toList(),
    );
  }

  static List<Section> parseContinuation(dynamic data) {
    final contents = traverseList(
        data, ['continuationContents', 'sectionListContinuation', 'contents']);
    return contents
        .map(Parser.parseSection)
        .where((e) => e != null)
        .toList()
        .cast<Section>();
  }

  // static PlaylistDetailed parseSearchResult(dynamic item) {
  //   final columns = traverseList(item, ["flexColumns", "runs"])
  //       .expand((e) => e is List ? e : [e])
  //       .toList();

  //   // No specific way to identify the title
  //   final title = columns[0];
  //   final artist = columns.firstWhere(
  //     isArtist,
  //     orElse: () => columns.length > 2
  //         ? columns[3]
  //         : AlbumBasic(
  //             albumId: '',
  //             name: '',
  //           ),
  //   );

  //   return PlaylistDetailed(
  //     type: "PLAYLIST",
  //     playlistId: traverseString(item, ["overlay", "playlistId"]) ?? '',
  //     name: traverseString(title, ["text"]) ?? '',
  //     artist: ArtistBasic(
  //       name: traverseString(artist, ["text"]) ?? '',
  //       artistId: traverseString(artist, ["browseId"]),
  //     ),
  //     thumbnails: traverseList(item, ["thumbnails"])
  //         .map((item) => Thumbnail.fromMap(item))
  //         .toList(),
  //   );
  // }

  // static PlaylistDetailed parseArtistFeaturedOn(
  //     dynamic item, ArtistBasic artistBasic) {
  //   return PlaylistDetailed(
  //     type: "PLAYLIST",
  //     playlistId:
  //         traverseString(item, ["navigationEndpoint", "browseId"]) ?? '',
  //     name: traverseString(item, ["runs", "text"]) ?? '',
  //     artist: artistBasic,
  //     thumbnails: traverseList(item, ["thumbnails"])
  //         .map((item) => Thumbnail.fromMap(item))
  //         .toList(),
  //   );
  // }

  // static PlaylistDetailed parseHomeSection(dynamic item) {
  //   final artist = traverse(item, ["subtitle", "runs"]);

  //   return PlaylistDetailed(
  //     type: "PLAYLIST",
  //     playlistId:
  //         traverseString(item, ["navigationEndpoint", "playlistId"]) ?? '',
  //     name: traverseString(item, ["runs", "text"]) ?? '',
  //     artist: ArtistBasic(
  //       name: traverseString(artist, ["text"]) ?? '',
  //       artistId: traverseString(artist, ["browseId"]),
  //     ),
  //     thumbnails: traverseList(item, ["thumbnails"])
  //         .map((item) => Thumbnail.fromMap(item))
  //         .toList(),
  //   );
  // }
}
