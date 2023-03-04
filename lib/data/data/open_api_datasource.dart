import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/data/dtos/channel_dto.dart';
import 'package:sr_clone_flutter/data/dtos/news_episode_dto.dart';
import 'package:sr_clone_flutter/data/dtos/podcast_dto.dart';
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
  Future<List<NewsEpisodeDto>> getNewsEpisodes(String programId) async {
    const path = 'https://api.sr.se/api/v2/episodes/index';
    final queryParameters = {
      'programid': programId,
      'format': 'json',
    };
    final endpoint = Endpoint(path: path, queryParameters: queryParameters);

    //TODO: SERIALIZATION IS WRONG.

    try {
      final data = await _networkManager.get(endpoint);
      final json = data['episodes']! as List<dynamic>;
      return json.map((value) {
        final jsonValue = value as Map<String, dynamic>;
        return NewsEpisodeDto.fromJson(jsonValue);
      }).toList();
    } catch (e) {
      throw UnableToGetNewsEpisodesFromDatasourceException();
    }
  }
}
