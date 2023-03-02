import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sr_clone_flutter/domain/entities/playable.dart';

enum MediaPlayerProcessingState { idle, loading, buffering, ready, completed }

abstract class MediaPlayer extends ChangeNotifier {
  Future<void> load(Playable playable);
  Future<void> play();
  Future<void> pause();

  Stream<MediaPlayerProcessingState> get processingState;
  Stream<bool> get isPlaying;
  Playable? get playable;
}

class JustAudioMediaPlayer extends ChangeNotifier implements MediaPlayer {
  JustAudioMediaPlayer(this.player);

  final AudioPlayer player;

  Playable? _playable;

  @override
  Future<void> load(Playable playable) async {
    await player.setUrl(playable.audioUrl);
    _playable = playable;
    notifyListeners();
  }

  @override
  Future<void> play() async {
    await player.play();
  }

  @override
  Future<void> pause() async {
    await player.pause();
  }

  @override
  Stream<MediaPlayerProcessingState> get processingState => player.playerStateStream.map(
        (state) {
          switch (state.processingState) {
            case ProcessingState.idle:
              return MediaPlayerProcessingState.idle;
            case ProcessingState.loading:
              return MediaPlayerProcessingState.loading;
            case ProcessingState.buffering:
              return MediaPlayerProcessingState.buffering;
            case ProcessingState.ready:
              return MediaPlayerProcessingState.ready;
            case ProcessingState.completed:
              return MediaPlayerProcessingState.completed;
          }
        },
      );

  @override
  Stream<bool> get isPlaying => player.playerStateStream.map((state) => state.playing);

  @override
  Playable? get playable => _playable;
}
