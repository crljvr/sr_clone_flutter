import 'package:sr_clone_flutter/domain/entities/episode.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/episodes_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/result_types.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class GetEpisodesUseCase implements UseCase<Future<List<Episode>>, String> {
  const GetEpisodesUseCase(this._episodesRepository);

  final EpisodesRepository _episodesRepository;

  @override
  Future<List<Episode>> call<NoGeneric>(String programId) async {
    final result = await _episodesRepository.getEpisodes(programId);
    if (result is GetEpisodesSuccessful) return result.episodes;
    if (result is GetEpisodesFailure) {
      switch (result.reason) {
        case GetEpisodesFailureReason.networkFailure:
          throw GetEpisodesException();
        case GetEpisodesFailureReason.unknown:
          throw GetEpisodesException();
      }
    }
    throw Exception();
  }
}

class GetEpisodesException implements Exception {}
