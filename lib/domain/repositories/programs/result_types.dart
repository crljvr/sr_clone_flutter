import 'package:sr_clone_flutter/domain/entities/program.dart';

abstract class GetProgramResult {}

class GetProgramSuccessful implements GetProgramResult {
  const GetProgramSuccessful(this.program);
  final Program program;
}

class GetProgramFailure implements GetProgramResult {}
