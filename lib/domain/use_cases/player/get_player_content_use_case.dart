import 'package:sr_clone_flutter/domain/repositories/player/player_repository.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';
import 'package:sr_clone_flutter/presentation/components/player/player_content.dart';

class GetPlayerContentUseCase implements UseCase<Stream<PlayerContent?>, NoParams> {
  const GetPlayerContentUseCase(this._playerRepository);

  final PlayerRepository _playerRepository;

  @override
  Stream<PlayerContent?> call<NoGeneric>(NoParams _) {
    return _playerRepository.contentStream;
  }
}
