import 'package:flutter/material.dart' hide Router;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:sr_clone_flutter/domain/entities/playable.dart';
import 'package:sr_clone_flutter/domain/repositories/channels/channels_repository.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_channel_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/channels/get_schedule_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/create_player_content_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/load_content_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/router.dart';
import 'package:sr_clone_flutter/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.start();
  final bootstrapData = await bootstrap();

  runApp(
    ProviderScope(
      child: MaterialApp.router(
        routerConfig: Router.config(RouterData(bootstrapData.playerContent)),
      ),
    ),
  );
}

Future<BootstrapData> bootstrap() async {
  final channel = await GetIt.I<GetChannelUseCase>().call<NoGeneric>('132');
  final scheduleItems = await GetIt.I<GetScheduleUseCase>().call<NoGeneric>(GetScheduleParams('132', DateTime.now()));
  final currentScheduleItem = OnAirPlayerContent.getCurrentScheduleItem(DateTime.now().millisecondsSinceEpoch, scheduleItems);
  final params = CreateOnAirPlayerContentParams(channel: channel, scheduleItems: scheduleItems, currentScheduleItem: currentScheduleItem);
  final playerContent = GetIt.I<CreatePlayerContentUseCase>().call<NoGeneric>(params);

  await GetIt.I<LoadAudioUseCase>().call<NoGeneric>(OnAirPlayable(channel.liveAudioUrl));
  GetIt.I<LoadContentUseCase>().call<NoGeneric>(playerContent);

  return BootstrapData(playerContent);
}

class BootstrapData {
  const BootstrapData(this.playerContent);
  final PlayerContent playerContent;
}
