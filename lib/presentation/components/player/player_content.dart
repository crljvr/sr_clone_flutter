import 'package:equatable/equatable.dart';
import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/entities/schedule_item.dart';

abstract class PlayerContent {
  String? get imageUrl;
}

class OnAirPlayerContent extends Equatable implements PlayerContent {
  const OnAirPlayerContent(this.channel, this.scheduleItems, this.currentScheduleItem);

  final Channel channel;
  final ScheduleItem currentScheduleItem;
  final List<ScheduleItem> scheduleItems;

  static ScheduleItem getCurrentScheduleItem(int nowInMilliseconds, List<ScheduleItem> scheduleItems) {
    final itemsToCome = scheduleItems.where((item) => item.startTime.millisecondsSinceEpoch < nowInMilliseconds);
    return itemsToCome.last;
  }

  Stream<double> get progress {
    return Stream.periodic(const Duration(seconds: 1), (_) {
      final progressInTime = DateTime.now().difference(currentScheduleItem.startTime);
      final duration = currentScheduleItem.endTime.difference(currentScheduleItem.startTime);
      return progressInTime.inMilliseconds / duration.inMilliseconds;
    });
  }

  @override
  String? get imageUrl => currentScheduleItem.imageUrl;

  @override
  List<Object?> get props => [channel, currentScheduleItem, scheduleItems];
}

class OnDemandPlayerContent implements PlayerContent {
  @override
  String? get imageUrl => 'TODO';
}
