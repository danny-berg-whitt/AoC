import "dart:async";
import 'dart:convert';
import "dart:io";

import 'dart:developer' show log;
import 'package:logging/logging.dart';

import 'package:stack/stack.dart';

class StepDetail {
  int moves, from, to;
  StepDetail(this.moves, this.from, this.to) {
    moves = moves; // count
    from = from - 1; // list index
    to = to - 1; // list index
  }
}

typedef CrateStackList = List<Stack<String>>;
typedef StepDetailList = List<StepDetail>;

Future<String> rearrangeCrateStacks(
    final String filename,
    final Function(CrateStackList, StepDetailList)
        rearrangeCratesFunction) async {
  try {
    List<String> inputLines = [];

    var crateStacks = await buildCrateStacks(filename, inputLines);

    var steps = buildStepDetails(inputLines);

    crateStacks = rearrangeCratesFunction(crateStacks, steps);

    return topCrates(crateStacks);
  } catch (e) {
    log('Error: $e}', time: DateTime.now(), level: Level.WARNING.value);
    return e.toString();
  }
}

String topCrates(final CrateStackList crateStacks) {
  var crates = '';
  for (var crateStack in crateStacks) {
    if (crateStack.isNotEmpty) {
      crates = crates + crateStack.top();
    }
  }
  return crates;
}

CrateStackList rearrangeCratesWithCrateMover9000(
    final CrateStackList crateStacks, final StepDetailList steps) {
  for (var step in steps) {
    for (var _ = 0; _ < step.moves; _++) {
      crateStacks[step.to].push(crateStacks[step.from].pop());
    }
  }
  return crateStacks;
}

CrateStackList rearrangeCratesWithCrateMover9001(
    final CrateStackList crateStacks, final StepDetailList steps) {
  for (var step in steps) {
    List<String> tmpCrateList = [];
    for (var _ = 0; _ < step.moves; _++) {
      tmpCrateList.add(crateStacks[step.from].pop());
    }
    for (var crate in tmpCrateList.reversed) {
      crateStacks[step.to].push(crate);
    }
  }
  return crateStacks;
}

StepDetailList buildStepDetails(final List<String> inputLines) {
  StepDetailList stepDetails = [];
  for (var i = 0; i < inputLines.length; i++) {
    var steps = inputLines[i]
        .split(' ')
        .where((e) => e.contains(RegExp(r'[0-9]')))
        .toList();
    if (steps.isNotEmpty) {
      stepDetails.add(StepDetail(
          int.parse(steps[0]), int.parse(steps[1]), int.parse(steps[2])));
    }
  }
  return stepDetails;
}

Future<CrateStackList> buildCrateStacks(
    final String filename, final List<String> inputLines) async {
  CrateStackList crateStacks = [];
  final lines = readFile(filename);
  await for (var line in lines) {
    if (line.isEmpty) {
      var numStacks = inputLines.last.split(r'  ').length;
      crateStacks = createCrateStacks(numStacks, inputLines);
      inputLines.clear();
    } else {
      inputLines.add(line);
    }
  }
  return crateStacks;
}

CrateStackList createCrateStacks(
    final int numStacks, final List<String> stackLines) {
  CrateStackList crateStacks = List.generate(numStacks, (index) => Stack());
  var crateIdIndices = [];
  for (var j = 1; j < numStacks * 4; j += 4) {
    crateIdIndices.add(j);
  }
  for (var i = 0; i < numStacks; i++) {
    for (var stackLine in stackLines.reversed) {
      if (stackLine[crateIdIndices[i]].contains(RegExp(r'[A-Z]'))) {
        crateStacks[i].push(stackLine[crateIdIndices[i]]);
      }
    }
  }
  return crateStacks;
}

Stream<String> readFile(final String filename) {
  final file = File(filename);
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  return lines;
}
