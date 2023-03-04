import 'package:sr_clone_flutter/domain/entities/episode.dart';

class NewsEpisode implements Episode {
  const NewsEpisode({
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.showName,
    required this.audioUrl,
  });

  @override
  final String audioUrl;

  @override
  final String description;

  @override
  final String imageUrl;

  @override
  final String name;

  @override
  final String showName;
}
