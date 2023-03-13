import 'package:flutter/widgets.dart';

class Channel {
  const Channel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.color,
    required this.tagline,
    required this.liveAudioUrl,
  });

  final int id;
  final String name;
  final String imageUrl;
  final Color color;
  final String tagline;
  final String liveAudioUrl;
}
