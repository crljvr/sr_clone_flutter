import 'package:sr_clone_flutter/domain/entities/news_episode.dart';

class NewsEpisodeDto {
  const NewsEpisodeDto._({
    required this.description,
    required this.imageUrl,
    required this.name,
    required this.showName,
    required this.audioUrl,
  });

  factory NewsEpisodeDto.fromJson(Map<String, dynamic> json) {
    return NewsEpisodeDto._(
      audioUrl: ((json['broadcast']! as Map<String, dynamic>)['broadcastfiles']! as Map<String, dynamic>)['url']! as String,
      description: json['description']! as String,
      imageUrl: json['imageurl']! as String,
      name: json['title']! as String,
      showName: (json['program']! as Map<String, dynamic>)['name']! as String,
    );
  }

  final String audioUrl;
  final String description;
  final String imageUrl;
  final String name;
  final String showName;

  NewsEpisode get asNewsEpisode {
    return NewsEpisode(
      audioUrl: audioUrl,
      description: description,
      imageUrl: imageUrl,
      name: name,
      showName: showName,
    );
  }
}
