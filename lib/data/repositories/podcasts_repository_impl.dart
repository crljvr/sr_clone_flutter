import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/domain/repositories/podcasts/podcasts_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/podcasts/result_types.dart';

class PodcastsRepositoryImpl implements PodcastsRepository {
  const PodcastsRepositoryImpl(this._datasource);

  final Datasource _datasource;

  @override
  Future<GetPodcastReslut> getPodcast(String id) async {
    try {
      final dto = await _datasource.getPodcast(id);
      final podcast = dto.asPodcast;

      return GetPodcastSuccessful(podcast);
    } on UnableToGetPodcastFromDatasourceException catch (_) {
      return const GetPodcastFailure(GetPodcastFailureReason.unknown);
    }
  }
}
