import 'package:get_it/get_it.dart';
import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/entities/news_episode.dart';
import 'package:sr_clone_flutter/domain/entities/playlist.dart';
import 'package:sr_clone_flutter/domain/entities/podcast.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_channel_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/play_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/playlist/get_playlist_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/podcasts/get_podcast_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class StartViewModel {
  final _getChannelUseCase = GetIt.I<GetChannelUseCase>();
  final _getPodcastUseCase = GetIt.I<GetPodcastUseCase>();
  final _getPlaylistUseCase = GetIt.I<GetPlaylistUseCase>();
  final _loadAudioUseCase = GetIt.I<LoadAudioUseCase>();
  final _playAudioUseCase = GetIt.I<PlayAudioUseCase>();

  final List<String> channelIds = ['132', '163', '164', '213', '223'];

  Future<Channel> getChannel(String channelId) async {
    try {
      return _getChannelUseCase.call<NoGeneric>(channelId);
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

  Future<Podcast> getPodcast(String podcastId) async {
    try {
      return _getPodcastUseCase.call<NoGeneric>(podcastId);
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

  Future<Playlist> getPlaylist(String programId) async {
    try {
      return _getPlaylistUseCase.call<NewsEpisode>(programId);
    } on GetPlaylistException catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    } catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    }
  }

  Future<void> playChannelAudio(Channel channel) async {
    await _loadAudioUseCase.call<NoGeneric>(channel);
    await _playAudioUseCase.call<NoGeneric>(NoParams());
  }

  // Fixed id of featured episode. Might be controlled from CMS in the future
  // final String featuredEpisodeId = '2129263';
  final String featuredEpisodeId = '2120379';
}
