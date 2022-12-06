import "dart:async";
import 'dart:convert';
import "dart:io";

Future<int> duplicateItemsValue(String filename) async {
  var value = 0;
  final file = File(filename);
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      int elementsPerCompartment = line.length ~/ 2;
      var firstCompartmentItemValues =
          line.codeUnits.getRange(0, elementsPerCompartment);
      var secondCompartmentItemValues =
          line.codeUnits.getRange(elementsPerCompartment, line.length);
      var matchingItem = firstCompartmentItemValues
          .where((e) => secondCompartmentItemValues.contains(e))
          .toList();
      value += itemValue(matchingItem.first);
    }
  } catch (e) {
    print('Error: $e');
    return -1;
  }
  return value;
}

int itemValue(int codeUnit) {
  if (codeUnit >= 'a'.codeUnitAt(0) && codeUnit <= 'z'.codeUnitAt(0)) {
    return codeUnit - '`'.codeUnitAt(0);
  } else if (codeUnit >= 'A'.codeUnitAt(0) && codeUnit <= 'Z'.codeUnitAt(0)) {
    return codeUnit - '&'.codeUnitAt(0);
  } else {
    throw Exception('item outside of expected code unit range');
  }
}
