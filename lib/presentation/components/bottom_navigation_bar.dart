import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sr_clone_flutter/presentation/colors.dart';
import 'package:sr_clone_flutter/presentation/components/player/player.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/presentation/constants.dart';
import 'package:sr_clone_flutter/presentation/providers/player_expanded_progression_provider.dart';

const tabs = [
  TabItem(
    initialLocation: '/start',
    icon: Icon(CupertinoIcons.house_alt),
    activeIcon: Icon(CupertinoIcons.house_alt_fill),
    label: 'Start',
  ),
  TabItem(
    initialLocation: '/live',
    icon: Icon(CupertinoIcons.dot_radiowaves_left_right),
    activeIcon: Icon(CupertinoIcons.dot_radiowaves_left_right),
    label: 'Direkt',
  ),
  TabItem(
    initialLocation: '/news',
    icon: Icon(CupertinoIcons.news),
    activeIcon: Icon(CupertinoIcons.news_solid),
    label: 'Nyheter',
  ),
  TabItem(
    initialLocation: '/podcasts',
    icon: Icon(CupertinoIcons.search),
    activeIcon: Icon(CupertinoIcons.search),
    label: 'Sök podd',
  ),
  TabItem(
    initialLocation: '/profile',
    icon: Icon(CupertinoIcons.person),
    activeIcon: Icon(CupertinoIcons.person_fill),
    label: 'Min sida',
  ),
];

class ContentViewWithBottomNavigation extends StatefulWidget {
  const ContentViewWithBottomNavigation({
    required this.initialPlayerContent,
    required this.child,
    super.key,
  });

  final PlayerContent initialPlayerContent;
  final Widget child;

  @override
  State<ContentViewWithBottomNavigation> createState() => _ContentViewWithBottomNavigationState();
}

class _ContentViewWithBottomNavigationState extends State<ContentViewWithBottomNavigation> {
  // TODO: Inject logic to remove GO_ROUTER depencency
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, oldWidget) {
        final playerRef = ref.watch(playerExpandedProgressionProvider);
        return playerRef.maybeWhen(
            orElse: SizedBox.new,
            data: (progression) {
              return Scaffold(
                backgroundColor: SRColors.primaryBackground,
                body: Stack(
                  children: [
                    widget.child,
                    Player(viewModel: PlayerViewModel(widget.initialPlayerContent)),
                  ],
                ),
                // Has to be Container to take affect, DecoratedBox wont apply.
                // ignore: use_decorated_box
                bottomNavigationBar: SizedBox(
                  height: SRConstants.bottomNavigationBarHeight,
                  child: Transform.translate(
                    offset: Offset(0, progression * 86),
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
                        currentIndex: _currentIndex,
                        items: tabs,
                        onTap: (index) => _onItemTapped(context, index),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}

class TabItem extends BottomNavigationBarItem {
  const TabItem({
    required this.initialLocation,
    required super.icon,
    required super.activeIcon,
    super.label,
  });

  /// The initial location/path
  final String initialLocation;
}
