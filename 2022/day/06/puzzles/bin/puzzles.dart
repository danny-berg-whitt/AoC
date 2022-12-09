import 'package:puzzles/puzzles.dart' as puzzles;

void main(List<String> arguments) {
  puzzles
      .startOfPacketMarker(arguments.first)
      .then((value) => print('Part One (startOfPacketMarker): $value'));
  puzzles
      .startOfMessageMarker(arguments.first)
      .then((value) => print('Part Two (startOfMessageMarker): $value'));
}
