import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/colors.dart';
import 'package:ui_components/constants.dart';

/// A BottomNavigationBar in SR styling
class SRBottomNavigationBar extends StatelessWidget {
  ///
  const SRBottomNavigationBar({
    required this.items,
    required this.currentIndex,
    this.offset,
    this.onTap,
    super.key,
  });

  /// The items in the bottom navigation bar
  ///
  final List<BottomNavigationBarItem> items;

  /// Lets the bottom navigation bar know which
  /// item that is the current selected route
  ///
  final int currentIndex;

  /// The [offset] parameter can be used with, for example,
  /// an animation controller to hide and show the
  /// bottom navigation bar.
  ///
  final Offset? offset;

  /// A callback that runs when a item is tapped.
  /// Passes the current tapped items index.
  ///
  final void Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SRConstants.bottomNavigationBarHeight,
      child: Transform.translate(
        offset: offset ?? Offset.zero,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: SRColors.primaryForeground.withOpacity(1),
              ),
            ),
          ),
          // TODO: Handle colors etc. in ThemeData to remove splash color
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: SRColors.primaryBackground,
            selectedItemColor: SRColors.primaryForeground,
            selectedFontSize: 11,
            unselectedFontSize: 11,
            unselectedItemColor: SRColors.primaryForeground.withOpacity(.5),
            currentIndex: currentIndex,
            items: items,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
