import 'package:puzzles/puzzles.dart';
import 'package:test/test.dart';

void main() {
  test('test overlappingWorkPairs', () async {
    await expectLater(duplicateWorkPairs('input.txt.example'), completion(2));
  });
  test('test duplicateWorkPairs', () async {
    await expectLater(overlappingWorkPairs('input.txt.example'), completion(4));
  });
}
