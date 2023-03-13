import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sr_clone_flutter/domain/extensions/date_time.dart';
import 'package:sr_clone_flutter/media_player.dart';

import 'package:sr_clone_flutter/presentation/colors.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/presentation/constants.dart';
import 'package:sr_clone_flutter/presentation/providers/player_expanded_progression_provider.dart';

class OnAirMiniPlayer extends ConsumerWidget {
  const OnAirMiniPlayer({
    required this.content,
    required this.playerDataStream,
    required this.onButtonTap,
    super.key,
  });

  final OnAirPlayerContent content;
  final Stream<MediaPlayerData> playerDataStream;
  final void Function(bool) onButtonTap;

  static const miniPlayerHeight = 40;

  double _getOpacity(double progression) {
    // Makes sure that opacity wont adjusted when miniplayer is in view.
    final adjustedProgression = progression < 0.04 ? 0.0 : progression;
    return (1 - (adjustedProgression * 3)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerExpandedProgression = ref.watch(playerExpandedProgressionProvider).value ?? 1.0;
    return Container(
      color: SRColors.primaryBackground,
      height: miniPlayerHeight + SRConstants.bottomNavigationBarHeight,
      child: Opacity(
        opacity: _getOpacity(playerExpandedProgression),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                children: [
                  const SizedBox(width: SRConstants.spacing4),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: SRConstants.spacing2),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: content.channel.color,
                          borderRadius: BorderRadius.circular(SRConstants.spacing1),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(content.channel.imageUrl),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: SRConstants.spacing3),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: SRConstants.spacing2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '· ${content.channel.name}',
                            style: const TextStyle(
                              color: SRColors.primaryForeground,
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            '${content.currentScheduleItem.startTime.format(DateTimeFormat.jm)} - ${content.currentScheduleItem.endTime.format(DateTimeFormat.jm)} · ${content.channel.name}',
                            style: const TextStyle(color: SRColors.primaryForeground, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder(
                    stream: playerDataStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final isPlaying = snapshot.data!.isPlaying;
                        return GestureDetector(
                          onTap: () => onButtonTap(isPlaying),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Icon(isPlaying ? CupertinoIcons.pause : CupertinoIcons.play_fill, color: SRColors.primaryForeground),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
            Progressbar(progress: content.progress),
          ],
        ),
      ),
    );
  }
}

class Progressbar extends StatelessWidget {
  const Progressbar({
    required this.progress,
    super.key,
  });

  final Stream<double> progress;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: progress,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 5,
            child: Stack(
              children: [
                Container(
                  color: SRColors.primaryForeground.withOpacity(.5),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.5),
                  child: Container(
                    height: 5,
                    width: MediaQuery.of(context).size.width * snapshot.data!,
                    color: SRColors.primaryForeground,
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class ErrorMiniPlayer extends StatelessWidget {
  const ErrorMiniPlayer({required this.errorMessage, super.key});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: SRColors.primaryBackground,
      child: Center(
        child: Text(errorMessage, style: const TextStyle(color: SRColors.primaryForeground)),
      ),
    );
  }
}
