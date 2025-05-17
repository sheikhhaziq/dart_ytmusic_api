import 'package:cookie_jar/cookie_jar.dart';

import 'Modals/modals.dart';
import 'parsers/playlist_parser.dart';
import 'parsers/album_parser.dart';
import 'parsers/artist_parser.dart';
import 'parsers/browse.dart';
import 'parsers/parser.dart';
import 'parsers/podcast_parser.dart';
import 'parsers/profile_parser.dart';
import 'parsers/search_parser.dart';
import 'parsers/song_parser.dart';
import 'parsers/video_parser.dart';
import 'types.dart';
import 'utils/traverse.dart';
import 'package:dio/dio.dart';
import 'enums/enums.dart';

class YTMusic {
  final String? _cookies;
  final String? _gl;
  final String? _hl;
  late CookieJar _cookieJar;
  late Map<String, String> _config;
  late Dio dio;
  bool hasInitialized = false;

  YTMusic({String? cookies, String? location, String? language})
      : _cookies = cookies,
        _gl = location,
        _hl = language {
    _cookieJar = CookieJar();
    _config = {};
    dio = Dio(
      BaseOptions(baseUrl: "https://music.youtube.com/", headers: {
        "User-Agent":
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36",
        "Accept-Language": "en-US,en;q=0.5",
        "Accept-Enconding": "gzip",
        "Accept": "application/json, text/plain, */*",
        "Content-Type": 'application/json',
      }, extra: {
        'withCredentials': true,
      }),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final cookies =
            await _cookieJar.loadForRequest(Uri.parse(options.baseUrl));
        final cookieString = cookies
            .map((cookie) => '${cookie.name}=${cookie.value}')
            .join('; ');
        if (cookieString.isNotEmpty) {
          options.headers['cookie'] = cookieString;
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        final cookieStrings = response.headers['set-cookie'] ?? [];
        for (final cookieString in cookieStrings) {
          final cookie = Cookie.fromSetCookieValue(cookieString);
          _cookieJar.saveFromResponse(
              Uri.parse(response.requestOptions.baseUrl), [cookie]);
        }
        return handler.next(response);
      },
    ));
  }

  /// Initializes the YTMusic instance and fetches YTMusic configs
  Future<YTMusic> initialize() async {
    if (hasInitialized) {
      return this;
    }
    if (_cookies != null) {
      for (final cookieString in _cookies.split("; ")) {
        final cookie = Cookie.fromSetCookieValue(cookieString);
        _cookieJar.saveFromResponse(
          Uri.parse(dio.options.baseUrl),
          [cookie],
        );
      }
    }

    await fetchConfig();

    if (_gl != null) _config['GL'] = _gl;
    if (_hl != null) _config['HL'] = _hl;

    hasInitialized = true;

    return this;
  }

  /// Fetches the configuration data required for API requests.
  /// This api automatically calls this function.
  /// You can call it to forcefully update configs.
  Future<void> fetchConfig() async {
    try {
      final response = await dio.get('/');
      final html = response.data;
      _config['VISITOR_DATA'] = _extractValue(html, r'"VISITOR_DATA":"(.*?)"');
      _config['INNERTUBE_CONTEXT_CLIENT_NAME'] = _extractValue(
          html, r'"INNERTUBE_CONTEXT_CLIENT_NAME":\s*(-?\d+|\"(.*?)\")');
      _config['INNERTUBE_CLIENT_VERSION'] =
          _extractValue(html, r'"INNERTUBE_CLIENT_VERSION":"(.*?)"');
      _config['DEVICE'] = _extractValue(html, r'"DEVICE":"(.*?)"');
      _config['PAGE_CL'] =
          _extractValue(html, r'"PAGE_CL":\s*(-?\d+|\"(.*?)\")');
      _config['PAGE_BUILD_LABEL'] =
          _extractValue(html, r'"PAGE_BUILD_LABEL":"(.*?)"');
      _config['INNERTUBE_API_KEY'] =
          _extractValue(html, r'"INNERTUBE_API_KEY":"(.*?)"');
      _config['INNERTUBE_API_VERSION'] =
          _extractValue(html, r'"INNERTUBE_API_VERSION":"(.*?)"');
      _config['INNERTUBE_CLIENT_NAME'] =
          _extractValue(html, r'"INNERTUBE_CLIENT_NAME":"(.*?)"');
      _config['GL'] = _extractValue(html, r'"GL":"(.*?)"');
      _config['HL'] = _extractValue(html, r'"HL":"(.*?)"');
    } catch (e) {
      print('Error fetching data: ${e.toString()}');
    }
  }

  /// Extracts a value from HTML using a regular expression.
  String _extractValue(String html, String regex) {
    final match = RegExp(regex).firstMatch(html);
    return match != null ? match.group(1)! : '';
  }

  /// Constructs and performs an API request to the specified endpoint with optional body and query parameters.
  Future<dynamic> constructRequest(
    String endpoint, {
    Map<String, dynamic> body = const {},
    Map<String, String> query = const {},
  }) async {
    if (!hasInitialized) {
      await initialize();
    }
    final headers = <String, String>{
      ...dio.options.headers,
      "x-origin": "https://music.youtube.com/",
      "X-Goog-Visitor-Id": _config['VISITOR_DATA'] ?? "",
      "X-YouTube-Client-Name": _config['INNERTUBE_CONTEXT_CLIENT_NAME'] ?? '',
      "X-YouTube-Client-Version": _config['INNERTUBE_CLIENT_VERSION'] ?? '',
      "X-YouTube-Device": _config['DEVICE'] ?? '',
      "X-YouTube-Page-CL": _config['PAGE_CL'] ?? '',
      "X-YouTube-Page-Label": _config['PAGE_BUILD_LABEL'] ?? '',
      "X-YouTube-Utc-Offset":
          (-DateTime.now().timeZoneOffset.inMinutes).toString(),
      "X-YouTube-Time-Zone": DateTime.now().timeZoneName,
    };

    final searchParams = Uri.parse("?").replace(queryParameters: {
      ...query,
      "alt": "json",
      "key": _config['INNERTUBE_API_KEY'],
    });

    try {
      final response = await dio.post(
        "youtubei/${_config['INNERTUBE_API_VERSION']}/$endpoint${searchParams.toString()}",
        data: {
          "context": {
            "capabilities": {},
            "client": {
              "clientName": _config['INNERTUBE_CLIENT_NAME'],
              "clientVersion": _config['INNERTUBE_CLIENT_VERSION'],
              "experimentIds": [],
              "experimentsToken": "",
              "gl": _config['GL'],
              "hl": _config['HL'],
              "locationInfo": {
                "locationPermissionAuthorizationStatus":
                    "LOCATION_PERMISSION_AUTHORIZATION_STATUS_UNSUPPORTED",
              },
              "musicAppInfo": {
                "musicActivityMasterSwitch":
                    "MUSIC_ACTIVITY_MASTER_SWITCH_INDETERMINATE",
                "musicLocationMasterSwitch":
                    "MUSIC_LOCATION_MASTER_SWITCH_INDETERMINATE",
                "pwaInstallabilityStatus": "PWA_INSTALLABILITY_STATUS_UNKNOWN",
              },
              "utcOffsetMinutes": -DateTime.now().timeZoneOffset.inMinutes,
            },
            "request": {
              "internalExperimentFlags": [
                {
                  "key": "force_music_enable_outertube_tastebuilder_browse",
                  "value": "true",
                },
                {
                  "key": "force_music_enable_outertube_playlist_detail_browse",
                  "value": "true",
                },
                {
                  "key": "force_music_enable_outertube_search_suggestions",
                  "value": "true",
                },
              ],
              "sessionIndex": {},
            },
            "user": {
              "enableSafetyMode": false,
            },
          },
          ...body,
        },
        options: Options(headers: headers),
      );
      final jsonData = response.data;

      if (jsonData.containsKey("responseContext")) {
        return jsonData;
      } else {
        return jsonData;
      }
    } on DioException catch (e) {
      throw "Error${e.response!.statusMessage}";
    }
  }

  /// Retrieves search suggestions for a given query.
  Future<List<String>> getSearchSuggestions(String query) async {
    final response = await constructRequest("music/get_search_suggestions",
        body: {"input": query});

    return traverseList(response, ["query"]).whereType<String>().toList();
  }

  Future<List<SectionItem>> getBrowseMore(Map<String, dynamic> endpoint) async {
    final data = await constructRequest("browse", body: endpoint);

    return BrowseParser.parseMore(data);
  }

  Future<Section> getBrowseContinuation(String continuation) async {
    final data =
        await constructRequest("browse", query: {"continuation": continuation});

    return BrowseParser.parseContinuation(data);
  }

  /// Performs a search for music with the given query and returns a list of search results.
  Future<List<Section>> search(String query) async {
    final searchData = await constructRequest(
      "search",
      body: {"query": query, "params": null},
    );
    return traverseList(searchData, ["sectionListRenderer", "contents"])
        .map(Parser.parseSection)
        .where((e) => e != null)
        .cast<Section>()
        .toList();
  }

  Future<Section> searchMore(Map<String, dynamic> endpoint) async {
    final searchData = await constructRequest(
      "search",
      body: endpoint,
    );
    return SearchParser.parseMore(searchData);
  }

  Future<Section> searchMoreContinuation(String continuation) async {
    final data =
        await constructRequest("search", query: {"continuation": continuation});

    return SearchParser.parseMoreContinuation(data);
  }

  /// Performs a search specifically for songs with the given query and returns a list of song details.
  // Future<List<SongDetailed>> searchSongs(String query) async {
  //   final searchData = await constructRequest(
  //     "search",
  //     body: {
  //       "query": query,
  //       "params": "Eg-KAQwIARAAGAAgACgAMABqChAEEAMQCRAFEAo%3D"
  //     },
  //   );

  //   final results =
  //       traverseList(searchData, ["musicResponsiveListItemRenderer"]);
  //   final mappedResults = results.map(SongParser.parseSearchResult).toList();

  //   return mappedResults;
  // }

  /// Performs a search specifically for videos with the given query and returns a list of video details.
  // Future<List<VideoDetailed>> searchVideos(String query) async {
  //   final searchData = await constructRequest(
  //     "search",
  //     body: {
  //       "query": query,
  //       "params": "Eg-KAQwIABABGAAgACgAMABqChAEEAMQCRAFEAo%3D"
  //     },
  //   );

  //   return traverseList(searchData, ["musicResponsiveListItemRenderer"])
  //       .map(VideoParser.parseSearchResult)
  //       .toList();
  // }

  /// Performs a search specifically for artists with the given query and returns a list of artist details.
  // Future<List<ArtistDetailed>> searchArtists(String query) async {
  //   final searchData = await constructRequest(
  //     "search",
  //     body: {
  //       "query": query,
  //       "params": "Eg-KAQwIABAAGAAgASgAMABqChAEEAMQCRAFEAo%3D"
  //     },
  //   );

  //   return traverseList(searchData, ["musicResponsiveListItemRenderer"])
  //       .map(ArtistParser.parseSearchResult)
  //       .toList();
  // }

  // /// Performs a search specifically for albums with the given query and returns a list of album details.
  // Future<List<AlbumDetailed>> searchAlbums(String query) async {
  //   final searchData = await constructRequest(
  //     "search",
  //     body: {
  //       "query": query,
  //       "params": "Eg-KAQwIABAAGAEgACgAMABqChAEEAMQCRAFEAo%3D"
  //     },
  //   );

  //   return traverseList(searchData, ["musicResponsiveListItemRenderer"])
  //       .map(AlbumParser.parseSearchResult)
  //       .toList();
  // }

  /// Performs a search specifically for playlists with the given query and returns a list of playlist details.
  // Future<List<PlaylistDetailed>> searchPlaylists(String query) async {
  //   final searchData = await constructRequest(
  //     "search",
  //     body: {
  //       "query": query,
  //       "params": "Eg-KAQwIABAAGAAgACgBMABqChAEEAMQCRAFEAo%3D"
  //     },
  //   );

  //   return traverseList(searchData, ["musicResponsiveListItemRenderer"])
  //       .map(PlaylistParser.parseSearchResult)
  //       .toList();
  // }

  /// Retrieves detailed information about a song given its video ID.
  Future<SongFull> getSong(String videoId) async {
    if (!RegExp(r"^[a-zA-Z0-9-_]{11}$").hasMatch(videoId)) {
      throw Exception("Invalid videoId");
    }

    final data = await constructRequest("player", body: {"videoId": videoId});

    final song = SongParser.parse(data);
    if (song.videoId != videoId) {
      throw Exception("Invalid videoId");
    }
    return song;
  }

  /// Retrieves detailed information about a video given its video ID.
  Future<VideoFull> getVideo(String videoId) async {
    if (!RegExp(r"^[a-zA-Z0-9-_]{11}$").hasMatch(videoId)) {
      throw Exception("Invalid videoId");
    }

    final data = await constructRequest("player", body: {"videoId": videoId});

    final video = VideoParser.parse(data);
    if (video.videoId != videoId) {
      throw Exception("Invalid videoId");
    }
    return video;
  }

  /// Retrieves the lyrics of a song given its video ID.
  Future<String?> getLyrics(String videoId) async {
    if (!RegExp(r"^[a-zA-Z0-9-_]{11}$").hasMatch(videoId)) {
      throw Exception("Invalid videoId");
    }

    final data = await constructRequest("next", body: {"videoId": videoId});
    final browseId =
        traverse(traverseList(data, ["tabs", "tabRenderer"])[1], ["browseId"]);

    final lyricsData =
        await constructRequest("browse", body: {"browseId": browseId});
    final lyrics =
        traverseString(lyricsData, ["description", "runs", "text"])?.trim();

    return lyrics
        ?.replaceAll("\r", "")
        .split("\n")
        .where((element) => element.isNotEmpty)
        .join("\n");
  }

  /// Retrieves detailed information about an artist given its artist ID.
  // Future<ArtistPage> getArtist(String artistId) async {
  //   final data = await constructRequest("browse", body: {"browseId": artistId});

  //   return ArtistParser.parse(data);
  // }

  Future<ArtistPage> getArtistPage(Map<String, dynamic> endpoint) async {
    final data = await constructRequest("browse", body: endpoint);
    return ArtistParser.parse(data);
  }

  /// Retrieves a list of songs by a specific artist given the artist's ID.
  // Future<List<SongDetailed>> getArtistSongs(String artistId) async {
  //   final artistData =
  //       await constructRequest("browse", body: {"browseId": artistId});
  //   final browseToken =
  //       traverse(artistData, ["musicShelfRenderer", "title", "browseId"]);

  //   if (browseToken is List) {
  //     return [];
  //   }

  //   final songsData =
  //       await constructRequest("browse", body: {"browseId": browseToken});
  //   final continueToken = traverse(songsData, ["continuation"]);
  //   late final Map moreSongsData;

  //   if (continueToken is String) {
  //     moreSongsData = await constructRequest(
  //       "browse",
  //       query: {"continuation": continueToken},
  //     );
  //   } else {
  //     moreSongsData = {};
  //   }

  //   return [
  //     ...traverseList(songsData, ["musicResponsiveListItemRenderer"]),
  //     ...traverseList(moreSongsData, ["musicResponsiveListItemRenderer"]),
  //   ]
  //       .map((s) => SongParser.parseArtistSong(
  //             s,
  //             ArtistBasic(
  //               artistId: artistId,
  //               name: traverseString(artistData, ["header", "title", "text"]) ??
  //                   '',
  //             ),
  //           ))
  //       .toList();
  // }

  /// Retrieves a list of albums by a specific artist given the artist's ID.
  // Future<List<AlbumDetailed>> getArtistAlbums(String artistId) async {
  //   final artistData =
  //       await constructRequest("browse", body: {"browseId": artistId});
  //   final artistAlbumsData =
  //       traverseList(artistData, ["musicCarouselShelfRenderer"])[0];
  //   final browseBody =
  //       traverse(artistAlbumsData, ["moreContentButton", "browseEndpoint"]);
  //   if (browseBody is List) {
  //     return [];
  //   }
  //   final albumsData = await constructRequest(
  //     "browse",
  //     body: browseBody is List ? {} : browseBody,
  //   );

  //   return [
  //     ...traverseList(albumsData, ["musicTwoRowItemRenderer"])
  //         .map(
  //           (item) => AlbumParser.parseArtistAlbum(
  //             item,
  //             ArtistBasic(
  //               artistId: artistId,
  //               name: traverseString(albumsData, ["header", "runs", "text"]) ??
  //                   '',
  //             ),
  //           ),
  //         )
  //         .where(
  //           (album) => album.artist.artistId == artistId,
  //         ),
  //   ];
  // }

  // Future<List<AlbumDetailed>> getArtistSingles(String artistId) async {
  //   final artistData =
  //       await constructRequest("browse", body: {"browseId": artistId});

  //   final artistSinglesData =
  //       traverseList(artistData, ["musicCarouselShelfRenderer"]).length < 2
  //           ? []
  //           : traverseList(artistData, ["musicCarouselShelfRenderer"])
  //               .elementAt(1);

  //   final browseBody =
  //       traverse(artistSinglesData, ["moreContentButton", "browseEndpoint"]);
  //   if (browseBody is List) {
  //     return [];
  //   }

  //   final singlesData = await constructRequest(
  //     "browse",
  //     body: browseBody is List ? {} : browseBody,
  //   );

  //   return [
  //     ...traverseList(singlesData, ["musicTwoRowItemRenderer"])
  //         .map(
  //           (item) => AlbumParser.parseArtistAlbum(
  //             item,
  //             ArtistBasic(
  //               artistId: artistId,
  //               name: traverseString(singlesData, ["header", "runs", "text"]) ??
  //                   '',
  //             ),
  //           ),
  //         )
  //         .where(
  //           (album) => album.artist.artistId == artistId,
  //         ),
  //   ];
  // }

  Future<ProfilePage> getProfilePage(Map<String, dynamic> endpoint) async {
    final data = await constructRequest("browse", body: endpoint);
    return ProfileParser.parse(data);
  }
  // /// Retrieves detailed information about an album given its album ID.
  // Future<AlbumFull> getAlbum(String albumId) async {
  //   final data = await constructRequest("browse", body: {"browseId": albumId});

  //   final album = AlbumParser.parse(data, albumId);

  //   final artistSongs = await getArtistSongs(album.artist.artistId ?? '');
  //   final filteredSongs = artistSongs.where(
  //     (song) => album.songs
  //         .where((item) =>
  //             '${song.album?.name}-${song.name}' ==
  //             '${item.album?.name}-${item.name}')
  //         .isNotEmpty,
  //   );

  //   final songsThatArentInArtist = album.songs.where(
  //     (item) => artistSongs
  //         .where((song) =>
  //             '${song.album?.name}-${song.name}' ==
  //             '${item.album?.name}-${item.name}')
  //         .isEmpty,
  //   );

  //   return album..songs = [...filteredSongs, ...songsThatArentInArtist];
  // }

  /// Retrieves detailed information about an album given its endpoint.
  Future<AlbumPage> getAlbumPage(Map<String, dynamic> endpoint) async {
    final data = await constructRequest("browse", body: endpoint);

    return AlbumParser.parse(data);
  }

  /// Retrieves detailed information about a playlist given its endpoint.
  Future<PlaylistPage> getPlaylistPage(Map<String, dynamic> endpoint) async {
    final data = await constructRequest("browse", body: endpoint);
    return PlaylistParser.parse(data);
  }

  Future<List<Section>> getPlaylistPageContinuation(String continuation) async {
    final data =
        await constructRequest("browse", query: {"continuation": continuation});

    return PlaylistParser.parseContinuation(data);
  }

  /// Retrieves detailed information about a playlist given its playlist ID.
  // Future<PlaylistPage> getPlaylistPageFromId(String playlistId) async {
  //   if (playlistId.startsWith("PL")) {
  //     playlistId = "VL$playlistId";
  //   }

  //   final data =
  //       await constructRequest("browse", body: {"browseId": playlistId});

  //   return PlaylistParser.parse(data);
  // }

  /// Retrieves a list of videos from a playlist given its playlist ID.
  // Future<List<VideoDetailed>> getPlaylistVideos(String playlistId) async {
  //   if (playlistId.startsWith("PL")) {
  //     playlistId = "VL$playlistId";
  //   }

  //   final playlistData =
  //       await constructRequest("browse", body: {"browseId": playlistId});

  //   final songs = traverseList(
  //     playlistData,
  //     ["musicPlaylistShelfRenderer", "musicResponsiveListItemRenderer"],
  //   );
  //   dynamic continuation = traverse(playlistData, ["continuation"]);
  //   if (continuation is List) {
  //     continuation = continuation[0];
  //   }
  //   while (continuation is! List) {
  //     final songsData = await constructRequest(
  //       "browse",
  //       query: {"continuation": continuation},
  //     );
  //     songs
  //         .addAll(traverseList(songsData, ["musicResponsiveListItemRenderer"]));
  //     continuation = traverse(songsData, ["continuation"]);
  //   }

  //   return songs
  //       .map(VideoParser.parsePlaylistVideo)
  //       .whereType<VideoDetailed>()
  //       .toList();
  // }

  Future<PodcastPage> getPodcastPage(Map<String, dynamic> endpoint) async {
    final data = await constructRequest("browse", body: endpoint);
    return PodcastParser.parse(data);
  }

  /// Retrieves the home sections of the music platform.
  Future<HomePage> getHomePage(
      {int limit = 3, String? continuationToken}) async {
    List sections = [];
    dynamic continuation = continuationToken;
    if (continuation == null) {
      final data =
          await constructRequest("browse", body: {"browseId": feMusicHome});
      sections = traverseList(data, ["sectionListRenderer", "contents"]);
      continuation = traverseString(data, ["continuation"]);
      limit--;
    }
    while (continuation != null && limit > 0) {
      final data = await constructRequest("browse",
          query: {"continuation": continuation});

      sections
          .addAll(traverseList(data, ["sectionListContinuation", "contents"]));

      continuation = traverseString(data, ["continuation"]);
      limit--;
    }

    return HomePage(
      continuation: continuation,
      sections: sections
          .map(Parser.parseSection)
          .where((e) => e != null)
          .cast<Section>()
          .toList(),
    );
  }
}
