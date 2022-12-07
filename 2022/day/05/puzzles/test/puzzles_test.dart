import 'package:puzzles/puzzles.dart';
import 'package:test/test.dart';

void main() {
  test('test rearrangeCrateStacks (rearrangeCratesWithCrateMover9000)',
      () async {
    await expectLater(
        rearrangeCrateStacks(
            'input.txt.example', rearrangeCratesWithCrateMover9000),
        completion('CMZ'));
  });
  test('test rearrangeCrateStacks (rearrangeCratesWithCrateMover9001)',
      () async {
    await expectLater(
        rearrangeCrateStacks(
            'input.txt.example', rearrangeCratesWithCrateMover9001),
        completion('MCD'));
  });
}
