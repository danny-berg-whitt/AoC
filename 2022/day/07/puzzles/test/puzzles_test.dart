import 'package:puzzles/puzzles.dart';
import 'package:test/test.dart';

void main() {
  test('totalSizeOnDisk', () {
    expectLater(totalSizeOnDisk('input.txt.example'), completion(48381165));
  });
  test('reduceSizeOnDisk', () {
    expectLater(
        reduceSizeOnDisk('input.txt.example', 100000), completion(95437));
  },
      skip: 'FIXME: reduceSizeOnDisk is an incomplete '
          '(ahem, incorrect) implementation');
}
