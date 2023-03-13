import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sr_clone_flutter/domain/extensions/date_time.dart';
import 'package:sr_clone_flutter/media_player.dart';
import 'package:sr_clone_flutter/presentation/colors.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/presentation/constants.dart';

class OnAirLargePlayer extends StatelessWidget {
  const OnAirLargePlayer({
    required this.playerContent,
    required this.playerDataStream,
    required this.onPlayPauseButtonTap,
    required this.onSkipForwardButtonTap,
    required this.onSkipBackwardButtonTap,
    super.key,
  });

  final OnAirPlayerContent playerContent;
  final Stream<MediaPlayerData> playerDataStream;
  final void Function(bool) onPlayPauseButtonTap;
  final VoidCallback onSkipForwardButtonTap;
  final VoidCallback onSkipBackwardButtonTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SRColors.primaryBackground,
      constraints: const BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SRConstants.spacing5),
            child: Column(
              children: [
                _OnAirTopRowControls(playerContent: playerContent),
                _HeroImage(playerContent: playerContent),
                _ShowInformation(playerContent: playerContent),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SRConstants.spacing5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const OnAirIndicationButton(),
                const SizedBox(height: SRConstants.spacing4),
                ProgressInformation(playerContent: playerContent),
                const SizedBox(height: SRConstants.spacing1),
                ProgressBar(progressStream: playerContent.progress),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PlayerControlButton.small(
                        iconData: CupertinoIcons.backward_end_fill,
                        onTap: () {},
                        disabled: true,
                      ),
                      PlayerControlButton.medium(
                        iconData: CupertinoIcons.gobackward_15,
                        onTap: onSkipBackwardButtonTap,
                        disabled: true,
                      ),
                      StreamBuilder<bool>(
                        stream: playerDataStream.map((data) => data.isPlaying),
                        builder: (context, snapshot) {
                          final isPlaying = snapshot.data ?? false;
                          return PlayerControlButton.large(
                            iconData: isPlaying ? CupertinoIcons.pause : CupertinoIcons.play_fill,
                            onTap: () => onPlayPauseButtonTap(isPlaying),
                          );
                        },
                      ),
                      PlayerControlButton.medium(
                        iconData: CupertinoIcons.goforward_15,
                        onTap: onSkipForwardButtonTap,
                        disabled: true,
                      ),
                      PlayerControlButton.small(
                        iconData: CupertinoIcons.forward_end_fill,
                        onTap: () {},
                        disabled: true,
                      ),
                    ],
                  ),
                ),
                const _ActionItemsSection(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OnAirIndicationButton extends StatelessWidget {
  const OnAirIndicationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SRConstants.spacing3),
      decoration: BoxDecoration(
        color: SRColors.secodaryHighlight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Text(
        'Direktsändning',
        style: TextStyle(
          color: SRColors.primaryForeground,
          fontWeight: FontWeight.w500,
          fontSize: 10,
        ),
      ),
    );
  }
}

class ProgressInformation extends StatelessWidget {
  const ProgressInformation({
    required this.playerContent,
    super.key,
  });

  final OnAirPlayerContent playerContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          playerContent.currentScheduleItem.startTime.format(DateTimeFormat.jm),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: SRColors.primaryForeground,
          ),
        ),
        Text(
          playerContent.currentScheduleItem.endTime.format(DateTimeFormat.jm),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: SRColors.primaryForeground,
          ),
        )
      ],
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    required this.progressStream,
    super.key,
  });

  final Stream<double> progressStream;

  double getProgressDistance(double progress, double progressBarWidth) {
    return progressBarWidth * progress;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return StreamBuilder<double>(
            stream: progressStream,
            builder: (context, snapshot) {
              final progress = snapshot.data ?? 0.0;
              return Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 5,
                    color: SRColors.primaryForeground.withOpacity(.5),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: constraints.maxWidth * progress,
                    child: ClipOval(
                      child: Container(
                        height: 16,
                        width: 16,
                        color: SRColors.primaryForeground,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

enum PlayerControlButtonType {
  large(70, 45),
  medium(50, 32),
  small(40, 18);

  const PlayerControlButtonType(this.backgroundSize, this.iconSize);

  final double iconSize;
  final double backgroundSize;
}

class PlayerControlButton extends StatelessWidget {
  const PlayerControlButton._(this.icon, this.type, this.background, this.onTap, this.disabled);

  factory PlayerControlButton.large({required IconData iconData, required VoidCallback onTap, bool? disabled}) {
    return PlayerControlButton._(iconData, PlayerControlButtonType.large, true, onTap, disabled ?? false);
  }

  factory PlayerControlButton.medium({required IconData iconData, required VoidCallback onTap, bool? disabled}) {
    return PlayerControlButton._(iconData, PlayerControlButtonType.medium, false, onTap, disabled ?? false);
  }

  factory PlayerControlButton.small({required IconData iconData, required VoidCallback onTap, bool? disabled}) {
    return PlayerControlButton._(iconData, PlayerControlButtonType.small, false, onTap, disabled ?? false);
  }

  final IconData icon;
  final PlayerControlButtonType type;
  final bool background;
  final VoidCallback onTap;
  final bool disabled;

  static const double tapArea = 70;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? onTap : null,
      child: SizedBox(
        height: tapArea,
        width: tapArea,
        child: Opacity(
          opacity: disabled ? .3 : 1,
          child: ClipOval(
            child: Container(
              alignment: Alignment.center,
              color: background ? SRColors.primaryForeground : Colors.transparent,
              height: type.backgroundSize,
              width: type.backgroundSize,
              child: Icon(
                icon,
                color: background ? SRColors.primaryBackground : SRColors.primaryForeground,
                size: type.iconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActionItemsSection extends StatelessWidget {
  const _ActionItemsSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SRConstants.spacing5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          _ActionItem(
            iconData: CupertinoIcons.timer,
            title: 'x1.0',
          ),
          _ActionItem(
            iconData: CupertinoIcons.share,
            title: 'Dela',
          ),
          _ActionItem(
            iconData: CupertinoIcons.moon_fill,
            title: 'Timer',
          ),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({
    required this.iconData,
    required this.title,
  });

  final IconData iconData;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconData,
          color: SRColors.primaryForeground,
          size: 18,
        ),
        const SizedBox(height: SRConstants.spacing1),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: SRColors.primaryForeground,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ShowInformation extends StatelessWidget {
  const _ShowInformation({
    required this.playerContent,
  });

  final OnAirPlayerContent playerContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SRConstants.spacing1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${playerContent.currentScheduleItem.title} ${playerContent.currentScheduleItem.subtitle ?? ''}',
                  style: const TextStyle(
                    color: SRColors.primaryForeground,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: SRConstants.spacing3),
                Text(
                  playerContent.currentScheduleItem.title,
                  style: const TextStyle(
                    color: SRColors.primaryForeground,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 31,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: SRConstants.spacing4),
            decoration: BoxDecoration(
              border: Border.all(color: SRColors.primaryForeground),
              borderRadius: BorderRadius.circular(
                31 / 2,
              ),
            ),
            child: const Text(
              '+ Följ',
              style: TextStyle(
                fontSize: 13,
                color: SRColors.primaryForeground,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({
    required this.playerContent,
  });

  final OnAirPlayerContent playerContent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SRConstants.spacing2),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(SRConstants.spacing2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.1),
              image: playerContent.imageUrl != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(playerContent.imageUrl!),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _OnAirTopRowControls extends StatelessWidget {
  const _OnAirTopRowControls({
    required this.playerContent,
  });

  final OnAirPlayerContent playerContent;
  static const double rowHeight = 24;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SRConstants.spacing5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipOval(
            child: Container(
              width: rowHeight,
              height: rowHeight,
              color: SRColors.primaryForeground,
              child: const Center(
                child: Icon(
                  CupertinoIcons.chevron_down,
                  size: rowHeight * .7,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(SRConstants.spacing1),
            child: Container(
              width: rowHeight,
              height: rowHeight,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.1),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(playerContent.channel.imageUrl),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: rowHeight,
            width: rowHeight,
            child: Icon(
              Icons.airplay,
              color: SRColors.primaryForeground,
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorLargePlayer extends StatelessWidget {
  const ErrorLargePlayer({
    required this.errorMessage,
    super.key,
  });

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
