import 'package:puzzles/puzzles.dart';
import 'package:test/test.dart';

void main() {
  test("test rps", () async {
    await expectLater(rps('input.txt.example'), completion(15));
  });
  test('test spr', () async {
    await expectLater(spr('input.txt.example'), completion(12));
  });
}
