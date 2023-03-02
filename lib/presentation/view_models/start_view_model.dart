import 'package:get_it/get_it.dart';
import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/entities/episode.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_channel_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/episodes/get_episode_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/play_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class StartViewModel {
  final _getChannelUseCase = GetIt.I<GetChannelUseCase>();
  final _getEpisodeUseCase = GetIt.I<GetEpisodeUseCase>();
  final _loadAudioUseCase = GetIt.I<LoadAudioUseCase>();
  final _playAudioUseCase = GetIt.I<PlayAudioUseCase>();

  Future<Channel> getChannel(String channelId) async {
    try {
      return _getChannelUseCase.call(channelId);
    } on GetChannelNetworkException catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    } on GetChannelUnknownException catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    } catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    }
  }

  Future<Episode> getEpisode(String episodeId) async {
    try {
      return _getEpisodeUseCase.call(episodeId);
    } on GetChannelNetworkException catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    } on GetChannelUnknownException catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    } catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    }
  }

  Future<void> playChannelAudio(Channel channel) async {
    await _loadAudioUseCase.call(channel);
    await _playAudioUseCase.call(NoParams());
  }

  // Fixed id of featured episode. Might be controlled from CMS in the future
  // final String featuredEpisodeId = '2129263';
  final String featuredEpisodeId = '2120379';
}
