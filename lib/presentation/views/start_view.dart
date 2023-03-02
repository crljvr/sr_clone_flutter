import 'package:flutter/material.dart';
import 'package:sr_clone_flutter/domain/entities/channel.dart';
import 'package:sr_clone_flutter/domain/entities/episode.dart';
import 'package:sr_clone_flutter/presentation/colors.dart';
import 'package:sr_clone_flutter/presentation/constants.dart';
import 'package:sr_clone_flutter/presentation/view_models/start_view_model.dart';

class StartView extends StatelessWidget {
  const StartView({required this.viewModel, super.key});

  final StartViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SRColors.primaryBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SRConstants.small),
          child: CustomScrollView(
            slivers: [
              const _StartViewHeader(),
              _ChannelsSection(
                getChannelFuture: viewModel.getChannel,
                playChannelAudio: viewModel.playChannelAudio,
              ),
              _FeaturedEpisode(
                getEpisodeFuture: viewModel.getEpisode,
                episodeId: viewModel.featuredEpisodeId,
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
        padding: const EdgeInsets.only(bottom: SRConstants.small, top: SRConstants.small * 2),
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
    required this.getChannelFuture,
    required this.playChannelAudio,
  });

  final Future<Channel> Function(String) getChannelFuture;
  final Future<void> Function(Channel) playChannelAudio;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SRConstants.small),
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
            const SizedBox(height: SRConstants.small),
            SizedBox(
              height: 76,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ChannelCard(
                    channelId: '132',
                    getChannelFuture: getChannelFuture,
                    onTap: playChannelAudio,
                  ),
                  _ChannelCard(
                    channelId: '163',
                    getChannelFuture: getChannelFuture,
                    onTap: playChannelAudio,
                  ),
                  _ChannelCard(
                    channelId: '164',
                    getChannelFuture: getChannelFuture,
                    onTap: playChannelAudio,
                  ),
                  _ChannelCard(
                    channelId: '213',
                    getChannelFuture: getChannelFuture,
                    onTap: playChannelAudio,
                  ),
                  _ChannelCard(
                    channelId: '223',
                    getChannelFuture: getChannelFuture,
                    onTap: playChannelAudio,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChannelCard extends StatefulWidget {
  const _ChannelCard({
    required this.channelId,
    required this.getChannelFuture,
    required this.onTap,
  });

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
    return AspectRatio(
      aspectRatio: 1,
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

class _FeaturedEpisode extends StatefulWidget {
  const _FeaturedEpisode({
    required this.getEpisodeFuture,
    required this.episodeId,
  });

  final Future<Episode> Function(String) getEpisodeFuture;
  final String episodeId;

  @override
  State<_FeaturedEpisode> createState() => _FeaturedEpisodeState();
}

class _FeaturedEpisodeState extends State<_FeaturedEpisode> {
  late Future<Episode> _episodeFuture;

  @override
  void initState() {
    super.initState();
    _episodeFuture = widget.getEpisodeFuture(widget.episodeId);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
        child: AspectRatio(
          aspectRatio: 5 / 4,
          child: FutureBuilder(
            future: _episodeFuture,
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
                              style: TextStyle(color: SRColors.primaryForeground, fontSize: 11, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              episode.name,
                              maxLines: 2,
                              style: TextStyle(color: SRColors.primaryForeground, fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              episode.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: SRColors.primaryForeground, fontSize: 14, fontWeight: FontWeight.w300),
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
