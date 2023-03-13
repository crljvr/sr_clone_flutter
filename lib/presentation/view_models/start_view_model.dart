import 'package:get_it/get_it.dart';
import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/entities/episode.dart';
import 'package:sr_clone_flutter/domain/entities/playable.dart';
import 'package:sr_clone_flutter/domain/entities/playlist.dart';
import 'package:sr_clone_flutter/domain/entities/podcast.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_channel_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_schedule_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/episodes/get_episodes_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_content_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/play_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/podcasts/get_podcast_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/programs/get_program_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';

class StartViewModel {
  final _getProgramUseCase = GetIt.I<GetProgramUseCase>();
  final _getChannelUseCase = GetIt.I<GetChannelUseCase>();
  final _getPodcastUseCase = GetIt.I<GetPodcastUseCase>();
  final _getEpisodesUseCase = GetIt.I<GetEpisodesUseCase>();
  final _getScheduleUseCase = GetIt.I<GetScheduleUseCase>();
  final _loadAudioUseCase = GetIt.I<LoadAudioUseCase>();
  final _playAudioUseCase = GetIt.I<PlayAudioUseCase>();
  final _loadContentUseCase = GetIt.I<LoadContentUseCase>();

  final List<String> channelIds = ['132', '163', '164', '213', '223'];
  final List<String> newsChannelIds = ['103', '5380', '5285', '86'];

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
      final program = await _getProgramUseCase.call<NoGeneric>(programId);
      final episodes = await _getEpisodesUseCase.call<NoGeneric>(programId);
      return Playlist(title: program.name, episodes: episodes);
    } on GetEpisodesException catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    } catch (_) {
      // TODO: Handle error
      throw UnimplementedError();
    }
  }

  Future<void> playChannelAudio(Channel channel) async {
    await _loadAudioUseCase.call<NoGeneric>(OnAirPlayable(channel.liveAudioUrl));

    final params = GetScheduleParams(channel.id.toString(), DateTime.now());
    final scheduleItems = await _getScheduleUseCase.call<NoGeneric>(params);
    final currentScheduleItem = OnAirPlayerContent.getCurrentScheduleItem(DateTime.now().millisecondsSinceEpoch, scheduleItems);
    final playerContent = OnAirPlayerContent(channel, scheduleItems, currentScheduleItem);
    _loadContentUseCase.call<NoGeneric>(playerContent);

    await _playAudioUseCase.call<NoGeneric>(NoParams());
  }

  // Fixed id of featured episode. Might be controlled from CMS in the future
  // final String featuredEpisodeId = '2129263';
  final String featuredEpisodeId = '2120379';
}
