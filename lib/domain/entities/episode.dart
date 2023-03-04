import 'package:sr_clone_flutter/domain/entities/playable.dart';

abstract class Episode implements Playable {
  String get description;
  String get showName;
}
