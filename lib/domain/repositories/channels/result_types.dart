import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/entities/schedule_item.dart';

abstract class GetChannelResult {}

class GetChannelSuccessful implements GetChannelResult {
  const GetChannelSuccessful(this.channel);
  final Channel channel;
}

class GetChannelFailure implements GetChannelResult {
  const GetChannelFailure(this.reason);
  final GetChannelFailureReason reason;
}

enum GetChannelFailureReason { networkFailure, unknown }

// ============================================= //

abstract class GetScheduleResult {}

class GetScheduleSuccessful implements GetScheduleResult {
  const GetScheduleSuccessful(this.scheduleItems);
  final List<ScheduleItem> scheduleItems;
}

class GetScheduleFailure implements GetScheduleResult {
  const GetScheduleFailure(this.reason);
  final GetScheduleFailureReason reason;
}

enum GetScheduleFailureReason { networkFailure, unknown }
