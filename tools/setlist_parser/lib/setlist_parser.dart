import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cores/cores.dart';

class SetlistParser {
  static const eventFilePath = '../../app/assets/event.json';
  static const stageFilePath = '../../app/assets/stage.json';
  static const musicFilePath = '../../app/assets/music.json';
  static const defaultThumbnailUrl =
      'https://i.scdn.co/image/ab67616d0000b2736775a0cf0a809ce0b0d861b3';
  static const seMusicId = 'dummyNewSeABCDEFGHIJKL';

  Future<void> parseAndUpdate(String filePath) async {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw Exception('File not found: $filePath');
    }

    final content = await file.readAsString();
    final parsedData = _parseInputData(content);

    await _updateJsonFiles(parsedData);
  }

  ParsedData _parseInputData(String content) {
    final lines = content.split('\n').map((line) => line.trim()).toList();

    // Skip the first line if it starts with "#XINXINセトリ"
    var startIndex = 0;
    if (lines.isNotEmpty && lines[0].startsWith('#XINXINセトリ')) {
      startIndex = 1;
    }

    if (startIndex >= lines.length) {
      throw Exception('No content found after header');
    }

    final dateAndVenueMatch = RegExp(
      r'^(\d{4}\.\d{1,2}\.\d{1,2})\s+(\w+\.)\s+(.+)$',
    ).firstMatch(lines[startIndex]);
    if (dateAndVenueMatch == null) {
      throw Exception('Invalid date and venue format: ${lines[startIndex]}');
    }

    var dateStr = dateAndVenueMatch.group(1)!.replaceAll('.', '-');
    final dateParts = dateStr.split('-');
    if (dateParts.length == 3) {
      final year = dateParts[0];
      final month = dateParts[1].padLeft(2, '0');
      final day = dateParts[2].padLeft(2, '0');
      dateStr = '$year-$month-$day';
    }
    final dayOfWeek = dateAndVenueMatch.group(2)!;
    final venueName = dateAndVenueMatch.group(3)!;

    // Find event title (from next line until first empty line)
    final eventTitleLines = <String>[];
    var eventTitleEndIndex = startIndex + 1;

    for (var i = startIndex + 1; i < lines.length; i++) {
      if (lines[i].isEmpty) {
        eventTitleEndIndex = i;
        break;
      }
      eventTitleLines.add(lines[i]);
      eventTitleEndIndex = i + 1;
    }

    if (eventTitleLines.isEmpty) {
      throw Exception('No event title found');
    }

    final eventTitle = eventTitleLines.join('\n');

    var hasSE = false;
    final songs = <String>[];

    for (var i = eventTitleEndIndex; i < lines.length; i++) {
      final line = lines[i];
      if (line.isEmpty) {
        continue;
      }

      // Check for standalone "SE" line
      if (line == 'SE') {
        hasSE = true;
        continue;
      }

      // Check for legacy format: (SE)Title (not used in new format but kept
      // for compatibility)
      final seMatch = RegExp(r'^\(SE\)(.+)$').firstMatch(line);
      if (seMatch != null) {
        hasSE = true;
        continue;
      }

      // Check for numbered songs: "1. Title"
      final songMatch = RegExp(r'^\d+\.\s*(.+)$').firstMatch(line);
      if (songMatch != null) {
        songs.add(songMatch.group(1)!);
      }
    }

    return ParsedData(
      date: dateStr,
      dayOfWeek: dayOfWeek,
      venueName: venueName,
      eventTitle: eventTitle,
      hasSE: hasSE,
      songs: songs,
    );
  }

  Future<void> _updateJsonFiles(ParsedData data) async {
    final events = await _loadEvents();
    final stages = await _loadStages();
    final musics = await _loadMusics();

    final stageId = _getOrCreateStage(stages, data.venueName);
    final songIds = data.songs
        .map((song) => _getOrCreateMusic(musics, song))
        .toList();

    final eventId = _generateId();
    final setlist = <SetlistItem>[];

    if (data.hasSE) {
      setlist.add(
        SetlistItem(
          musicId: SetlistItemId(seMusicId),
          order: 0,
        ),
      );
    }

    for (var i = 0; i < songIds.length; i++) {
      setlist.add(
        SetlistItem(
          musicId: SetlistItemId(songIds[i]),
          order: data.hasSE ? i + 1 : i,
        ),
      );
    }

    final newEvent = Event(
      id: EventId(eventId),
      stageId: stageId,
      title: data.eventTitle.replaceAll('\n', ' '),
      date: DateTime.parse(data.date),
      setlist: setlist,
    );

    events.add(newEvent);

    await _saveEvents(events);
    await _saveStages(stages);
    await _saveMusics(musics);

    await _formatJsonFiles();
  }

  Future<List<Event>> _loadEvents() async {
    final file = File(eventFilePath);
    if (!file.existsSync()) {
      return [];
    }

    final content = await file.readAsString();
    final json = jsonDecode(content) as List;
    return json
        .map((item) => Event.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Stage>> _loadStages() async {
    final file = File(stageFilePath);
    if (!file.existsSync()) {
      return [];
    }

    final content = await file.readAsString();
    final json = jsonDecode(content) as List;
    return json
        .map((item) => Stage.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Music>> _loadMusics() async {
    final file = File(musicFilePath);
    if (!file.existsSync()) {
      return [];
    }

    final content = await file.readAsString();
    final json = jsonDecode(content) as List;
    return json
        .map((item) => Music.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  String _getOrCreateStage(List<Stage> stages, String title) {
    final existingStage = stages
        .where((stage) => stage.title == title)
        .firstOrNull;
    if (existingStage != null) {
      return existingStage.id.value;
    }

    final newStage = Stage(
      id: StageId(_generateId()),
      title: title,
    );
    stages.add(newStage);
    return newStage.id.value;
  }

  String _getOrCreateMusic(List<Music> musics, String title) {
    final existingMusic = musics
        .where((music) => music.title == title)
        .firstOrNull;
    if (existingMusic != null) {
      return existingMusic.id.value;
    }

    final newMusic = Music(
      id: MusicId(_generateId()),
      title: title,
      thumbnailUrl: defaultThumbnailUrl,
    );
    musics.add(newMusic);
    return newMusic.id.value;
  }

  String _generateId() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return List.generate(
      22,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
  }

  Future<void> _saveEvents(List<Event> events) async {
    // Sort events by date first, then by order (null order treated as 0)
    events.sort((a, b) {
      final dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) {
        return dateComparison;
      }
      // If dates are equal, sort by order (null treated as 0)
      final aOrder = a.order ?? 0;
      final bOrder = b.order ?? 0;
      return aOrder.compareTo(bOrder);
    });

    final file = File(eventFilePath);
    final json = jsonEncode(events.map((event) => event.toJson()).toList());
    await file.writeAsString(json);
  }

  Future<void> _saveStages(List<Stage> stages) async {
    final file = File(stageFilePath);
    final json = jsonEncode(stages.map((stage) => stage.toJson()).toList());
    await file.writeAsString(json);
  }

  Future<void> _saveMusics(List<Music> musics) async {
    final file = File(musicFilePath);
    final json = jsonEncode(musics.map((music) => music.toJson()).toList());
    await file.writeAsString(json);
  }

  Future<void> _formatJsonFiles() async {
    try {
      final result = await Process.run(
        'bun',
        ['run', 'format'],
        workingDirectory: '../../',
      );

      if (result.exitCode == 0) {
        stdout.writeln('JSON files formatted successfully');
      } else {
        stderr.writeln('Warning: Prettier formatting failed: ${result.stderr}');
      }
    } on Exception catch (e) {
      stderr.writeln('Warning: Could not run prettier formatting: $e');
    }
  }

  // Test helper methods
  ParsedData parseInputDataForTest(String content) => _parseInputData(content);
  String generateIdForTest() => _generateId();
}

class ParsedData {
  ParsedData({
    required this.date,
    required this.dayOfWeek,
    required this.venueName,
    required this.eventTitle,
    required this.songs,
    required this.hasSE,
  });
  final String date;
  final String dayOfWeek;
  final String venueName;
  final String eventTitle;
  final bool hasSE;
  final List<String> songs;
}
