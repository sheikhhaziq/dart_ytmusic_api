import 'package:dart_ytmusic_api/yt_music.dart';
import 'package:test/test.dart';

void main() async {
  YTMusic ytMusic = YTMusic();
  await ytMusic.initialize();

  test('Fetch Home Screen', () async {
    await ytMusic.getHomePage();
  });

  test('Browse More details', () async {
    await ytMusic.getBrowseMore({
      "browseId": "FEmusic_charts",
      "params": "sgYMRkVtdXNpY19ob21l",
    });
  });

  test('Browse screen continuation', () async {
    await ytMusic.getBrowseContinuation(
        "4qmFsgJmEiZNUFNQUEw3MHlJUzZ2eF9ZMnhhS0QzdzJxYjZFdTA2ak5CZE5KYho8ZWg1UVZEcERSMUZwUlVSbmVsSkVhM3BPUkZKQ1RucENSRTFWVFhsT2VtdVNBUU1JMlFqYUNBUUlBaEFC");
  });

  test('Fetch Playlist Screen', () async {
    await ytMusic.getPlaylistPage({
      "browseId": "VLOLAK5uy_ltsyEtkeMyKypwu-Cocd1kpaUwV-CZYgo",
      "params": "ggMCCAI%3D",
      "browseEndpointContextSupportedConfigs": {
        "browseEndpointContextMusicConfig": {
          "pageType": "MUSIC_PAGE_TYPE_PLAYLIST"
        }
      }
    });
  });

  test('Fetch Playlist Screen Continuation', () async {
    await ytMusic.getPlaylistPageContinuation(
        "4qmFsgI9Ei1WTFJEQ0xBSzV1eV9ubms1OFkzclQ0WTYydnVZVXZHcFdHanhMOXdzYjEwdUkaDGtnRURDTTBHOEFFQQ%3D%3D");
  });

  test('Album parser should parse album details correctly', () async {
    await ytMusic.getAlbumPage(
      {
        "browseId": "MPREb_rSlujPjnEAC",
        "params":
            "ggMrGilPTEFLNXV5X25uYmh3M1BTWnRSWlE3ZnBYVzc2dE1acFFsNTNEemJ2Zw%3D%3D",
        "browseEndpointContextSupportedConfigs": {
          "browseEndpointContextMusicConfig": {
            "pageType": "MUSIC_PAGE_TYPE_ALBUM"
          }
        }
      },
    );
  });

  test('Fetch Artist Page', () async {
    await ytMusic.getArtistPage({
      "browseId": "UCKVd98OkZ-1D2soC0otv9JA",
      "browseEndpointContextSupportedConfigs": {
        "browseEndpointContextMusicConfig": {
          "pageType": "MUSIC_PAGE_TYPE_ARTIST"
        }
      }
    });
  });
  test('Fetch Search Results', () async {
    await ytMusic.search('lose yourself');
  });

  test('Fetch Search More Results', () async {
    await ytMusic.searchMore(
        {"query": "pal pal", "params": "EgWKAQIIAWoSEAMQBBAJEA4QChAFEBEQEBAV"});
  });

  test('Fetch Search More Results continuation', () async {
    await ytMusic.searchMoreContinuation(
        "EqgDEgdwYWwgcGFsGpwDRWdXS0FRSUlBVWdVYWhJUUF4QUVFQWtRRGhBS0VBVVFFUkFRRUJXQ0FRc3dYemxVUTJGckxTMWpkNElCQzFsbWNVcHJkSFl5Ym5WQmdnRUxlRUp4Y0VWd1RVZGFaVGlDQVFzemVGZENXSGx3WVU5TlRZSUJDMWgxUVRCQ2RsbHJjM2xKZ2dFTGVWTlNOMVZYTjNSNlUyLUNBUXR1WkZVNWEwSnJNMVZYU1lJQkMxcGZVSEl6V2pscWVqaEpnZ0VMTmxCTU16bElNa0kzVlZHQ0FRdENVVXMyVW1WTWQxOHlNSUlCQzFZd1ZHVnFTRWxhVEZZNGdnRUxiVFJXVkZadlIxTkpWRm1DQVF0a1RVUm9lRkZDZEZKS1NZSUJDMVpQTm5keVYzcFRRa3QzZ2dFTGNESlFNRXRhV1UxR2EydUNBUXRmVVdsaloyeHhVMjlhZDRJQkN6aHpaVjk2YTJSSFJGVlJnZ0VMWkRkVlNXUmhhMkkzY0ctQ0FRdGpaV3hqVjA1WFF6UkROSUlCQzNVeFUzUlBkRjlFWVhGbhjx6tAu");
  });

  test('Fetch Podcast Page', () async {
    await ytMusic.getPodcastPage({
      "browseId": "MPSPPL70yIS6vx_Y2xaKD3w2qb6Eu06jNBdNJb",
      "browseEndpointContextSupportedConfigs": {
        "browseEndpointContextMusicConfig": {
          "pageType": "MUSIC_PAGE_TYPE_PODCAST_SHOW_DETAIL_PAGE"
        }
      }
    });
  });

  test('Fetch Profile Page', () async {
    await ytMusic.getProfilePage({
      "browseId": "UC_aEa8K-EOJ3D6gOs7HcyNg",
      "browseEndpointContextSupportedConfigs": {
        "browseEndpointContextMusicConfig": {
          "pageType": "MUSIC_PAGE_TYPE_USER_CHANNEL"
        }
      }
    });
  });
}
