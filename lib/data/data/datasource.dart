import 'package:sr_clone_flutter/data/dtos/channel_dto.dart';
import 'package:sr_clone_flutter/data/dtos/episode_dto.dart';

abstract class Datasource {
  Future<ChannelDto> getChannel(String channelId);
  Future<EpisodeDto> getEpisode(String episodeId);
}

class UnableToGetChannelFromDatasourceException implements Exception {}

class UnableToGetEpisodeFromDatasourceException implements Exception {}
