import 'dart:convert';
import 'dart:io';

import 'package:stack/stack.dart';

Future<int> totalSizeOnDisk(String filename) async {
  var root = await _buildDirTree(filename);
  return _totalSize(root);
}

Future<int> reduceSizeOnDisk(String filename, int dirSize) async {
  var root = await _buildDirTree(filename);
  return _reduceSize(root, dirSize);
}

Future<Map<dynamic, dynamic>> _buildDirTree(String filename) async {
  var root = {};

  var cwd = root;
  var ds = Stack();

  final file = File(filename);
  await file
      .openRead()
      .transform(utf8.decoder)
      .transform(LineSplitter())
      .forEach((line) {
    var args = line.split(' ');
    try {
      if (args.first == '\$') {
        if (args[1] == 'cd') {
          var dir = args[2];
          switch (dir) {
            case '/':
              cwd = root;
              ds = Stack();
              break;
            case '..':
              cwd = ds.pop();
              break;
            default:
              if (cwd.containsKey(dir)) {
                cwd[dir] = {};
              }
              ds.push(cwd);
              cwd = cwd[dir];
              break;
          }
        }
      } else {
        if (args[0] == 'dir') {
          if (!cwd.containsKey(args[1])) {
            cwd[args[1]] = {};
          }
        } else {
          cwd[args[1]] = int.parse(args[0]);
        }
      }
    } catch (e) {
      rethrow;
    }
  });
  return root;
}

int _totalSize(Map dir) {
  int size = 0;
  for (var entry in dir.entries) {
    var e = entry.value;
    if (e.runtimeType == int) {
      size += e as int; // probably safe?
    } else {
      size += _totalSize(e);
    }
  }
  return size;
}

int _reduceSize(Map root, int dirSize) {
  int size = 0;
  List<Map> dirs = [];
  for (var dir in root.entries) {
    var v = dir.value;
    if (v.runtimeType == Map) {
      dirs.add(v);
    }
  }
  dirs.sort();
  for (var d in dirs) {
    for (var v in d.entries) {
      if (v.value.runtimeType == int) {
        var s = v.value as int;
        if (size + s <= dirSize) {
          size += s;
        }
      }
    }
  }
  return size;
}
