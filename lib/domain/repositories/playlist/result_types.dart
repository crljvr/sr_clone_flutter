import 'package:sr_clone_flutter/domain/entities/playlist.dart';

abstract class GetPlaylistResult {}

class GetPlaylistSuccessful implements GetPlaylistResult {
  const GetPlaylistSuccessful(this.playlist);
  final Playlist playlist;
}

class GetPlaylistFailure implements GetPlaylistResult {}
