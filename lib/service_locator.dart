import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/data/data/open_api_datasource.dart';
import 'package:sr_clone_flutter/data/repositories/channels_repositoy_impl.dart';
import 'package:sr_clone_flutter/data/repositories/episodes_repository_impl.dart';
import 'package:sr_clone_flutter/data/repositories/player_repository_impl.dart';
import 'package:sr_clone_flutter/data/repositories/podcasts_repository_impl.dart';
import 'package:sr_clone_flutter/data/repositories/programs_repository_impl.dart';

import 'package:sr_clone_flutter/domain/repositories/channels/channels_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/episodes_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/player/player_repository.dart';

import 'package:sr_clone_flutter/domain/repositories/podcasts/podcasts_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/programs/programs_repository.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_channel_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_schedule_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/episodes/get_episodes_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/create_player_content_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/get_player_content_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_content_use_case.dart';

import 'package:sr_clone_flutter/domain/use_cases/player/pause_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/play_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/skip_backward_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/skip_forward_use_case.dart';

import 'package:sr_clone_flutter/domain/use_cases/podcasts/get_podcast_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/programs/get_program_use_case.dart';
import 'package:sr_clone_flutter/media_player.dart';
import 'package:sr_clone_flutter/network_manager.dart';

class ServiceLocator {
  static Future<void> start() async {
    final sl = GetIt.instance;

    // Modules
    sl.registerFactory<NetworkManager>(() => DioNetworkManager(Dio()));
    sl.registerLazySingleton<MediaPlayer>(() => JustAudioMediaPlayer(AudioPlayer()));

    // Datasources
    sl.registerFactory<Datasource>(() => OpenApiDatasource(sl()));

    // Repositories
    sl.registerLazySingleton<PlayerRepository>(PlayerRepositoryImpl.new);
    sl.registerFactory<ChannelsRepository>(() => ChannelsRepositoryImpl(sl()));
    sl.registerFactory<EpisodesRepository>(() => EpisodesRepositoryImpl(sl()));
    sl.registerFactory<PodcastsRepository>(() => PodcastsRepositoryImpl(sl()));
    sl.registerFactory<ProgramsRepository>(() => ProgramsRepositoryImpl(sl()));

    // Use Cases
    sl.registerFactory<GetPlayerContentUseCase>(() => GetPlayerContentUseCase(sl()));
    sl.registerFactory<GetChannelUseCase>(() => GetChannelUseCase(sl()));
    sl.registerFactory<GetProgramUseCase>(() => GetProgramUseCase(sl()));
    sl.registerFactory<GetPodcastUseCase>(() => GetPodcastUseCase(sl()));
    sl.registerFactory<GetEpisodesUseCase>(() => GetEpisodesUseCase(sl()));
    sl.registerFactory<GetScheduleUseCase>(() => GetScheduleUseCase(sl()));
    sl.registerFactory<LoadAudioUseCase>(() => LoadAudioUseCase(sl()));
    sl.registerFactory<LoadContentUseCase>(() => LoadContentUseCase(sl()));
    sl.registerFactory<PlayAudioUseCase>(() => PlayAudioUseCase(sl()));
    sl.registerFactory<PauseAudioUseCase>(() => PauseAudioUseCase(sl()));
    sl.registerFactory<SkipForwardUseCase>(() => SkipForwardUseCase(sl()));
    sl.registerFactory<SkipBackwardUseCase>(() => SkipBackwardUseCase(sl()));
    sl.registerFactory<CreatePlayerContentUseCase>(CreatePlayerContentUseCase.new);
  }
}
