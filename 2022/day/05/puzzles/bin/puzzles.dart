import 'package:puzzles/puzzles.dart' as puzzles;

void main(List<String> arguments) {
  puzzles
      .rearrangeCrateStacks(
          arguments.first, puzzles.rearrangeCratesWithCrateMover9000)
      .then((value) => print('Part One (processSteps9000): $value'));
  puzzles
      .rearrangeCrateStacks(
          arguments.first, puzzles.rearrangeCratesWithCrateMover9001)
      .then((value) => print('Part Two (processSteps9001): $value'));
}
