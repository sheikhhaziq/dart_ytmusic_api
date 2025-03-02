import 'package:dart_ytmusic_api/yt_music.dart';
import 'package:test/test.dart';

void main() {
  test('Album parser should parse album details correctly', () async {
    YTMusic ytMusic = YTMusic();
    await ytMusic.initialize();
    await ytMusic.getPlaylistPage({
      'browseId': 'VLPL4fGSI1pDJn40WjZ6utkIuj2rNg-7iGsq',
      'browseEndpointContextSupportedConfigs': {
        'browseEndpointContextMusicConfig': {
          'pageType': 'MUSIC_PAGE_TYPE_PLAYLIST'
        }
      }
    });
  });
}
