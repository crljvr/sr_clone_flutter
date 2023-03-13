import 'package:sr_clone_flutter/domain/entities/episode.dart';

class Playlist {
  const Playlist({
    required this.title,
    required this.episodes,
  });

  final String title;
  final List<Episode> episodes;
}
