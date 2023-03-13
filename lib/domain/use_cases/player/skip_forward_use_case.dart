import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/media_player.dart';

class SkipForwardUseCase implements UseCase<Future<void>, int> {
  const SkipForwardUseCase(this._mediaPlayer);

  final MediaPlayer _mediaPlayer;

  @override
  Future<void> call<NoGeneric>(int seconds) async {
    await _mediaPlayer.skipForward(seconds);
  }
}
