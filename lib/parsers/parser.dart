import 'package:dart_ytmusic_api/Modals/album.dart';
import 'package:dart_ytmusic_api/Modals/artist.dart';
import 'package:dart_ytmusic_api/Modals/section.dart';
import 'package:dart_ytmusic_api/Modals/section_item.dart';
import 'package:dart_ytmusic_api/Modals/thumbnail.dart';
import 'package:dart_ytmusic_api/Modals/trailing_option.dart';
import 'package:dart_ytmusic_api/enums/item_type.dart';
import 'package:dart_ytmusic_api/utils/filters.dart';
import 'package:dart_ytmusic_api/utils/prettyprint.dart';
import 'package:dart_ytmusic_api/utils/traverse.dart';

class Parser {
  static int? parseDuration(String? time) {
    final regex = RegExp(r'\((\d{1,2}:\d{2})\)');
    final match = regex.firstMatch(time ?? '00:00');
    if (time == null || match == null) return null;

    final extractedTime = match.group(1)!;

    final parts = extractedTime.split(":").reversed.map(int.parse).toList();
    final seconds = parts[0];
    final minutes = parts[1];
    late final int hours;

    if (parts.length > 2) {
      hours = parts[2];
    } else {
      hours = 0;
    }

    return seconds + minutes * 60 + hours * 60 * 60;
  }

  static double parseNumber(String string) {
    if (string.endsWith("K") ||
        string.endsWith("M") ||
        string.endsWith("B") ||
        string.endsWith("T")) {
      final number = double.parse(string.substring(0, string.length - 1));
      final multiplier = string.substring(string.length - 1);

      return {
            "K": number * 1000,
            "M": number * 1000 * 1000,
            "B": number * 1000 * 1000 * 1000,
            "T": number * 1000 * 1000 * 1000 * 1000,
          }[multiplier] ??
          double.nan;
    } else {
      return double.parse(string);
    }
  }

  static Section? parseSection(dynamic data) {
    if (data['musicCarouselShelfRenderer'] != null) {
      return musicCarouselShelfRenderer(data['musicCarouselShelfRenderer']);
    } else if (data['musicPlaylistShelfRenderer'] != null) {
      return musicPlaylistShelfRenderer(data['musicPlaylistShelfRenderer']);
    }

    return null;
  }

  static Section musicCarouselShelfRenderer(data) {
    // [header, contents, trackingParams, itemSize, numItemsPerColumn?]

    final List contents = data['contents'];
    final more = data['header']['musicCarouselShelfBasicHeaderRenderer']
        ['moreContentButton'];
    TrailingOption? trailingOption;
    if (more != null) {
      dynamic endpoint =
          traverse(more, ["navigationEndpoint", "watchPlaylistEndpoint"]);
      final isPlayable = endpoint is Map;
      if (!isPlayable) {
        endpoint = traverse(more, ["navigationEndpoint", "browseEndpoint"]);
      }

      trailingOption = TrailingOption(
          text: traverseString(
                  more, ["buttonRenderer", "text", "runs", "text"]) ??
              '',
          endpoint: endpoint,
          isPlayable: isPlayable);
    }

    return Section(
      title: traverseString(data['header'], ['title', 'text']),
      trailingOption: trailingOption,
      contents: contents
          .map(parseSectionItem)
          .where((e) => e != null)
          .cast<SectionItem>()
          .toList(),
    );
  }

  static Section musicPlaylistShelfRenderer(data) {
    // [playlistId, header, contents, collapsedItemCount, trackingParams, contentsMultiSelectable, targetId]
    return Section(
      contents: data['contents']
          .map(parseSectionItem)
          .where((e) => e != null)
          .cast<SectionItem>()
          .toList(),
    );
  }

  static SectionItem? parseSectionItem(data) {
    if (data['musicResponsiveListItemRenderer'] != null) {
      return musicResponsiveListItemRenderer(
          data['musicResponsiveListItemRenderer']);
    }
    if (data['musicTwoRowItemRenderer'] != null) {
      return musicTwoRowItemRenderer(data["musicTwoRowItemRenderer"]);
    }
    return null;
  }

  static SectionItem? musicResponsiveListItemRenderer(data) {
    // [trackingParams, thumbnail, overlay, flexColumns,fixedColumns?, menu, playlistItemData, flexColumnDisplayStyle, itemHeight]

    final flexColumns = data['flexColumns'];
    final thumbnails = traverseList(data['thumbnail'], ["thumbnails"])
        .map((item) => Thumbnail.fromMap(item))
        .toList();
    final title = traverseString(
            flexColumns[0]['musicResponsiveListItemFlexColumnRenderer'],
            ["runs", "text"]) ??
        '';
    final id = traverseString(
            flexColumns[0]['musicResponsiveListItemFlexColumnRenderer'],
            ["runs", "navigationEndpoint", "watchEndpoint", "videoId"]) ??
        '';
    final playlistId = traverseString(
            flexColumns[0]['musicResponsiveListItemFlexColumnRenderer'],
            ["runs", "navigationEndpoint", "watchEndpoint", "playlistId"]) ??
        '';

    final List<ArtistBasic> artists = flexColumns[1]
            ['musicResponsiveListItemFlexColumnRenderer']?['text']?['runs']
        .where(isArtist)
        .map(
          (a) => ArtistBasic(
            name: traverseString(a, ["text"]) ?? '',
            endpoint: traverse(a, ["navigationEndpoint", "browseEndpoint"]),
          ),
        )
        .cast<ArtistBasic>()
        .toList();
    Map<String, dynamic>? a = traverseList(
        flexColumns[2]['musicResponsiveListItemFlexColumnRenderer'],
        ["text", "runs"]).firstWhere(isAlbum, orElse: () => null);
    AlbumBasic? album;
    if (a != null) {
      album = AlbumBasic(
        albumId: traverseString(
                a, ["navigationEndpoint", "browseEndpoint", "browseId"]) ??
            '',
        name: a['text'],
        endpoint: traverse(a, ["navigationEndpoint", "browseEndpoint"]),
      );
    }
    final ep = traverse(
        flexColumns[0]['musicResponsiveListItemFlexColumnRenderer'],
        ["text", "runs", "navigationEndpoint"]);

    final endpoint = ep['browseEndpoint'] ?? ep['watchEndpoint'];
    final type = (ep['watchEndpoint'] != null
            ? traverseString(ep, [
                "watchEndpoint",
                "watchEndpointMusicSupportedConfigs",
                "musicVideoType"
              ])
            : traverseString(ep, [
                "browseEndpoint",
                "browseEndpointContextSupportedConfigs",
                "pageType"
              ])) ??
        '';
    print(ItemType.fromString(type));
    return SectionItem(
      title: title,
      id: id,
      type: ItemType.fromString(type),
      duration: traverseString(data['fixedColumns'], [
        'musicResponsiveListItemFixedColumnRenderer',
        'text',
        'runs',
        'text'
      ]),
      playlistId: playlistId,
      endpoint: endpoint,
      thumbnails: thumbnails,
      artists: artists,
      album: album,
    );
  }

  static SectionItem? musicTwoRowItemRenderer(data) {
    // [thumbnailRenderer, aspectRatio, title, subtitle, navigationEndpoint, trackingParams, menu, thumbnailOverlay]
    final title = traverseString(data["title"], ["text"]) ?? '';

    dynamic endpoint = data["navigationEndpoint"]?["browseEndpoint"];
    endpoint ??= data["navigationEndpoint"]?["watchEndpoint"];
    final id = endpoint['browseId'] ?? endpoint['videoId'];
    final type = traverseString(
            endpoint, ["browseEndpointContextSupportedConfigs", "pageType"]) ??
        traverseString(
            data, ['watchEndpointMusicSupportedConfigs', 'musicVideoType']) ??
        '';
    final thumbnails = traverseList(data['thumbnailRenderer'], ["thumbnails"])
        .map((item) => Thumbnail.fromMap(item))
        .toList();
    final isHorizontal = data['aspectRatio'].contains('RECTANGLE');
    Map<String, dynamic>? a = traverseList(data['subtitle'], ["runs"])
        .firstWhere(isAlbum, orElse: () => null);
    AlbumBasic? album;
    if (a != null) {
      album = AlbumBasic(
        albumId: traverseString(
                a, ["navigationEndpoint", "browseEndpoint", "browseId"]) ??
            '',
        name: a['text'],
        endpoint: traverse(a, ["navigationEndpoint", "browseEndpoint"]),
      );
    }
    final List<ArtistBasic> artists = traverseList(data['subtitle'], ["runs"])
        .where(isArtist)
        .map(
          (a) => ArtistBasic(
            name: traverseString(a, ["text"]) ?? '',
            endpoint: traverse(a, ["navigationEndpoint", "browseEndpoint"]),
          ),
        )
        .cast<ArtistBasic>()
        .toList();
    final subtitle =
        traverseList(data['subtitle'], ["runs", "text"]).join(", ");

    return SectionItem(
      title: title,
      id: id,
      type: ItemType.fromString(type),
      endpoint: endpoint,
      thumbnails: thumbnails,
      album: album,
      artists: artists,
      isHorizontal: isHorizontal,
      subtitle: subtitle,
    );
  }
}
