import 'package:rxdart/rxdart.dart';
import 'package:sr_clone_flutter/domain/repositories/player/player_repository.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final _playerContentSubject = BehaviorSubject<PlayerContent?>();

  @override
  Stream<PlayerContent?> get contentStream => _playerContentSubject;

  @override
  void loadContent(PlayerContent playerContent) {
    // Adds null before new content to allow stream builders to detect changes
    _playerContentSubject.add(null);
    _playerContentSubject.add(playerContent);
  }
}
