import 'package:puzzles/puzzles.dart' as puzzles;

void main(List<String> arguments) {
  puzzles.rps(arguments.first).then((value) => print(value));
  puzzles.spr(arguments.first).then((value) => print(value));
}
