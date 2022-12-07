import 'package:puzzles/puzzles.dart' as puzzles;

void main(List<String> arguments) {
  assert(
      arguments.length == 1, 'expected 1 argument; found ${arguments.length}');
  puzzles.duplicateItemsValue(arguments.first).then((value) => print(value));
  assert(
      arguments.length == 1, 'expected 1 argument; found ${arguments.length}');
  puzzles.groupBadgesValue(arguments.first).then((value) => print(value));
}
