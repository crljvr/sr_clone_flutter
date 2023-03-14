import 'package:flutter/cupertino.dart';
import 'package:ui_components/colors.dart';
import 'package:ui_components/constants.dart';

class PlaylistCard extends StatelessWidget {
  const PlaylistCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.numberOfItemsInPlaylist,
    super.key,
  });

  final String imageUrl;
  final String title;
  final String description;
  final int numberOfItemsInPlaylist;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(SRConstants.spacing2),
      child: AspectRatio(
        aspectRatio: 9 / 7,
        child: Container(
          width: MediaQuery.of(context).size.width * .8,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(imageUrl),
            ),
          ),
          child: Stack(
            children: [
              Container(
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
              ),
              Positioned(
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
              ),
              Positioned(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
