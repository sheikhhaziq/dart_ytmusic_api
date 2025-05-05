import 'package:dart_ytmusic_api/Modals/modals.dart';
import 'package:dart_ytmusic_api/parsers/parser.dart';
import 'package:dart_ytmusic_api/utils/filters.dart';
import 'package:dart_ytmusic_api/utils/traverse.dart';

class AlbumParser {
  static AlbumPage parse(dynamic data) {
    final header = traverse(data, [
      'contents',
      'tabs',
      'content',
      'sectionListRenderer',
      'contents',
      'musicResponsiveHeaderRenderer'
    ]);

    final sections = traverse(data,
        ['contents', 'secondaryContents', 'sectionListRenderer', 'contents']);
    final playEndpoint = traverse(header['buttons'],
        ['musicPlayButtonRenderer', 'playNavigationEndpoint', 'watchEndpoint']);
    final playPlaylistEndpoint = traverse(header['buttons'], [
      'musicPlayButtonRenderer',
      'playNavigationEndpoint',
      'watchPlaylistEndpoint'
    ]);
    final buttons = traverseList(header['buttons'],
        ['menuRenderer', 'items', 'menuNavigationItemRenderer']);

    final List artistData = traverse(data, ["tabs", "straplineTextOne", "runs"])
            ?.where(isArtist)
            .toList() ??
        [];
    final List<ArtistBasic> artists = artistData
        .map((artist) => ArtistBasic(
            artistId: traverseString(artist, ["browseId"]),
            name: traverseString(artist, ["text"]) ?? '',
            endpoint:
                traverse(artist, ['navigationEndpoint', 'browseEndpoint'])))
        .toList();

    return AlbumPage(
      title: traverseString(header['title'], ["text"]) ?? '',
      playlistId:
          traverseString(data, ["musicPlayButtonRenderer", "playlistId"]) ?? '',
      artists: artists,
      subtitle: traverseList(header['subtitle'], ['runs', 'text']).join(),
      secondSubtitle:
          traverseList(header['secondSubtitle'], ['runs', 'text']).join(),
      description:
          traverseString(header['description'], ['description', 'text']),
      playEndpoint: playEndpoint is Map ? playEndpoint.cast() : null,
      playPlaylistEndpoint:
          playPlaylistEndpoint is Map ? playPlaylistEndpoint.cast() : null,
      shuffleEndpoint: buttons.firstWhere(isShuffle,
          orElse: () => null)?['navigationEndpoint']?['watchPlaylistEndpoint'],
      radioEndpoint: buttons.firstWhere(isRadio,
          orElse: () => null)?['navigationEndpoint']?['watchPlaylistEndpoint'],
      thumbnails: traverseList(header, ['thumbnail', 'thumbnail', 'thumbnails'])
          .map((item) => Thumbnail.fromMap(item))
          .toList(),
      sections: sections
          .map(Parser.parseSection)
          .where((e) => e != null)
          .cast<Section>()
          .toList(),
      // songs: traverseList(data, ["musicResponsiveListItemRenderer"])
      //     .map(
      //       (item) => SongParser.parseAlbumSong(
      //         item,
      //         artistBasic,
      //         albumBasic,
      //         thumbnails,
      //       ),
      //     )
      //     .toList(),
    );
  }

  // static AlbumDetailed parseSearchResult(dynamic item) {
  //   final columns = traverseList(item, ["flexColumns", "runs"])
  //       .expand((e) => e is List ? e : [e])
  //       .toList();

  //   // No specific way to identify the title
  //   final title = columns[0];
  //   final artist = columns.firstWhere(isArtist, orElse: () => columns[3]);
  //   final playlistId = traverseString(item, ["overlay", "playlistId"]) ??
  //       traverseString(item, ["thumbnailOverlay", "playlistId"]);

  //   return AlbumDetailed(
  //     type: "ALBUM",
  //     albumId: traverseList(item, ["browseId"]).last,
  //     playlistId: playlistId ?? '',
  //     artist: ArtistBasic(
  //       name: traverseString(artist, ["text"]) ?? '',
  //       artistId: traverseString(artist, ["browseId"]),
  //     ),
  //     year: processYear(columns.last?['text']),
  //     name: traverseString(title, ["text"]) ?? '',
  //     thumbnails: traverseList(item, ["thumbnails"])
  //         .map((item) => Thumbnail.fromMap(item))
  //         .toList(),
  //   );
  // }

  // static AlbumDetailed parseArtistAlbum(dynamic item, ArtistBasic artistBasic) {
  //   return AlbumDetailed(
  //     type: "ALBUM",
  //     albumId: traverseList(item, ["browseId"])
  //             .where((element) => element != artistBasic.artistId)
  //             .firstOrNull ??
  //         '',
  //     playlistId:
  //         traverseString(item, ["thumbnailOverlay", "playlistId"]) ?? '',
  //     name: traverseString(item, ["title", "text"]) ?? '',
  //     artist: artistBasic,
  //     year: processYear(traverseList(item, ["subtitle", "text"]).last),
  //     thumbnails: traverseList(item, ["thumbnails"])
  //         .map((item) => Thumbnail.fromMap(item))
  //         .toList(),
  //   );
  // }

  // static AlbumDetailed parseArtistTopAlbum(
  //     dynamic item, ArtistBasic artistBasic) {
  //   return AlbumDetailed(
  //     type: "ALBUM",
  //     albumId: traverseList(item, ["browseId"]).isEmpty
  //         ? ''
  //         : traverseList(item, ["browseId"]).last,
  //     playlistId:
  //         traverseString(item, ["musicPlayButtonRenderer", "playlistId"]) ?? '',
  //     name: traverseString(item, ["title", "text"]) ?? '',
  //     artist: artistBasic,
  //     year: processYear(traverseList(item, ["subtitle", "text"]).last),
  //     thumbnails: traverseList(item, ["thumbnails"])
  //         .map((item) => Thumbnail.fromMap(item))
  //         .toList(),
  //   );
  // }

  // static AlbumDetailed parseHomeSection(dynamic item) {
  //   final artist = traverse(item, ["subtitle", "runs"]).last;

  //   return AlbumDetailed(
  //     type: "ALBUM",
  //     albumId: traverseString(item, ["title", "browseId"]) ?? '',
  //     playlistId:
  //         traverseString(item, ["thumbnailOverlay", "playlistId"]) ?? '',
  //     name: traverseString(item, ["title", "text"]) ?? '',
  //     artist: ArtistBasic(
  //       name: traverseString(artist, ["text"]) ?? '',
  //       artistId: traverseString(artist, ["browseId"]) ?? '',
  //     ),
  //     year: null,
  //     thumbnails: traverseList(item, ["thumbnails"])
  //         .map((item) => Thumbnail.fromMap(item))
  //         .toList(),
  //   );
  // }

  // static int? processYear(String? year) {
  //   return year != null && RegExp(r"^\d{4}$").hasMatch(year)
  //       ? int.parse(year)
  //       : null;
  // }
}
