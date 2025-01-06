// see: https://adventofcode.com/2024/day/1

import 'dart:io';
import 'dart:convert';

import 'package:day01/day01_calculate.dart';

void main(List<String> arguments) async {
  final file = File('input.txt');
  Stream<String> lines = file.openRead().transform(utf8.decoder).transform(LineSplitter());

  final regex = RegExp(r'\b\d+\b');
  List<int> a = [], b = [];
  await for (var line in lines) {
    final matches = regex.allMatches(line);
    final locations = matches.map((match) => match.group(0)).take(2).toList();
    if (locations.length == 2) {
      a.add(int.parse(locations[0]!));
      b.add(int.parse(locations[1]!));
    } else {
      print('Invalid line read: $line');
    }
  }

  final distance = calculateDistance(a, b);
  print('Part 1: $distance');

  final score = calculateSimilarityScore(a, b);
  print('Part 2: $score');
}
