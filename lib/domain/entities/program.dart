class Program {
  const Program({
    required this.name,
  });

  final String name;
}

class ProgramDto {
  const ProgramDto({
    required this.name,
  });

  factory ProgramDto.fromJson(Map<String, dynamic> json) {
    return ProgramDto(
      name: json['name']! as String,
    );
  }

  Program get asProgram => Program(name: name);

  final String name;
}
