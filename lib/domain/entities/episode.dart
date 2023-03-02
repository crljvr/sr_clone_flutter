import 'package:sr_clone_flutter/domain/entities/playable.dart';

class Episode implements Playable {
  const Episode({
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

  /// The playable audio for the episode
  @override
  final String audioUrl;

  /// The description of the episode
  @override
  final String description;

  /// The cover image for the episode
  @override
  final String imageUrl;

  /// The name of the episode
  @override
  final String name;

  /// The description of the show
  final String text;

  /// The size of the playable episode
  final int fileSizeInBytes;

  /// The name of the show
  final String showName;

  /// The date of publish
  final String publishedDate;
  // TODO: Make this a DateTime. Needs some parsing from API

  /// The duration of the episode in seconds
  final int duration;
}
