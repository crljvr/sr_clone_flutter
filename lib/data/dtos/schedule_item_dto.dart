import 'package:sr_clone_flutter/data/data/open_api_datasource.dart';
import 'package:sr_clone_flutter/domain/entities/schedule_item.dart';

class ScheduleItemDto {
  const ScheduleItemDto({
    required this.episodeId,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.imageUrl,
  });

  factory ScheduleItemDto.fromJson(Map<String, dynamic> json) {
    return ScheduleItemDto(
      episodeId: json['episodeid'] != null ? json['episodeid']! as int : null,
      title: json['title']! as String,
      subtitle: json['subtitle'] != null ? json['subtitle']! as String : null,
      description: json['description']! as String,
      startTime: json['starttimeutc']! as String,
      endTime: json['endtimeutc']! as String,
      imageUrl: json['imageurltemplate'] != null ? json['imageurltemplate']! as String : null,
    );
  }

  ScheduleItem get asScheduleItem {
    return ScheduleItem(
      episodeid: episodeId,
      title: title,
      subtitle: subtitle,
      description: description,
      startTime: OpenApiDatasource.formatToDateTime(startTime),
      endTime: OpenApiDatasource.formatToDateTime(endTime),
      imageUrl: imageUrl,
    );
  }

  final int? episodeId;
  final String title;
  final String? subtitle;
  final String description;
  final String startTime;
  final String endTime;
  final String? imageUrl;
}
