import 'package:sr_clone_flutter/domain/repositories/player/player_repository.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';

class LoadContentUseCase implements UseCase<void, PlayerContent> {
  const LoadContentUseCase(this._playerRepository);

  final PlayerRepository _playerRepository;

  @override
  void call<NoGeneric>(PlayerContent playerContent) {
    _playerRepository.loadContent(playerContent);
  }
}
