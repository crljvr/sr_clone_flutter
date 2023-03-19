import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:widgetbook/widgetbook.dart';

class SRBottomNavigationBarComponent extends WidgetbookComponent {
  SRBottomNavigationBarComponent()
      : super(
          name: 'Bottom navigation bar',
          useCases: [
            WidgetbookUseCase(
              name: 'Default',
              builder: (context) {
                return Center(
                  child: SRBottomNavigationBar(
                    items: [
                      SRBottomNavigationBarItem.start(),
                      SRBottomNavigationBarItem.live(),
                      SRBottomNavigationBarItem.news(),
                      SRBottomNavigationBarItem.podcasts(),
                      SRBottomNavigationBarItem.profile(),
                    ],
                    currentIndex: context.knobs.options(
                      label: 'Active route',
                      options: const [
                        Option(label: 'Start', value: 0),
                        Option(label: 'Live', value: 1),
                        Option(label: 'News', value: 2),
                        Option(label: 'Podcasts', value: 3),
                        Option(label: 'Profile', value: 4),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        );
}
