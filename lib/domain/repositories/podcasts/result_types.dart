import 'package:sr_clone_flutter/domain/entities/podcast.dart';

abstract class GetPodcastReslut {}

class GetPodcastSuccessful implements GetPodcastReslut {
  const GetPodcastSuccessful(this.podcast);
  final Podcast podcast;
}

class GetPodcastFailure implements GetPodcastReslut {
  const GetPodcastFailure(this.reason);
  final GetPodcastFailureReason reason;
}

// TODO: Make this usable for all result types. Remove duplication.
enum GetPodcastFailureReason { networkFailure, unknown }
