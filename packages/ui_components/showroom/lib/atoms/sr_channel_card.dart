import 'package:flutter/widgets.dart';
import 'package:ui_components/constants.dart';
import 'package:ui_components/ui_components.dart';
import 'package:widgetbook/widgetbook.dart';

class SRChannelCardComponent extends WidgetbookComponent {
  SRChannelCardComponent()
      : super(
          name: 'Channel Card',
          useCases: [
            WidgetbookUseCase(
              name: 'Create',
              builder: (context) {
                return _presenter(SRChannelCard.create(
                  channelImageUrl: 'https://static-cdn.sr.se/images/132/2186745_512_512.jpg?preset=api-default-square',
                ));
              },
            ),
            WidgetbookUseCase(
              name: 'Loading',
              builder: (context) => _presenter(SRChannelCard.loading()),
            ),
          ],
        );

  static Widget _presenter(Widget child) => Center(
        child: Padding(
          padding: const EdgeInsets.all(SRConstants.spacing3),
          child: child,
        ),
      );
}
