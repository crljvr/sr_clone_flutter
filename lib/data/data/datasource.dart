import 'package:sr_clone_flutter/data/dtos/channel_dto.dart';
import 'package:sr_clone_flutter/data/dtos/episode_dto.dart';
import 'package:sr_clone_flutter/data/dtos/podcast_dto.dart';
import 'package:sr_clone_flutter/data/dtos/schedule_item_dto.dart';
import 'package:sr_clone_flutter/domain/entities/program.dart';

abstract class Datasource {
  Future<ChannelDto> getChannel(String channelId);
  Future<PodcastDto> getPodcast(String podcastId);
  Future<ProgramDto> getProgram(String programId);
  Future<List<EpisodeDto>> getEpisodes(String programId);
  Future<List<ScheduleItemDto>> getSchedule(String channelId, String formattedDate);
}

class UnableToGetChannelFromDatasourceException implements Exception {}

class UnableToGetPodcastFromDatasourceException implements Exception {}

class UnableToGetEpisodesFromDatasourceException implements Exception {}

class UnableToGetScheduleFromDatasourceException implements Exception {}
