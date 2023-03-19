import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:sr_clone_flutter/domain/extensions/double.dart';
import 'package:sr_clone_flutter/presentation/components/player/large_player.dart';
import 'package:sr_clone_flutter/presentation/components/player/mini_player.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_view_model.dart';
import 'package:sr_clone_flutter/presentation/providers/player_expanded_progression_provider.dart';

class Player extends StatefulWidget {
  const Player({required this.viewModel, super.key});

  final PlayerViewModel viewModel;

  static const double miniPlayerHeight = 50;

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  late SnappingSheetController snappingSheetController;

  PlayerContent? _playerContent;
  bool showPlayer = false;

  @override
  void initState() {
    super.initState();

    snappingSheetController = SnappingSheetController();
  }

  @override
  void didUpdateWidget(covariant Player oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.viewModel.addListener(() {
      setState(() {
        _playerContent = widget.viewModel.playerContent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, oldWidget) {
        return Container(
          constraints: const BoxConstraints.expand(),
          child: SnappingSheet(
            lockOverflowDrag: true,
            controller: snappingSheetController,
            onSheetMoved: (sheetPosition) => ref.read(playerProvider).update(sheetPosition.relativeToSheetHeight.withLengthOf(3)),
            snappingPositions: const [
              SnappingPosition.factor(
                positionFactor: 0,
                snappingCurve: Curves.easeOutExpo,
                snappingDuration: Duration(milliseconds: 500),
                grabbingContentOffset: GrabbingContentOffset.top,
              ),
              SnappingPosition.factor(
                grabbingContentOffset: GrabbingContentOffset.bottom,
                snappingCurve: Curves.easeOutExpo,
                snappingDuration: Duration(milliseconds: 500),
                positionFactor: 1,
              ),
            ],
            grabbingHeight: Player.miniPlayerHeight,
            grabbing: Builder(
              builder: (context) {
                final playerContent = _playerContent;
                if (playerContent == null) return const ErrorMiniPlayer(errorMessage: '');
                if (playerContent is OnAirPlayerContent) {
                  return OnAirMiniPlayer(
                    content: playerContent,
                    playerDataStream: widget.viewModel.mediaPlayerDataStream,
                    onButtonTap: (isPlaying) => isPlaying ? widget.viewModel.pauseAudio() : widget.viewModel.playAudio(),
                  );
                }
                return const ErrorMiniPlayer(errorMessage: 'Incorrect Player Data');
              },
            ),
            sheetBelow: SnappingSheetContent(
              draggable: true,
              child: Builder(
                builder: (context) {
                  final playerContent = _playerContent;
                  if (playerContent == null) return const ErrorLargePlayer(errorMessage: '');
                  if (playerContent is OnAirPlayerContent) {
                    return OnAirLargePlayer(
                      playerContent: playerContent,
                      playerDataStream: widget.viewModel.mediaPlayerDataStream,
                      onPlayPauseButtonTap: (isPlaying) => isPlaying ? widget.viewModel.pauseAudio() : widget.viewModel.playAudio(),
                      onSkipForwardButtonTap: () => widget.viewModel.skipForward(15),
                      onSkipBackwardButtonTap: () => widget.viewModel.skipBackward(15),
                    );
                  }
                  return const ErrorLargePlayer(errorMessage: 'Incorrect Player Data');
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
