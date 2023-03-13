import 'package:sr_clone_flutter/domain/entities/episode.dart';

abstract class GetEpisodesReslut {}

class GetEpisodesSuccessful implements GetEpisodesReslut {
  const GetEpisodesSuccessful(this.episodes);
  final List<Episode> episodes;
}

class GetEpisodesFailure implements GetEpisodesReslut {
  const GetEpisodesFailure(this.reason);
  final GetEpisodesFailureReason reason;
}

// TODO: Make this usable for all result types. Remove duplication.
enum GetEpisodesFailureReason { networkFailure, unknown }
