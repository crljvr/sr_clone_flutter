import 'package:just_audio/just_audio.dart';
import 'package:sr_clone_flutter/domain/entities/playable.dart';

enum MediaPlayerProcessingState { idle, loading, buffering, ready, completed }

abstract class MediaPlayer {
  Future<void> load(Playable playable);
  Future<void> play();
  Future<void> pause();
  Future<void> skipForward(int duration);
  Future<void> skipBackward(int duration);

  Stream<MediaPlayerData> getMediaPlayerDataStream();
}

class MediaPlayerData {
  const MediaPlayerData({
    required this.processingState,
    required this.isPlaying,
    this.playable,
  });

  final MediaPlayerProcessingState processingState;
  final Playable? playable;
  final bool isPlaying;
}

class JustAudioMediaPlayer implements MediaPlayer {
  JustAudioMediaPlayer(this.player);

  final AudioPlayer player;

  Playable? _playable;
  Playable? get playable => _playable;

  @override
  Future<void> load(Playable playable) async {
    final audioSource = LockCachingAudioSource(Uri.parse(playable.audioUrl));
    await player.setAudioSource(audioSource);
    _playable = playable;
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
  Stream<MediaPlayerData> getMediaPlayerDataStream() => player.playerStateStream.map((playerState) {
        return MediaPlayerData(
          isPlaying: playerState.playing,
          processingState: _mapProccessingState(playerState.processingState),
          playable: _playable,
        );
      });

  MediaPlayerProcessingState _mapProccessingState(ProcessingState state) {
    switch (state) {
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
  }

  @override
  Future<void> skipForward(int duration) async {
    await player.seek(player.position + Duration(seconds: duration));
  }

  @override
  Future<void> skipBackward(int duration) async {
    await player.seek(Duration(seconds: player.position.inSeconds - 15));
  }
}
