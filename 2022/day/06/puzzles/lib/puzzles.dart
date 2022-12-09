import 'dart:convert';
import 'dart:io';

Future<int> startOfPacketMarker(String filename) async {
  var marker = 0;
  final lines = readFile(filename);
  await for (var line in lines) {
    marker = findStartOfPacketMarker(line, 4);
  }
  return marker;
}

Future<int> startOfMessageMarker(String filename) async {
  var marker = 0;
  final lines = readFile(filename);
  await for (var line in lines) {
    marker = findStartOfPacketMarker(line, 14);
  }
  return marker;
}

// Examine the results of creating capital-S-sets of N-character sequences
// in the message, returning the current end index (marker) when the set
// is successfully created with 4 elements, i.e., N unique characters.
int findStartOfPacketMarker(String line, int n) {
  var message = line.codeUnits; // converient, iterable representation
  for (var i = n; i <= message.length; i++) {
    Set<int> spm = Set.from(message.sublist(i - n, i));
    if (spm.length == n) {
      return i;
    }
  }
  return -1;
}

Stream<String> readFile(final String filename) {
  final file = File(filename);
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  return lines;
}
