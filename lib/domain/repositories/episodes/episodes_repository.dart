import 'package:sr_clone_flutter/domain/repositories/episodes/result_types.dart';

// ignore: one_member_abstracts
abstract class EpisodesRepository {
  Future<GetEpisodeReslut> getEpisode(String id);
}
