import 'package:puzzles/puzzles.dart';
import 'package:test/test.dart';

void main() {
  test('test duplicateItemsValue', () async {
    await expectLater(
        duplicateItemsValue('input.txt.example'), completion(157));
  });
}
