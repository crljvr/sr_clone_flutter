import 'package:sr_clone_flutter/domain/entities/program.dart';
import 'package:sr_clone_flutter/domain/repositories/programs/programs_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/programs/result_types.dart';
import 'package:sr_clone_flutter/domain/use_cases/use_case.dart';

class GetProgramUseCase implements UseCase<Future<Program>, String> {
  const GetProgramUseCase(this._programsRepository);

  final ProgramsRepository _programsRepository;

  @override
  Future<Program> call<NoParams>(String programId) async {
    final result = await _programsRepository.getProgram(programId);
    if (result is GetProgramSuccessful) return result.program;
    if (result is GetProgramFailure) throw GetProgramException();

    throw Exception();
  }
}

class GetProgramException implements Exception {}
