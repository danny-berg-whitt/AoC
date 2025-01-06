import 'package:day01/day01_calculate.dart';
import 'package:test/test.dart';

void main() {
  List<int> a = [3, 4, 2, 1, 3, 3], b = [4, 3, 5, 3, 9, 3];

  test('calculateDistance', () {
    expect(calculateDistance(a, b), 11);
  });

  test('calculateSimilarityScore', () {
    expect(calculateSimilarityScore(a, b), 31);
  });
}
