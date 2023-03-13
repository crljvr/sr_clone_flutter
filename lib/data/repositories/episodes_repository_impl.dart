import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/episodes_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/result_types.dart';

class EpisodesRepositoryImpl implements EpisodesRepository {
  const EpisodesRepositoryImpl(this._datasource);

  final Datasource _datasource;

  @override
  Future<GetEpisodesReslut> getEpisodes(String programId) async {
    try {
      final dtos = await _datasource.getEpisodes(programId);
      final episodes = dtos.map((dto) => dto.asEpisode).toList();
      return GetEpisodesSuccessful(episodes);
    } on UnableToGetEpisodesFromDatasourceException catch (_) {
      return const GetEpisodesFailure(GetEpisodesFailureReason.unknown);
    }
  }
}
