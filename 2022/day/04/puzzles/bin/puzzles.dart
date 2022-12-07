import 'package:puzzles/puzzles.dart' as puzzles;

void main(List<String> arguments) {
  puzzles
      .duplicateWorkPairs(arguments.first)
      .then((value) => print('Part One (duplicateWorkPairs): $value'));
  puzzles
      .overlappingWorkPairs(arguments.first)
      .then((value) => print('Part Two (overlappingWorkPairs): $value'));
}
