import 'package:flutter/widgets.dart';
import 'package:sr_clone_flutter/domain/entities/channel.dart';

class ChannelDto {
  const ChannelDto({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.tagline,
    required this.liveAudio,
  });

  factory ChannelDto.fromJson(Map<String, dynamic> json) {
    final channelWrapper = json['channel']! as Map<String, dynamic>;
    return ChannelDto(
      id: channelWrapper['id']! as int,
      name: channelWrapper['name']! as String,
      imageUrl: channelWrapper['image']! as String,
      color: channelWrapper['color']! as String,
      tagline: channelWrapper['tagline']! as String,
      liveAudio: LiveAudio.fromJson(channelWrapper['liveaudio']! as Map<String, dynamic>),
    );
  }

  /// Conviniece getter to convert Dto to Entitiy
  Channel get asChannel {
    return Channel(
      id: id,
      name: name,
      imageUrl: imageUrl,
      color: HexColor.fromHex(color),
      tagline: tagline,
      liveAudioUrl: liveAudio.url,
    );
  }

  final int id;
  final String name;
  final String imageUrl;
  final String color;
  final String tagline;
  final LiveAudio liveAudio;
}

class LiveAudio {
  const LiveAudio(this.url);

  factory LiveAudio.fromJson(Map<String, dynamic> json) {
    return LiveAudio(json['url']! as String);
  }

  final String url;
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
