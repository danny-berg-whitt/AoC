// see: https://adventofcode.com/2022/day/1

import 'dart:io';
import 'dart:convert';
import 'dart:async';

void main() async {
  final file = File('input.txt');
  var calories = 0;
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    var c = 0;
    await for (var line in lines) {
      if (line.isEmpty) {
        if (c > calories) {
          calories = c;
        }
        c = 0;
      } else {
        c += int.parse(line);
      }
    }
    print(calories);
  } catch (e) {
    print('Error: $e');
  }
}
