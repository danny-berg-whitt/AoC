import "dart:async";
import 'dart:convert';
import "dart:io";

Future<int> duplicateWorkPairs(String filename) async {
  var pairs = 0;
  final lines = readFile(filename);
  try {
    await for (var line in lines) {
      var elfAssignments = line.split(',');
      var elfOneStartAssignment = int.parse(elfAssignments[0].split('-').first);
      var elfOneEndAssignment = int.parse(elfAssignments[0].split('-').last);
      var elfTwoStartAssignment = int.parse(elfAssignments[1].split('-').first);
      var elfTwoEndAssignment = int.parse(elfAssignments[1].split('-').last);
      if (elfOneStartAssignment >= elfTwoStartAssignment &&
              elfOneEndAssignment <= elfTwoEndAssignment ||
          elfTwoStartAssignment >= elfOneStartAssignment &&
              elfTwoEndAssignment <= elfOneEndAssignment) {
        pairs++;
      }
    }
  } catch (e) {
    print('Error: $e');
    return -1;
  }
  return pairs;
}

Future<int> overlappingWorkPairs(String filename) async {
  var pairs = 0;
  final lines = readFile(filename);
  try {
    await for (var line in lines) {
      var elfAssignments = line.split(',');
      var elfOneStartAssignment = int.parse(elfAssignments[0].split('-').first);
      var elfOneEndAssignment = int.parse(elfAssignments[0].split('-').last);
      var elfTwoStartAssignment = int.parse(elfAssignments[1].split('-').first);
      var elfTwoEndAssignment = int.parse(elfAssignments[1].split('-').last);
      if (elfOneStartAssignment >= elfTwoStartAssignment &&
              elfOneStartAssignment <= elfTwoEndAssignment ||
          elfTwoStartAssignment >= elfOneStartAssignment &&
              elfTwoStartAssignment <= elfOneEndAssignment) {
        pairs++;
      }
    }
  } catch (e) {
    print('Error: $e');
    return -1;
  }
  return pairs;
}

Stream<String> readFile(String filename) {
  final file = File(filename);
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  return lines;
}
