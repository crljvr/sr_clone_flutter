import 'package:sr_clone_flutter/domain/entities/episode.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/episodes_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/result_types.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class GetEpisodeUseCase implements UseCase<Future<Episode>, String> {
  const GetEpisodeUseCase(this._episodesRepository);

  final EpisodesRepository _episodesRepository;

  @override
  Future<Episode> call(String episodeId) async {
    final result = await _episodesRepository.getEpisode(episodeId);
    if (result is GetEpisodeSuccessful) return result.episode;
    if (result is GetEpisodeFailure) {
      switch (result.reason) {
        case GetEpisodeFailureReason.networkFailure:
          throw GetEpisodeNetworkException();
        case GetEpisodeFailureReason.unknown:
          throw GetEpisodeUnknownException();
      }
    }

    throw Exception();
  }
}

class GetEpisodeNetworkException implements Exception {}

class GetEpisodeUnknownException implements Exception {}
