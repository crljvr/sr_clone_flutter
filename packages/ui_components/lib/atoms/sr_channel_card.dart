import 'package:flutter/widgets.dart';
import 'package:ui_components/colors.dart';

/// Creates a channel card with the channel image as its background
///
class SRChannelCard extends StatelessWidget {
  const SRChannelCard._({
    required this.channelImageUrl,
    this.fallbackColor,
    this.loadingColor,
  });

  /// When channel data is ready, use this constructor to create the ChannelCard
  /// The [channelImageUrl] will be the background image for the card.
  /// If the network request getting the image fails, the [fallbackColor] will
  /// be the background color of the Card.
  ///
  factory SRChannelCard.create({
    required String channelImageUrl,
    Color? fallbackColor,
  }) =>
      SRChannelCard._(
        channelImageUrl: channelImageUrl,
        fallbackColor: fallbackColor,
      );

  /// When channel data is not ready use this constructor.
  /// The [loadingColor] will be the background color for the card.
  /// If no [loadingColor] is passed, the fallback color will
  /// be the primary loading color.
  ///
  factory SRChannelCard.loading({
    Color? loadingColor,
  }) =>
      SRChannelCard._(
        channelImageUrl: '',
        loadingColor: loadingColor ?? SRColors.primaryLoading,
      );

  /// The path to the image for the card background.
  final String channelImageUrl;

  /// The color of the card if the network request fails
  final Color? fallbackColor;

  /// The color of the card when data is not loaded.
  final Color? loadingColor;

  @override
  Widget build(BuildContext context) {
    return loadingColor != null
        ? _Card(
            color: loadingColor,
          )
        : _Card(
            color: fallbackColor,
            image: DecorationImage(
              onError: (exception, stackTrace) {},
              image: NetworkImage(channelImageUrl),
            ),
          );
  }
}

class _Card extends StatelessWidget {
  const _Card({
    this.image,
    this.color,
  });

  final DecorationImage? image;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: color,
        image: image,
      ),
    );
  }
}
