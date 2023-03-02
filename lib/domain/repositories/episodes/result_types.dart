import 'package:sr_clone_flutter/domain/entities/episode.dart';

abstract class GetEpisodeReslut {}

class GetEpisodeSuccessful implements GetEpisodeReslut {
  const GetEpisodeSuccessful(this.episode);
  final Episode episode;
}

class GetEpisodeFailure implements GetEpisodeReslut {
  const GetEpisodeFailure(this.reason);
  final GetEpisodeFailureReason reason;
}

// TODO: Make this usable for all result types. Remove duplication.
enum GetEpisodeFailureReason { networkFailure, unknown }
