import 'package:get_it/get_it.dart';
import 'package:sr_clone_flutter/domain/entities/playable.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_channel_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_schedule_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/create_player_content_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_content_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/service_locator.dart';

class Bootstrap {
  static const initalChannelId = '132';

  Future<BootstrapData> call() async {
    await _initializeServiceLocator();
    final playerData = await _preLoadPlayerContent();

    return BootstrapData(playerData);
  }

  Future<void> _initializeServiceLocator() async {
    await ServiceLocator.start();
  }

  Future<PlayerContent> _preLoadPlayerContent() async {
    // Get Channel data
    final channel = await GetIt.I<GetChannelUseCase>().call<NoGeneric>(initalChannelId);
    // Get the channel schedule
    final scheduleItems = await GetIt.I<GetScheduleUseCase>().call<NoGeneric>(GetScheduleParams(initalChannelId, DateTime.now()));

    /// Get the channels current content
    final currentScheduleItem = OnAirPlayerContent.getCurrentScheduleItem(DateTime.now().millisecondsSinceEpoch, scheduleItems);

    // Create a playable content for the player
    final params = CreateOnAirPlayerContentParams(channel: channel, scheduleItems: scheduleItems, currentScheduleItem: currentScheduleItem);
    final playerContent = GetIt.I<CreatePlayerContentUseCase>().call<NoGeneric>(params);

    // Load the audio in the player
    await GetIt.I<LoadAudioUseCase>().call<NoGeneric>(OnAirPlayable(channel.liveAudioUrl));
    // Load the content in the player
    GetIt.I<LoadContentUseCase>().call<NoGeneric>(playerContent);

    return playerContent;
  }
}

class BootstrapData {
  const BootstrapData(this.playerContent);
  final PlayerContent playerContent;
}
