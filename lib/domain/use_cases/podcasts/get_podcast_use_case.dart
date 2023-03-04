import 'package:sr_clone_flutter/domain/entities/podcast.dart';
import 'package:sr_clone_flutter/domain/repositories/podcasts/podcasts_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/podcasts/result_types.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class GetPodcastUseCase implements UseCase<Future<Podcast>, String> {
  const GetPodcastUseCase(this._podcastsRepository);

  final PodcastsRepository _podcastsRepository;

  @override
  Future<Podcast> call<NoGeneric>(String podcastId) async {
    final result = await _podcastsRepository.getPodcast(podcastId);
    if (result is GetPodcastSuccessful) return result.podcast;
    if (result is GetPodcastFailure) {
      switch (result.reason) {
        case GetPodcastFailureReason.networkFailure:
          throw GetEpisodeNetworkException();
        case GetPodcastFailureReason.unknown:
          throw GetEpisodeUnknownException();
      }
    }

    throw Exception();
  }
}

class GetEpisodeNetworkException implements Exception {}

class GetEpisodeUnknownException implements Exception {}
