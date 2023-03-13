import 'package:equatable/equatable.dart';

class ScheduleItem extends Equatable {
  const ScheduleItem({
    required this.episodeid,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.imageUrl,
  });

  final int? episodeid;
  final String title;
  final String? subtitle;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String? imageUrl;

  int get duration {
    return endTime.difference(startTime).inMinutes;
  }

  @override
  List<Object?> get props => [episodeid, title, subtitle, description, startTime, endTime, imageUrl];
}
