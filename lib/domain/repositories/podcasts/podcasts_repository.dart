import 'package:sr_clone_flutter/domain/repositories/podcasts/result_types.dart';

// ignore: one_member_abstracts
abstract class PodcastsRepository {
  Future<GetPodcastReslut> getPodcast(String id);
}
