import 'package:sr_clone_flutter/domain/repositories/channels/result_types.dart';

// ignore: one_member_abstracts
abstract class ChannelsRepository {
  Future<GetChannelResult> getChannel(String id);
  Future<GetScheduleResult> getSchedule(String channelId, DateTime date);
}
