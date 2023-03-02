import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sr_clone_flutter/presentation/components/player.dart';
import 'package:sr_clone_flutter/presentation/view_models/start_view_model.dart';
import 'package:sr_clone_flutter/presentation/views/live_view.dart';
import 'package:sr_clone_flutter/presentation/views/start_view.dart';

class Router {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter config = GoRouter(
    initialLocation: '/start',
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/start',
            pageBuilder: (context, state) => NoTransitionPage(
              child: StartView(viewModel: StartViewModel()),
            ),
          ),
          GoRoute(
            path: '/live',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: LiveView(),
            ),
          ),
        ],
      ),
    ],
  );
}

const tabs = [
  ScaffoldWithNavBarTabItem(
    initialLocation: '/start',
    icon: Icon(Icons.home),
    label: 'Section A',
  ),
  ScaffoldWithNavBarTabItem(
    initialLocation: '/live',
    icon: Icon(Icons.settings),
    label: 'Section B',
  ),
];

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() => _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // getter that computes the current index from the current location,
  // using the helper method below
  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index = tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          Player(viewModel: PlayerViewModel()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: tabs,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  const ScaffoldWithNavBarTabItem({
    required this.initialLocation,
    required super.icon,
    super.label,
  });

  /// The initial location/path
  final String initialLocation;
}
