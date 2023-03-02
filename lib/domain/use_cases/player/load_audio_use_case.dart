import 'package:sr_clone_flutter/domain/entities/playable.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/media_player.dart';

class LoadAudioUseCase implements UseCase<Future<void>, Playable> {
  const LoadAudioUseCase(this.audioPlayer);

  final MediaPlayer audioPlayer;

  @override
  Future<void> call(Playable playable) async {
    await audioPlayer.load(playable);
  }
}
