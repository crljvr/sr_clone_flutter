import 'package:sr_clone_flutter/domain/repositories/playlist/result_types.dart';

// ignore: one_member_abstracts
abstract class PlaylistRepository {
  Future<GetPlaylistResult> getPlaylist(String programId);
}
