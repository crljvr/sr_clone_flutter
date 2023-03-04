import 'package:sr_clone_flutter/domain/entities/episode.dart';

class Podcast implements Episode {
  const Podcast({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.audioUrl,
    required this.text,
    required this.duration,
    required this.fileSizeInBytes,
    required this.publishedDate,
    required this.showName,
  });

  /// The playable audio for the podcast
  @override
  final String audioUrl;

  /// The description of the podcast
  @override
  final String description;

  /// The cover image for the podcast
  @override
  final String imageUrl;

  /// The name of the podcast
  @override
  final String name;

  /// The description of the show
  final String text;

  /// The size of the playable podcast
  final int fileSizeInBytes;

  /// The name of the show
  final String showName;

  /// The date when the podcast was published
  final String publishedDate;
  // TODO: Make this a DateTime. Needs some parsing from API

  /// The duration of the podcast in seconds
  final int duration;
}
