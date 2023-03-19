import 'package:flutter/widgets.dart';

///
class SRChannelsRow extends StatelessWidget {
  ///
  const SRChannelsRow({
    required this.numberOfItems,
    required this.channelBuilder,
    this.itemSpacing,
    super.key,
  });

  ///
  final int numberOfItems;

  ///
  final Widget Function(BuildContext, int, Size) channelBuilder;

  ///
  final double? itemSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final numberOfSpaces = numberOfItems == 0 ? 0 : numberOfItems - 1;
        final totalSpacing = numberOfSpaces * (itemSpacing ?? 0.0);
        final availableWidthForChannels = availableWidth - totalSpacing;
        final cardWidth = availableWidthForChannels / numberOfItems;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (int x = 1; x <= numberOfItems; x++) ...[
              SizedBox(
                height: cardWidth,
                width: cardWidth,
                child: channelBuilder(context, x - 1, Size(cardWidth, cardWidth)),
              ),
            ],
          ],
        );
      },
    );
  }
}
