import 'package:flutter/cupertino.dart';

///
class SRBottomNavigationBarItem extends BottomNavigationBarItem {
  ///
  const SRBottomNavigationBarItem._({
    required this.initialLocation,
    required super.icon,
    required super.activeIcon,
    super.label,
  });

  ///
  factory SRBottomNavigationBarItem.start() {
    return const SRBottomNavigationBarItem._(
      initialLocation: '/start',
      icon: Icon(CupertinoIcons.house_alt),
      activeIcon: Icon(CupertinoIcons.house_alt_fill),
      label: 'Start',
    );
  }

  ///
  factory SRBottomNavigationBarItem.live() {
    return const SRBottomNavigationBarItem._(
      initialLocation: '/live',
      icon: Icon(CupertinoIcons.dot_radiowaves_left_right),
      activeIcon: Icon(CupertinoIcons.dot_radiowaves_left_right),
      label: 'Direkt',
    );
  }

  ///
  factory SRBottomNavigationBarItem.news() {
    return const SRBottomNavigationBarItem._(
      initialLocation: '/news',
      icon: Icon(CupertinoIcons.news),
      activeIcon: Icon(CupertinoIcons.news_solid),
      label: 'Nyheter',
    );
  }

  ///
  factory SRBottomNavigationBarItem.podcasts() {
    return const SRBottomNavigationBarItem._(
      initialLocation: '/podcasts',
      icon: Icon(CupertinoIcons.search),
      activeIcon: Icon(CupertinoIcons.search),
      label: 'Sök podd',
    );
  }

  ///
  factory SRBottomNavigationBarItem.profile() {
    return const SRBottomNavigationBarItem._(
      initialLocation: '/profile',
      icon: Icon(CupertinoIcons.person),
      activeIcon: Icon(CupertinoIcons.person_fill),
      label: 'Min sida',
    );
  }

  /// The initial location/path
  final String initialLocation;
}
