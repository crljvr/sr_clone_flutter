import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/domain/extensions/date_time.dart';
import 'package:sr_clone_flutter/domain/repositories/channels/channels_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/channels/result_types.dart';

class ChannelsRepositoryImpl implements ChannelsRepository {
  const ChannelsRepositoryImpl(this._datasource);

  final Datasource _datasource;

  @override
  Future<GetChannelResult> getChannel(String id) async {
    try {
      final dto = await _datasource.getChannel(id);
      final channel = dto.asChannel;

      return GetChannelSuccessful(channel);
    } on UnableToGetChannelFromDatasourceException catch (_) {
      return const GetChannelFailure(GetChannelFailureReason.unknown);
    }
  }

  @override
  Future<GetScheduleResult> getSchedule(String channelId, DateTime date) async {
    try {
      final formattedDate = date.format(DateTimeFormat.yyyyMMdd);
      final dtos = await _datasource.getSchedule(channelId, formattedDate);
      final schedule = dtos.map((dto) => dto.asScheduleItem).toList();

      return GetScheduleSuccessful(schedule);
    } on UnableToGetScheduleFromDatasourceException catch (_) {
      return const GetScheduleFailure(GetScheduleFailureReason.unknown);
    }
  }
}
