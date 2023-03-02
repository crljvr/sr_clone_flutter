import 'package:sr_clone_flutter/domain/entities/channel.dart';

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
