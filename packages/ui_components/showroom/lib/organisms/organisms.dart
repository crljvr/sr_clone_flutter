import 'package:showroom/organisms/sr_bottom_navigation_bar.dart';
import 'package:showroom/organisms/sr_channels_row.dart';
import 'package:widgetbook/widgetbook.dart';

class Organisms extends WidgetbookCategory {
  Organisms()
      : super(
          name: 'Organisms',
          widgets: [
            SRChannelsRowComponent(),
            SRBottomNavigationBarComponent(),
          ],
        );
}
