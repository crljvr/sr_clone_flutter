import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sr_clone_flutter/presentation/colors.dart';
import 'package:sr_clone_flutter/presentation/components/player/player.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_view_model.dart';
import 'package:sr_clone_flutter/presentation/providers/player_expanded_progression_provider.dart';
import 'package:ui_components/ui_components.dart';

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
    final index = items.indexWhere((t) => location.startsWith(t.initialLocation));
    return index < 0 ? 0 : index;
  }

  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      context.go(items[tabIndex].initialLocation);
    }
  }

  final items = [
    SRBottomNavigationBarItem.start(),
    SRBottomNavigationBarItem.live(),
    SRBottomNavigationBarItem.news(),
    SRBottomNavigationBarItem.podcasts(),
    SRBottomNavigationBarItem.profile(),
  ];

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
              bottomNavigationBar: SRBottomNavigationBar(
                offset: Offset(0, progression * 86),
                items: items,
                currentIndex: _currentIndex,
                onTap: (index) => _onItemTapped(context, index),
              ),
            );
          },
        );
      },
    );
  }
}
