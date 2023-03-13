import 'package:sr_clone_flutter/domain/entities/schedule_item.dart';
import 'package:sr_clone_flutter/domain/repositories/channels/channels_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/channels/result_types.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class GetScheduleUseCase implements UseCase<Future<List<ScheduleItem>>, GetScheduleParams> {
  const GetScheduleUseCase(this._channelsRepository);

  final ChannelsRepository _channelsRepository;

  @override
  Future<List<ScheduleItem>> call<NoGeneric>(GetScheduleParams params) async {
    final result = await _channelsRepository.getSchedule(params.channelId, params.date);
    if (result is GetScheduleSuccessful) return result.scheduleItems;
    if (result is GetScheduleFailure) {
      switch (result.reason) {
        case GetScheduleFailureReason.networkFailure:
          throw GetScheduleException();
        case GetScheduleFailureReason.unknown:
          throw GetScheduleException();
      }
    }
    throw Exception();
  }
}

class GetScheduleParams {
  const GetScheduleParams(this.channelId, this.date);
  final String channelId;
  final DateTime date;
}

class GetScheduleException implements Exception {}
