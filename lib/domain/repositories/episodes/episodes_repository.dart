import 'package:sr_clone_flutter/domain/repositories/episodes/result_types.dart';

// ignore: one_member_abstracts
abstract class EpisodesRepository {
  Future<GetNewsEpisodesReslut> getNewsEpisodes(String programId);
}
