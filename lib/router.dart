import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sr_clone_flutter/presentation/components/bottom_navigation_bar.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/presentation/view_models/start_view_model.dart';
import 'package:sr_clone_flutter/presentation/views/live_view.dart';
import 'package:sr_clone_flutter/presentation/views/news_view.dart';
import 'package:sr_clone_flutter/presentation/views/podcasts_view.dart';
import 'package:sr_clone_flutter/presentation/views/profile_view.dart';
import 'package:sr_clone_flutter/presentation/views/start_view.dart';

class RouterData {
  const RouterData(this.initialPlayerContent);

  final PlayerContent initialPlayerContent;
}

class Router {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter config(RouterData routerData) => GoRouter(
        initialLocation: '/start',
        navigatorKey: _rootNavigatorKey,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => ContentViewWithBottomNavigation(
              initialPlayerContent: routerData.initialPlayerContent,
              child: child,
            ),
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
              GoRoute(
                path: '/news',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: NewsView(),
                ),
              ),
              GoRoute(
                path: '/podcasts',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PodcastsView(),
                ),
              ),
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfileView(),
                ),
              ),
            ],
          ),
        ],
      );
}
