import 'package:sr_clone_flutter/data/dtos/channel_dto.dart';
import 'package:sr_clone_flutter/data/dtos/news_episode_dto.dart';
import 'package:sr_clone_flutter/data/dtos/podcast_dto.dart';

abstract class Datasource {
  Future<ChannelDto> getChannel(String channelId);
  Future<PodcastDto> getPodcast(String podcastId);
  Future<List<NewsEpisodeDto>> getNewsEpisodes(String programId);
}

class UnableToGetChannelFromDatasourceException implements Exception {}

class UnableToGetPodcastFromDatasourceException implements Exception {}

class UnableToGetNewsEpisodesFromDatasourceException implements Exception {}
