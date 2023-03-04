import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/media_player.dart';

class PlayAudioUseCase implements UseCase<Future<void>, NoParams> {
  const PlayAudioUseCase(this.mediaPlayer);

  final MediaPlayer mediaPlayer;

  @override
  Future<void> call<NoGeneric>(NoParams params) async {
    await mediaPlayer.play();
  }
}
