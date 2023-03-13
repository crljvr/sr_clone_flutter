import 'package:sr_clone_flutter/domain/entities/episode.dart';

class EpisodeDto {
  const EpisodeDto._({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.showName,
    required this.broadcast,
    required this.broadcastTime,
  });

  factory EpisodeDto.fromJson(Map<String, dynamic> json) {
    return EpisodeDto._(
      id: json['id']! as int,
      title: json['title']! as String,
      description: json['description']! as String,
      imageUrl: json['imageurltemplate']! as String,
      showName: (json['program']! as Map<String, dynamic>)['name']! as String,
      broadcast: json['broadcast'] != null ? Broadcast.fromJson(json['broadcast'] as Map<String, dynamic>) : null,
      broadcastTime: json['broadcasttime'] != null ? BroadcastTime.fromJson(json['broadcasttime']! as Map<String, dynamic>) : null,
    );
  }

  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String showName;
  final Broadcast? broadcast;
  final BroadcastTime? broadcastTime;

  Episode get asEpisode {
    return Episode(
      id: id,
      title: title,
      description: description,
      duration: broadcast?.broadcastFiles.first.duration,
      imageUrl: imageUrl,
      audioUrl: broadcast?.broadcastFiles.first.url,
      startTime: broadcastTime?.startTimeUtc,
      endTime: broadcastTime?.endTimeUtc,
    );
  }
}

class Broadcast {
  const Broadcast({required this.broadcastFiles});

  factory Broadcast.fromJson(Map<String, dynamic> json) {
    return Broadcast(broadcastFiles: (json['broadcastfiles'] as List<dynamic>).map((json) => BroadcastFile.fromJson(json as Map<String, dynamic>)).toList());
  }

  final List<BroadcastFile> broadcastFiles;
}

class BroadcastFile {
  const BroadcastFile({
    required this.url,
    required this.duration,
  });

  factory BroadcastFile.fromJson(Map<String, dynamic> json) {
    return BroadcastFile(
      url: json['url']! as String,
      duration: json['duration']! as int,
    );
  }

  final String url;
  final int duration;
}

class BroadcastTime {
  const BroadcastTime({
    required this.startTimeUtc,
    required this.endTimeUtc,
  });

  factory BroadcastTime.fromJson(Map<String, dynamic> json) {
    return BroadcastTime(
      startTimeUtc: json['starttimeutc']! as String,
      endTimeUtc: json['endtimeutc']! as String,
    );
  }

  final String startTimeUtc;
  final String endTimeUtc;
}
