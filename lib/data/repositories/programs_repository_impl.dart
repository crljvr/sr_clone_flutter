import 'package:sr_clone_flutter/data/data/datasource.dart';
import 'package:sr_clone_flutter/domain/repositories/programs/programs_repository.dart';
import 'package:sr_clone_flutter/domain/repositories/programs/result_types.dart';

class ProgramsRepositoryImpl implements ProgramsRepository {
  const ProgramsRepositoryImpl(this._datasource);

  final Datasource _datasource;

  @override
  Future<GetProgramResult> getProgram(String programId) async {
    try {
      final dto = await _datasource.getProgram(programId);
      return GetProgramSuccessful(dto.asProgram);
    } catch (_) {
      return GetProgramFailure();
    }
  }
}
