import 'package:sr_clone_flutter/domain/entities/playable.dart';

class Channel implements Playable {
  const Channel({
    required this.name,
    required this.imageUrl,
    required this.audioUrl,
  });

  @override
  final String name;

  @override
  final String imageUrl;

  @override
  final String audioUrl;

  @override
  String get description => 'TBA';
}
