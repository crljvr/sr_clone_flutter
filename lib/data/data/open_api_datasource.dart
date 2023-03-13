import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/data/dtos/channel_dto.dart';
import 'package:sr_clone_flutter/data/dtos/episode_dto.dart';
import 'package:sr_clone_flutter/data/dtos/podcast_dto.dart';
import 'package:sr_clone_flutter/data/dtos/schedule_item_dto.dart';
import 'package:sr_clone_flutter/domain/entities/program.dart';
import 'package:sr_clone_flutter/network_manager.dart';

class OpenApiDatasource implements Datasource {
  const OpenApiDatasource(this._networkManager);

  final NetworkManager _networkManager;

  @override
  Future<ChannelDto> getChannel(String channelId) async {
    final path = 'https://api.sr.se/api/v2/channels/$channelId';
    final queryParameters = {'format': 'json'};
    final endpoint = Endpoint(path: path, queryParameters: queryParameters);

    try {
      final data = await _networkManager.get(endpoint);
      return ChannelDto.fromJson(data);
    } on NetworkError catch (_) {
      throw UnableToGetChannelFromDatasourceException();
    }
  }

  @override
  Future<PodcastDto> getPodcast(String podcastId) async {
    const path = 'https://api.sr.se/api/v2/episodes/get';
    final queryParameters = {
      'id': podcastId,
      'format': 'json',
    };
    final endpoint = Endpoint(path: path, queryParameters: queryParameters);

    try {
      final data = await _networkManager.get(endpoint);
      return PodcastDto.fromJson(data);
    } on NetworkError catch (_) {
      throw UnableToGetPodcastFromDatasourceException();
    }
  }

  @override
  Future<List<EpisodeDto>> getEpisodes(String programId) async {
    const path = 'https://api.sr.se/api/v2/episodes/index';
    final queryParameters = {
      'programid': programId,
      'format': 'json',
    };
    final endpoint = Endpoint(path: path, queryParameters: queryParameters);

    try {
      final data = await _networkManager.get(endpoint);
      final json = data['episodes']! as List<dynamic>;
      return json.map((value) {
        final jsonValue = value as Map<String, dynamic>;
        return EpisodeDto.fromJson(jsonValue);
      }).toList();
    } catch (e) {
      throw UnableToGetEpisodesFromDatasourceException();
    }
  }

  @override
  Future<List<ScheduleItemDto>> getSchedule(String channelId, String formattedDate) async {
    const path = 'http://api.sr.se/api/v2/scheduledepisodes';
    final queryParameters = {
      'channelid': channelId,
      'date': formattedDate,
      'pagination': false,
      'format': 'json',
    };
    final endpoint = Endpoint(path: path, queryParameters: queryParameters);

    try {
      final data = await _networkManager.get(endpoint);
      final json = data['schedule']! as List<dynamic>;
      return json.map((value) {
        final jsonValue = value as Map<String, dynamic>;
        return ScheduleItemDto.fromJson(jsonValue);
      }).toList();
    } catch (e) {
      throw UnableToGetEpisodesFromDatasourceException();
    }
  }

  static DateTime formatToDateTime(String apiDate) {
    final string = apiDate;
    final splitFirst = string.split('(');
    final splitSecond = splitFirst[1].split(')');
    final unix = int.parse(splitSecond[0]);

    return DateTime.fromMillisecondsSinceEpoch(unix);
  }

  @override
  Future<ProgramDto> getProgram(String programId) async {
    final path = 'http://api.sr.se/api/v2/programs/$programId';
    final queryParameters = {
      'format': 'json',
    };
    final endpoint = Endpoint(path: path, queryParameters: queryParameters);

    try {
      final data = await _networkManager.get(endpoint);
      final json = data['program']! as Map<String, dynamic>;
      return ProgramDto.fromJson(json);
    } catch (e) {
      throw UnableToGetEpisodesFromDatasourceException();
    }
  }
}
