import 'package:sr_clone_flutter/domain/entities/podcast.dart';

class PodcastDto {
  const PodcastDto._({
    required this.description,
    required this.imageUrl,
    required this.audioUrl,
    required this.text,
    required this.duration,
    required this.fileSizeInBytes,
    required this.publishedDate,
    required this.showName,
    required this.name,
  });

  factory PodcastDto.fromJson(Map<String, dynamic> json) {
    final episodeWrapper = json['episode'] as Map<String, dynamic>;
    final podfileWrapper = episodeWrapper['listenpodfile']! as Map<String, dynamic>;

    return PodcastDto._(
      audioUrl: podfileWrapper['url']! as String,
      description: episodeWrapper['description']! as String,
      duration: podfileWrapper['duration']! as int,
      fileSizeInBytes: podfileWrapper['filesizeinbytes']! as int,
      imageUrl: episodeWrapper['imageurltemplate']! as String,
      name: podfileWrapper['title']! as String,
      publishedDate: episodeWrapper['publishdateutc']! as String,
      showName: (episodeWrapper['program']! as Map<String, dynamic>)['name']! as String,
      text: episodeWrapper['text']! as String,
    );
  }

  /// Getter to convert DTO as Entity
  Podcast get asPodcast {
    return Podcast(
      name: name,
      description: description,
      imageUrl: imageUrl,
      audioUrl: audioUrl,
      text: text,
      duration: duration,
      fileSizeInBytes: fileSizeInBytes,
      publishedDate: publishedDate,
      showName: showName,
    );
  }

  final String name;
  final String description;
  final String imageUrl;
  final String audioUrl;
  final String text;
  final int fileSizeInBytes;
  final int duration;
  final String publishedDate;
  final String showName;
}
