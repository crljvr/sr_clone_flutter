import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/domain/entities/playlist.dart';
import 'package:sr_clone_flutter/domain/repositories/playlist/playlist_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/playlist/result_types.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  const PlaylistRepositoryImpl(this._datasource);

  final Datasource _datasource;

  // Make this generic type T
  @override
  Future<GetPlaylistResult> getPlaylist(String programId) async {
    try {
      final dtos = await _datasource.getNewsEpisodes(programId);
      final episodes = dtos.map((dto) => dto.asNewsEpisode).toList();
      final playlist = Playlist(title: episodes.first.showName, playables: episodes);
      return GetPlaylistSuccessful(playlist);
    } on UnableToGetNewsEpisodesFromDatasourceException catch (_) {
      return GetPlaylistFailure();
    }
  }
}
