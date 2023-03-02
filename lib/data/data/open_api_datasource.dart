import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/data/dtos/channel_dto.dart';
import 'package:sr_clone_flutter/data/dtos/episode_dto.dart';
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
  Future<EpisodeDto> getEpisode(String episodeId) async {
    const path = 'https://api.sr.se/api/v2/episodes/get';
    final queryParameters = {
      'id': episodeId,
      'format': 'json',
    };
    final endpoint = Endpoint(path: path, queryParameters: queryParameters);

    try {
      final data = await _networkManager.get(endpoint);
      return EpisodeDto.fromJson(data);
    } on NetworkError catch (_) {
      throw UnableToGetEpisodeFromDatasourceException();
    }
  }
}
