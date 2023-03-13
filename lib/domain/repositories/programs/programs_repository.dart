import 'package:sr_clone_flutter/domain/repositories/programs/result_types.dart';

// ignore: one_member_abstracts
abstract class ProgramsRepository {
  Future<GetProgramResult> getProgram(String programId);
}
