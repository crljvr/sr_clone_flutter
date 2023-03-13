import 'package:sr_clone_flutter/domain/entities/playable.dart';

class Podcast implements Playable {
  Podcast({
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
  final String description;

  /// The cover image for the podcast
  final String imageUrl;

  /// The name of the podcast
  final String name;

  /// The name of the show
  final String showName;

  /// The description of the show
  final String text;

  /// The size of the playable podcast
  final int fileSizeInBytes;

  /// The date when the podcast was published
  final String publishedDate;
  // TODO: Make this a DateTime. Needs some parsing from API

  /// The duration of the podcast in seconds
  final int duration;
}
