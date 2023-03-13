import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/entities/schedule_item.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';

class CreatePlayerContentUseCase implements UseCase<PlayerContent, CreatePlayerContentParams> {
  @override
  PlayerContent call<N>(CreatePlayerContentParams params) {
    if (params is CreateOnAirPlayerContentParams) {
      return OnAirPlayerContent(params.channel, params.scheduleItems, params.currentScheduleItem);
    }
    throw UnimplementedError();
  }
}

abstract class CreatePlayerContentParams {}

class CreateOnAirPlayerContentParams implements CreatePlayerContentParams {
  const CreateOnAirPlayerContentParams({
    required this.channel,
    required this.scheduleItems,
    required this.currentScheduleItem,
  });

  final Channel channel;
  final List<ScheduleItem> scheduleItems;
  final ScheduleItem currentScheduleItem;
}
