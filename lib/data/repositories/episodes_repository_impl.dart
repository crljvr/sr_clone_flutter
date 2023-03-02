import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/episodes_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/result_types.dart';

class EpisodesRepositoryImpl implements EpisodesRepository {
  const EpisodesRepositoryImpl(this._datasource);

  final Datasource _datasource;

  @override
  Future<GetEpisodeReslut> getEpisode(String id) async {
    try {
      final dto = await _datasource.getEpisode(id);
      final episode = dto.asEpisode;

      return GetEpisodeSuccessful(episode);
    } on UnableToGetEpisodeFromDatasourceException catch (_) {
      return const GetEpisodeFailure(GetEpisodeFailureReason.unknown);
    }
  }
}
