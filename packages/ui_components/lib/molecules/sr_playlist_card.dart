import 'package:flutter/cupertino.dart';
import 'package:ui_components/colors.dart';
import 'package:ui_components/constants.dart';

/// A PlaylistCard is often used in a carousel.
/// Normaly loads and shows the player with the content from a Playlist.
class SRPlaylistCard extends StatelessWidget {
  /// Internal constructor not to be used from the outside.
  const SRPlaylistCard._(
    this._title,
    this._description,
    this._imageUrl,
    this._numberOfItemsInPlaylist,
    this._displayLoading,
  );

  /// Use this when all data is loaded and the Card is ready to be created.
  factory SRPlaylistCard.create({
    required String title,
    required String description,
    required String imageUrl,
    required int numberOfItemsInPlaylist,
  }) =>
      SRPlaylistCard._(
        title,
        description,
        imageUrl,
        numberOfItemsInPlaylist,
        false,
      );

  /// When data is not ready, use the Card in its loading state.
  factory SRPlaylistCard.loading() => const SRPlaylistCard._('', '', '', 0, true);

  final String _title;
  final String _description;
  final String _imageUrl;
  final int _numberOfItemsInPlaylist;
  final bool _displayLoading;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SRConstants.spacing2),
      child: AspectRatio(
        aspectRatio: 9 / 7,
        child: _displayLoading
            ? const _Loading()
            : _CardContent(imageUrl: _imageUrl, title: _title, numberOfItemsInPlaylist: _numberOfItemsInPlaylist, description: _description),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return ColoredBox(
          color: SRColors.primaryLoading,
          child: Stack(
            children: [
              Container(
                height: height / 3,
                color: SRColors.primaryBackground.withOpacity(.6),
                child: Padding(
                  padding: EdgeInsets.all(height / 12),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Container(
                          color: SRColors.primaryLoading,
                          height: height / 6,
                          width: height / 6,
                        ),
                      ),
                      SizedBox(width: height / 12),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _LoadingText.primary(height: height / 14, width: width / 2),
                          _LoadingText.primary(height: height / 20, width: width / 3),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(height / 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _LoadingText.secondary(
                        height: height / 20,
                        width: width / 3,
                      ),
                      SizedBox(height: height / 20),
                      _LoadingText.secondary(
                        height: height / 20,
                        width: width / 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoadingText extends StatelessWidget {
  const _LoadingText._(
    this.height,
    this.width,
    this.color,
  );

  factory _LoadingText.primary({
    required double height,
    required double width,
  }) =>
      _LoadingText._(height, width, SRColors.primaryLoading);

  factory _LoadingText.secondary({
    required double height,
    required double width,
  }) =>
      _LoadingText._(height, width, SRColors.secondaryLoading);

  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / 3),
        color: color,
      ),
      height: height,
      width: width,
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent({
    required String imageUrl,
    required String title,
    required int numberOfItemsInPlaylist,
    required String description,
  })  : _imageUrl = imageUrl,
        _title = title,
        _numberOfItemsInPlaylist = numberOfItemsInPlaylist,
        _description = description;

  final String _imageUrl;
  final String _title;
  final int _numberOfItemsInPlaylist;
  final String _description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .8,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(_imageUrl),
        ),
      ),
      child: Stack(
        children: [
          const _TintLayer(),
          _TopInformation(title: _title, numberOfItemsInPlaylist: _numberOfItemsInPlaylist),
          _BottomInformation(description: _description)
        ],
      ),
    );
  }
}

class _BottomInformation extends StatelessWidget {
  const _BottomInformation({required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Padding(
        padding: const EdgeInsets.all(SRConstants.spacing4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokala nyheter'.toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: SRColors.primaryHighlight,
              ),
            ),
            const SizedBox(height: SRConstants.spacing3),
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: SRColors.primaryForeground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopInformation extends StatelessWidget {
  const _TopInformation({
    required this.title,
    required this.numberOfItemsInPlaylist,
  });

  final String title;
  final int numberOfItemsInPlaylist;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(SRConstants.spacing4),
        color: SRColors.primaryForeground,
        child: Row(
          children: [
            ClipOval(
              child: Container(
                alignment: Alignment.center,
                height: 42,
                width: 42,
                color: SRColors.primaryBackground,
                child: const Icon(
                  CupertinoIcons.play_fill,
                  color: SRColors.primaryForeground,
                ),
              ),
            ),
            const SizedBox(width: SRConstants.spacing4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: SRColors.primaryBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: SRConstants.spacing1),
                Text(
                  '$numberOfItemsInPlaylist nyheter',
                  style: const TextStyle(
                    color: SRColors.primaryBackground,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TintLayer extends StatelessWidget {
  const _TintLayer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            SRColors.primaryBackground.withOpacity(.1),
            SRColors.primaryBackground.withOpacity(.4),
            SRColors.primaryBackground,
          ],
        ),
      ),
    );
  }
}
