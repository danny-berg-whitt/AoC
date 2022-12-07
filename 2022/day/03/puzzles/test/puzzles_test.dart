import 'package:puzzles/puzzles.dart';
import 'package:test/test.dart';

void main() {
  test('test duplicateItemsValue', () async {
    await expectLater(
        duplicateItemsValue('input.txt.example'), completion(157));
  });
  test('test groupBadgesValue', () async {
    await expectLater(groupBadgesValue('input.txt.example'), completion(70));
  });
}
