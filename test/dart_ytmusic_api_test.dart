import 'package:dart_ytmusic_api/yt_music.dart';
import 'package:test/test.dart';

void main() async{
    YTMusic ytMusic = YTMusic();
    await ytMusic.initialize();
  test('Album parser should parse album details correctly', () async {
    await ytMusic.getAlbumPage(
      {'browseId': 'MPREb_MftU5XaVmDX', 'params': 'ggMrGilPTEFLNXV5X25ENXJuTUNlNzM3aUh2X085YWg5TXdWeDZzbE5DQkpBYw%3D%3D', 'browseEndpointContextSupportedConfigs': {'browseEndpointContextMusicConfig': {'pageType': 'MUSIC_PAGE_TYPE_ALBUM'},},},
    );
  });
}
