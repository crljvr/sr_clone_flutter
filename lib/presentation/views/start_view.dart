import 'package:flutter/material.dart';
import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/entities/playlist.dart';
import 'package:sr_clone_flutter/domain/entities/podcast.dart';
import 'package:sr_clone_flutter/presentation/colors.dart';
import 'package:sr_clone_flutter/presentation/constants.dart';
import 'package:sr_clone_flutter/presentation/view_models/start_view_model.dart';

class StartView extends StatefulWidget {
  const StartView({required this.viewModel, super.key});

  final StartViewModel viewModel;

  @override
  State<StartView> createState() => _StartViewState();
}

class _StartViewState extends State<StartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SRColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SRConstants.spacing3),
          child: CustomScrollView(
            slivers: [
              const _StartViewHeader(),
              _ChannelsSection(
                numberOfItems: widget.viewModel.channelIds.length,
                channelBuilder: (context, index, size) {
                  return _ChannelCard(
                    size: size,
                    channelId: widget.viewModel.channelIds[index],
                    getChannelFuture: widget.viewModel.getChannel,
                    onTap: widget.viewModel.playChannelAudio,
                  );
                },
              ),
              _Playlists(
                getPlaylistFuture: widget.viewModel.getPlaylist,
              ),
              _FeaturedPodcast(
                getPodcastFuture: widget.viewModel.getPodcast,
                podcastId: widget.viewModel.featuredEpisodeId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StartViewHeader extends StatelessWidget {
  const _StartViewHeader();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.only(bottom: SRConstants.spacing3, top: SRConstants.spacing4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: .5,
              color: SRColors.primaryForeground.withOpacity(.1),
            ),
          ),
        ),
        child: Image.asset(
          'assets/images/logo.jpeg',
          height: 30,
        ),
      ),
    );
  }
}

class _ChannelsSection extends StatelessWidget {
  const _ChannelsSection({
    required this.numberOfItems,
    required this.channelBuilder,
    this.spacingBetweenItems = SRConstants.spacing1,
  });

  final int numberOfItems;
  final Widget Function(BuildContext, int, Size) channelBuilder;
  final double spacingBetweenItems;

  // final Future<Channel> Function(String) getChannelFuture;
  // final Future<void> Function(Channel) playChannelAudio;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final numberOfSpaces = numberOfItems - 1;

          final availableWidthForChannels = availableWidth - (numberOfSpaces * SRConstants.spacing1);
          final cardWidth = availableWidthForChannels / numberOfItems;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: SRConstants.spacing3),
            child: Column(
              children: [
                Row(
                  children: const [
                    Text(
                      'God kväll',
                      style: TextStyle(color: SRColors.primaryForeground, fontSize: 21),
                    )
                  ],
                ),
                const SizedBox(height: SRConstants.spacing3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int x = 1; x <= numberOfItems; x++) ...[
                      channelBuilder(context, x - 1, Size(cardWidth, cardWidth)),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ChannelCard extends StatefulWidget {
  const _ChannelCard({
    required this.size,
    required this.channelId,
    required this.getChannelFuture,
    required this.onTap,
  });

  final Size size;
  final String channelId;
  final Future<Channel> Function(String) getChannelFuture;
  final void Function(Channel) onTap;

  @override
  State<_ChannelCard> createState() => _ChannelCardState();
}

class _ChannelCardState extends State<_ChannelCard> {
  late Future<Channel> _getChannelFuture;

  @override
  void initState() {
    super.initState();
    _getChannelFuture = widget.getChannelFuture(widget.channelId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height,
      width: widget.size.width,
      child: FutureBuilder(
        future: _getChannelFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            final channel = snapshot.data!;
            return GestureDetector(
              onTap: () => widget.onTap(channel),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                    image: NetworkImage(channel.imageUrl),
                  ),
                ),
              ),
            );
          }
          return Container(color: Colors.white.withOpacity(.1));
        },
      ),
    );
  }
}

class _FeaturedPodcast extends StatefulWidget {
  const _FeaturedPodcast({
    required this.getPodcastFuture,
    required this.podcastId,
  });

  final Future<Podcast> Function(String) getPodcastFuture;
  final String podcastId;

  @override
  State<_FeaturedPodcast> createState() => _FeaturedPodcastState();
}

class _FeaturedPodcastState extends State<_FeaturedPodcast> {
  late Future<Podcast> _podcastFuture;

  @override
  void initState() {
    super.initState();
    _podcastFuture = widget.getPodcastFuture(widget.podcastId);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
        child: AspectRatio(
          aspectRatio: 5 / 4,
          child: FutureBuilder(
            future: _podcastFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                final episode = snapshot.data!;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(episode.imageUrl),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.bottomLeft,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 0.4, 0.6, 1.0],
                            colors: [Colors.transparent, Colors.transparent, SRColors.primaryBackground, SRColors.primaryBackground],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PODD: ${episode.showName}'.toUpperCase(),
                              maxLines: 2,
                              style: const TextStyle(color: SRColors.primaryForeground, fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              episode.name,
                              maxLines: 2,
                              style: const TextStyle(color: SRColors.primaryForeground, fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              episode.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: SRColors.primaryForeground, fontSize: 14, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container(color: Colors.white.withOpacity(.1));
            },
          ),
        ),
      ),
    );
  }
}

class _Playlists extends StatelessWidget {
  const _Playlists({
    required this.getPlaylistFuture,
  });

  final Future<Playlist> Function(String) getPlaylistFuture;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _PlaylistCard(
        programId: '103',
        getPlaylistFuture: getPlaylistFuture,
      ),
    );
  }
}

class _PlaylistCard extends StatefulWidget {
  const _PlaylistCard({
    required this.programId,
    required this.getPlaylistFuture,
  });

  final String programId;
  final Future<Playlist> Function(String) getPlaylistFuture;

  @override
  State<_PlaylistCard> createState() => __PlaylistCardState();
}

class __PlaylistCardState extends State<_PlaylistCard> {
  late Future<Playlist> _getPlaylistFuture;

  @override
  void initState() {
    super.initState();

    _getPlaylistFuture = widget.getPlaylistFuture(widget.programId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getPlaylistFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return Container(
            color: Colors.pink,
            height: 100,
            width: 100,
          );
        }
        return const SizedBox();
      },
    );
  }
}
