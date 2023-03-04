import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/domain/entities/playlist.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/episodes_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/episodes/result_types.dart';

class EpisodesRepositoryImpl implements EpisodesRepository {
  const EpisodesRepositoryImpl(this._datasource);

  final Datasource _datasource;

  @override
  Future<GetNewsEpisodesReslut> getNewsEpisodes(String programId) async {
    try {
      final dtos = await _datasource.getNewsEpisodes(programId);
      final episodes = dtos.map((dto) => dto.asNewsEpisode).toList();
      return GetNewsEpisodesSuccessful(episodes);
    } on UnableToGetNewsEpisodesFromDatasourceException catch (e) {
      return const GetNewsEpisodesFailure(GetNewsEpisodesFailureReason.unknown);
    }
  }
}
