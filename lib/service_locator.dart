import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/data/data/open_api_datasource.dart';
import 'package:sr_clone_flutter/data/repositories/channels_repositoy_impl.dart';
import 'package:sr_clone_flutter/data/repositories/episodes_repository_impl.dart';
import 'package:sr_clone_flutter/domain/repositories/channels/channels_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/episodes_repository.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_channel_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/episodes/get_episode_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/pause_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/play_audio_use_case.dart';
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
    sl.registerFactory<ChannelsRepository>(() => ChannelsRepositoryImpl(sl()));
    sl.registerFactory<EpisodesRepository>(() => EpisodesRepositoryImpl(sl()));

    // Use Cases
    sl.registerFactory<GetChannelUseCase>(() => GetChannelUseCase(sl()));
    sl.registerFactory<GetEpisodeUseCase>(() => GetEpisodeUseCase(sl()));
    sl.registerFactory<LoadAudioUseCase>(() => LoadAudioUseCase(sl()));
    sl.registerFactory<PlayAudioUseCase>(() => PlayAudioUseCase(sl()));
    sl.registerFactory<PauseAudioUseCase>(() => PauseAudioUseCase(sl()));
  }
}
