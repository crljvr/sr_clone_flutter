import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sr_clone_flutter/domain/entities/playable.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/pause_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/player/play_audio_use_case.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/media_player.dart';
import 'package:sr_clone_flutter/presentation/colors.dart';

class PlayerViewModel extends ChangeNotifier {
  PlayerViewModel() {
    _mediaPlayer.addListener(notifyListeners);
  }

  final _mediaPlayer = GetIt.I<MediaPlayer>();

  final _playAudioUseCase = GetIt.I<PlayAudioUseCase>();
  final _pauseAudioUseCase = GetIt.I<PauseAudioUseCase>();

  Stream<MediaPlayerProcessingState> get processingState => _mediaPlayer.processingState;

  Stream<bool> get isPlaying => _mediaPlayer.isPlaying;

  Playable? get playable => _mediaPlayer.playable;

  Future<void> playAudio() async {
    await _playAudioUseCase.call(NoParams());
  }

  Future<void> pauseAudio() async {
    await _pauseAudioUseCase.call(NoParams());
  }
}

class Player extends StatefulWidget {
  const Player({required this.viewModel, super.key});

  final PlayerViewModel viewModel;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  late AnimationController offsetAnimationController;
  late Animation<double> offsetAnimation;

  @override
  void initState() {
    super.initState();
    offsetAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    offsetAnimation = Tween<double>(begin: 40, end: 0).animate(CurvedAnimation(parent: offsetAnimationController, curve: Curves.easeOutCubic));

    widget.viewModel.addListener(() {
      widget.viewModel.playable != null ? offsetAnimationController.forward() : offsetAnimationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: AnimatedBuilder(
        animation: offsetAnimationController,
        builder: (context, snapshot) {
          return Transform.translate(
            offset: Offset(0, offsetAnimation.value),
            child: Container(
              height: 40,
              color: SRColors.primaryBackground,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Builder(
                builder: (context) {
                  final playable = widget.viewModel.playable;
                  if (playable == null) return const SizedBox();

                  return _PlayerWithPlayable(
                    playable: playable,
                    isPlayingStream: widget.viewModel.isPlaying,
                    playAction: widget.viewModel.playAudio,
                    pauseAction: widget.viewModel.pauseAudio,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PlayerWithPlayable extends StatelessWidget {
  const _PlayerWithPlayable({
    required this.playable,
    required this.isPlayingStream,
    required this.playAction,
    required this.pauseAction,
  });

  final Playable playable;
  final Stream<bool> isPlayingStream;
  final VoidCallback playAction;
  final VoidCallback pauseAction;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: isPlayingStream,
      builder: (context, snapshot) {
        final isPlaying = snapshot.data ?? false;
        return Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(playable.imageUrl),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      playable.name,
                      style: const TextStyle(color: SRColors.primaryForeground, fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      playable.description,
                      style: const TextStyle(color: SRColors.primaryForeground, fontSize: 10, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: isPlaying ? pauseAction : playAction,
              icon: Icon(isPlaying ? CupertinoIcons.pause : CupertinoIcons.play_fill, color: SRColors.primaryForeground),
            )
          ],
        );
      },
    );
  }
}
