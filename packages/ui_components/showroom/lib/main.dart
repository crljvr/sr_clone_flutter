import 'package:flutter/material.dart';
import 'package:showroom/atoms/atoms.dart';
import 'package:showroom/molecules/molecules.dart';
import 'package:showroom/organisms/organisms.dart';
import 'package:ui_components/colors.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runApp(
    Widgetbook.material(
      categories: [
        Atoms(),
        Molecules(),
        Organisms(),
      ],
      themes: [
        WidgetbookTheme(
          name: 'Dark',
          data: ThemeData.dark(),
        ),
      ],
      appInfo: AppInfo(name: 'SR UI Components'),
      scaffoldBuilder: (context, frame, child) {
        return Scaffold(
          backgroundColor: SRColors.primaryBackground,
          body: child,
        );
      },
    ),
  );
}
