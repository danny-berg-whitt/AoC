import 'package:puzzles/puzzles.dart' as puzzles;

void main(List<String> arguments) {
  puzzles
      .reduceSizeOnDisk(arguments.first, 100000)
      .then((value) => print('Part One (reduceSizeOnDisk): $value'));
}
