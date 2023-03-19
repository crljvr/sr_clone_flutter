import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/get_player_content_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/pause_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/play_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/skip_backward_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/skip_forward_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/media_player.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';

class PlayerViewModel extends ChangeNotifier {
  PlayerViewModel(this.playerContent) {
    _getPlayerContentUseCase.call<NoGeneric>(NoParams()).listen((content) {
      if (content == null) return;
      playerContent = content;
      notifyListeners();
    });
  }

  final _mediaPlayer = GetIt.I<MediaPlayer>();
  final _playAudioUseCase = GetIt.I<PlayAudioUseCase>();
  final _pauseAudioUseCase = GetIt.I<PauseAudioUseCase>();
  final _skipForwardUseCase = GetIt.I<SkipForwardUseCase>();
  final _skipBackwardUseCase = GetIt.I<SkipBackwardUseCase>();
  final _getPlayerContentUseCase = GetIt.I<GetPlayerContentUseCase>();

  PlayerContent playerContent;

  // USE CASE THIS
  Stream<MediaPlayerData> get mediaPlayerDataStream => _mediaPlayer.getMediaPlayerDataStream();

  Future<void> playAudio() async {
    await _playAudioUseCase.call<NoGeneric>(NoParams());
  }

  Future<void> pauseAudio() async {
    await _pauseAudioUseCase.call<NoGeneric>(NoParams());
  }

  Future<void> skipForward(int seconds) async {
    await _skipForwardUseCase.call<NoGeneric>(seconds);
  }

  Future<void> skipBackward(int seconds) async {
    await _skipBackwardUseCase.call<NoGeneric>(seconds);
  }
}
