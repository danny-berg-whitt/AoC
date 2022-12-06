import 'dart:async';
import 'dart:convert';
import 'dart:io';

enum ThrowValues {
  rock(1),
  paper(2),
  scissors(3);

  final int throwValue;
  const ThrowValues(this.throwValue);
}

enum MatchOutcomes {
  loss(0),
  draw(3),
  win(6);

  final int outcome;
  const MatchOutcomes(this.outcome);
}

Future<int> rps(String filename) async {
  var score = 0;
  final file = File(filename);
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      var opponentThrow =
          ThrowValues.values[line.codeUnitAt(0) - 'A'.codeUnitAt(0)];
      var myThrow = ThrowValues.values[line.codeUnitAt(2) - 'X'.codeUnitAt(0)];
      score += matchScore(myThrow, opponentThrow);
    }
  } catch (e) {
    print('Error: $e');
    return -1;
  }
  return score;
}

Future<int> spr(String filename) async {
  var score = 0;
  final file = File(filename);
  Stream<String> lines = file
      .openRead()
      .transform(utf8.decoder) // Decode bytes to UTF-8.
      .transform(LineSplitter()); // Convert stream to individual lines.
  try {
    await for (var line in lines) {
      var opponentThrow =
          ThrowValues.values[line.codeUnitAt(0) - 'A'.codeUnitAt(0)];
      var matchOutcome =
          MatchOutcomes.values[line.codeUnitAt(2) - 'X'.codeUnitAt(0)];
      var myThrow = matchThrowByOutcome(matchOutcome, opponentThrow);
      score += matchScore(myThrow, opponentThrow);
    }
  } catch (e) {
    print('Error: $e');
    return -1;
  }
  return score;
}

ThrowValues matchThrowByOutcome(
    MatchOutcomes matchOutcome, ThrowValues opponentThrow) {
  switch (matchOutcome) {
    case MatchOutcomes.loss:
      switch (opponentThrow) {
        case ThrowValues.rock:
          return ThrowValues.scissors;
        case ThrowValues.paper:
          return ThrowValues.rock;
        case ThrowValues.scissors:
          return ThrowValues.paper;
      }
    case MatchOutcomes.draw:
      return opponentThrow;
    case MatchOutcomes.win:
      switch (opponentThrow) {
        case ThrowValues.rock:
          return ThrowValues.paper;
        case ThrowValues.paper:
          return ThrowValues.scissors;
        case ThrowValues.scissors:
          return ThrowValues.rock;
      }
  }
}

int matchScore(ThrowValues myThrow, ThrowValues opponentThrow) {
  return myThrow.throwValue + matchOutcome(myThrow, opponentThrow);
}

int matchOutcome(ThrowValues myThrow, ThrowValues opponentThrow) {
  switch (myThrow) {
    case ThrowValues.rock:
      switch (opponentThrow) {
        case ThrowValues.rock:
          return MatchOutcomes.draw.outcome;
        case ThrowValues.paper:
          return MatchOutcomes.loss.outcome;
        case ThrowValues.scissors:
          return MatchOutcomes.win.outcome;
      }
    case ThrowValues.paper:
      switch (opponentThrow) {
        case ThrowValues.rock:
          return MatchOutcomes.win.outcome;
        case ThrowValues.paper:
          return MatchOutcomes.draw.outcome;
        case ThrowValues.scissors:
          return MatchOutcomes.loss.outcome;
      }
    case ThrowValues.scissors:
      switch (opponentThrow) {
        case ThrowValues.rock:
          return MatchOutcomes.loss.outcome;
        case ThrowValues.paper:
          return MatchOutcomes.win.outcome;
        case ThrowValues.scissors:
          return MatchOutcomes.draw.outcome;
      }
  }
}
