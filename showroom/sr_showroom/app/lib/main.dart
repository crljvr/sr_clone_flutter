import 'package:flutter/material.dart';
import 'package:sr_showroom/sr_showroom.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(const HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatelessWidget {
  const HotreloadWidgetbook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      devices: [
        Apple.iPhone11,
        Samsung.s21ultra,
      ],
      categories: [
        WidgetbookCategory(
          name: 'Buttons',
          widgets: [
            WidgetbookComponent(
              name: 'MyButton',
              useCases: [
                WidgetbookUseCase(
                  name: 'default',
                  builder: (context) => MyButton(
                    title: context.knobs.text(label: 'Button Title', initialValue: 'SR Button'),
                  ),
                ),
              ],
            ),
          ],
        )
      ],
      themes: [
        WidgetbookTheme(
          name: 'Light',
          data: ThemeData.light(),
        ),
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
      appInfo: AppInfo(name: 'Example'),
    );
  }
}
