import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';

abstract class PlayerRepository {
  void loadContent(PlayerContent playerContent);
  Stream<PlayerContent?> get contentStream;
}
