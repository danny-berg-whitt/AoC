// see: https://adventofcode.com/2022/day/1

import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() async {
  final file = File('input.txt');
  var calories = <int>[];
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    var c = 0;
    await for (var line in lines) {
      if (line.isEmpty) {
        calories.add(c);
        c = 0;
      } else {
        c += int.parse(line);
      }
    }
    calories.sort();
    var l = calories.length;
    print('${calories[l - 3] + calories[l - 2] + calories[l - 1]}');
  } catch (e) {
    print('Error: $e');
  }
}
