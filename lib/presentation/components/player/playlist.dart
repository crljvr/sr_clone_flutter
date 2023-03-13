import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'package:sr_clone_flutter/domain/entities/schedule_item.dart';
import 'package:sr_clone_flutter/domain/extensions/date_time.dart';
import 'package:sr_clone_flutter/presentation/colors.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/presentation/constants.dart';

class Playlist extends StatefulWidget {
  const Playlist({
    required this.playerContent,
    super.key,
  });

  final PlayerContent playerContent;

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  @override
  Widget build(BuildContext context) {
    final playerContent = widget.playerContent;
    if (playerContent is OnAirPlayerContent) {
      return SnappingSheet(
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
        grabbingHeight: 80,
        grabbing: Container(
          padding: const EdgeInsets.all(SRConstants.spacing4),
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SRConstants.spacing3),
              topRight: Radius.circular(SRConstants.spacing3),
            ),
            color: SRColors.secodaryForeground,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${playerContent.channel.name} idag',
                style: const TextStyle(
                  color: SRColors.primaryForeground,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: SRConstants.spacing4),
              Container(
                color: SRColors.primaryForeground.withOpacity(.5),
                height: 1,
              )
            ],
          ),
        ),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          child: ColoredBox(
            color: SRColors.secodaryForeground,
            child: MediaQuery.removePadding(
              context: context,
              child: ListView.separated(
                itemCount: playerContent.scheduleItems.length,
                separatorBuilder: (context, index) {
                  return Container(
                    color: SRColors.primaryForeground.withOpacity(.5),
                    margin: const EdgeInsets.symmetric(horizontal: SRConstants.spacing4),
                    height: 1,
                  );
                },
                itemBuilder: (context, index) => PlaylistItem(
                  highlighted: playerContent.currentScheduleItem == playerContent.scheduleItems[index],
                  item: playerContent.scheduleItems[index],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }
}

class PlaylistItem extends StatelessWidget {
  const PlaylistItem({required this.item, required this.highlighted, super.key});

  final ScheduleItem item;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: highlighted ? SRColors.secodaryBackground : null,
      child: Padding(
        padding: const EdgeInsets.all(SRConstants.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  item.startTime.format(DateTimeFormat.jm),
                  style: const TextStyle(color: SRColors.primaryForeground, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: SRConstants.spacing3),
            SizedBox(
              height: SRConstants.spacing4 * 2,
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 5 / 3,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SRConstants.spacing1),
                        image: item.imageUrl != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(item.imageUrl!),
                              )
                            : null,
                        color: Colors.black.withOpacity(.1),
                      ),
                    ),
                  ),
                  const SizedBox(width: SRConstants.spacing4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(color: SRColors.primaryForeground, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '${item.duration} min',
                        style: TextStyle(color: SRColors.primaryForeground.withOpacity(.5), fontSize: 12, fontWeight: FontWeight.w300),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
