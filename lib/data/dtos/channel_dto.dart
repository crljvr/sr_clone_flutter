import 'package:sr_clone_flutter/domain/entities/channel.dart';

class ChannelDto {
  const ChannelDto({
    required this.name,
    required this.imageUrl,
    required this.audioUrl,
  });

  factory ChannelDto.fromJson(Map<String, dynamic> json) {
    final channelWrapper = json['channel']! as Map<String, dynamic>;
    return ChannelDto(
      name: channelWrapper['name']! as String,
      imageUrl: channelWrapper['image']! as String,
      audioUrl: (channelWrapper['liveaudio']! as Map<String, dynamic>)['url']! as String,
    );
  }

  /// Conviniece getter to convert Dto to Entitiy
  Channel get asChannel {
    return Channel(name: name, imageUrl: imageUrl, audioUrl: audioUrl);
  }

  final String name;
  final String imageUrl;
  final String audioUrl;
}
