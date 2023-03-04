import 'package:sr_clone_flutter/domain/entities/news_episode.dart';

abstract class GetNewsEpisodesReslut {}

class GetNewsEpisodesSuccessful implements GetNewsEpisodesReslut {
  const GetNewsEpisodesSuccessful(this.episodes);
  final List<NewsEpisode> episodes;
}

class GetNewsEpisodesFailure implements GetNewsEpisodesReslut {
  const GetNewsEpisodesFailure(this.reason);
  final GetNewsEpisodesFailureReason reason;
}

// TODO: Make this usable for all result types. Remove duplication.
enum GetNewsEpisodesFailureReason { networkFailure, unknown }
