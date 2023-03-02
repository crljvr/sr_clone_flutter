import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/media_player.dart';

class PauseAudioUseCase implements UseCase<Future<void>, NoParams> {
  const PauseAudioUseCase(this.mediaPlayer);

  final MediaPlayer mediaPlayer;

  @override
  Future<void> call(NoParams params) async {
    await mediaPlayer.pause();
  }
}
