import 'package:sr_clone_flutter/domain/entities/news_episode.dart';
import 'package:sr_clone_flutter/domain/entities/playlist.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/episodes_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/result_types.dart';
import 'package:sr_clone_flutter/domain/repositories/playlist/result_types.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class GetPlaylistUseCase implements UseCase<Future<Playlist>, String> {
  const GetPlaylistUseCase(this._episodesRepository);

  final EpisodesRepository _episodesRepository;

  @override
  Future<Playlist> call<T>(String programId) async {
    if (T == NewsEpisode) {
      final result = await _episodesRepository.getNewsEpisodes(programId);
      if (result is GetNewsEpisodesSuccessful) return _createNewsEpisodesResult(result.episodes);
      if (result is GetPlaylistFailure) throw GetPlaylistException();
    }
    throw Exception();
  }

  Playlist _createNewsEpisodesResult(List<NewsEpisode> episodes) {
    return Playlist(title: episodes.first.showName, playables: episodes);
  }
}

class GetPlaylistException implements Exception {}
