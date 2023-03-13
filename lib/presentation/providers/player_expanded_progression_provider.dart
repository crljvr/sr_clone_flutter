import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final playerExpandedProgressionProvider = StreamProvider<double>((ref) {
  return ref.watch(playerProvider).progress;
});

final playerProvider = Provider((ref) => PlayerProvider());

class PlayerProvider {
  final subject = BehaviorSubject<double>.seeded(0);

  void update(double value) {
    subject.add(value);
  }

  Stream<double> get progress => subject;
}
