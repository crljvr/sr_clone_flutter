import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/repositories/channels/channels_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/channels/result_types.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class GetChannelUseCase implements UseCase<Future<Channel>, String> {
  const GetChannelUseCase(this.channelsRepository);

  final ChannelsRepository channelsRepository;

  @override
  Future<Channel> call(String channelId) async {
    final result = await channelsRepository.getChannel(channelId);
    if (result is GetChannelSuccessful) return result.channel;
    if (result is GetChannelFailure) {
      switch (result.reason) {
        case GetChannelFailureReason.networkFailure:
          throw GetChannelNetworkException();
        case GetChannelFailureReason.unknown:
          throw GetChannelUnknownException();
      }
    }

    throw Exception();
  }
}

class GetChannelNetworkException implements Exception {}

class GetChannelUnknownException implements Exception {}
