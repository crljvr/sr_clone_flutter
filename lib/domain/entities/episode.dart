import 'package:sr_clone_flutter/domain/entities/playable.dart';

class Episode {
  const Episode({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.imageUrl,
    required this.audioUrl,
    required this.startTime,
    required this.endTime,
  });

  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final int? duration;
  final String? startTime;
  final String? endTime;
  final String? audioUrl;
}
