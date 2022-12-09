import 'package:puzzles/puzzles.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  parameterizedTest(
    'startOfPacketMarker',
    ParameterizedSource.csv([
      '7',
      '5',
      '6',
      '10',
      '11',
    ]),
    (List<dynamic> values) async {
      final actual = startOfPacketMarker('input.txt.example.${values[0]}');
      final expected = values[0];
      await expectLater(actual, completion(expected));
    },
  );
}
