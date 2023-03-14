import 'package:ui_components/ui_components.dart';
import 'package:widgetbook/widgetbook.dart';

class PlaylistCardComponent extends WidgetbookComponent {
  PlaylistCardComponent()
      : super(
          name: 'Playlist Card',
          useCases: [
            WidgetbookUseCase(
              name: 'Default',
              builder: (context) {
                return PlaylistCard(
                  title: context.knobs.text(
                    label: 'Title',
                    description: 'The name of the playlist',
                    initialValue: 'Nyheter P4 Stockholm',
                  ),
                  description: context.knobs.text(
                    label: 'Description',
                    description: 'Describes the playlist.',
                    initialValue: 'Lokala nyheter i Stockholm',
                  ),
                  imageUrl: context.knobs.text(
                    label: 'Image',
                    description: 'Image of the playlist. Usually a program image',
                    initialValue: 'https://static-cdn.sr.se/images/103/93751e41-25be-443e-aa50-3d65b67ae5ac.jpg?preset=api-default-square',
                  ),
                  numberOfItemsInPlaylist: context.knobs.number(
                    label: 'Number of playable items',
                    description: 'Number of playable items in the playlist',
                    initialValue: 10,
                  ) as int,
                );
              },
            ),
          ],
        );
}
