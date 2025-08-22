import 'dart:io';

import 'package:args/args.dart';
import 'package:setlist_parser/setlist_parser.dart';

void main(List<String> arguments) async {
  final parser = ArgParser()
    ..addMultiOption(
      'files',
      abbr: 'f',
      help: 'Input files to parse (comma-separated)',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show help',
      negatable: false,
    );

  try {
    final results = parser.parse(arguments);

    if (results['help'] as bool) {
      stdout.writeln('Usage: setlist_parser -f file1.txt,file2.txt');
      stdout.writeln(parser.usage);
      return;
    }

    final fileOptions = results['files'] as List<String>;
    if (fileOptions.isEmpty) {
      stderr.writeln('Error: No input files specified. Use -f option.');
      exit(1);
    }

    final filePaths = fileOptions
        .expand(
          (path) => path.split(',').map((p) => p.trim()),
        )
        .toList();

    final setlistParser = SetlistParser();

    for (final filePath in filePaths) {
      stdout.writeln('Processing file: $filePath');
      await setlistParser.parseAndUpdate(filePath);
    }

    stdout.writeln('All files processed successfully!');
  } on Exception catch (e) {
    stderr.writeln('Error: $e');
    exit(1);
  }
}
