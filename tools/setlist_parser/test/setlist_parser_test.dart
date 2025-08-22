import 'package:setlist_parser/setlist_parser.dart';
import 'package:test/test.dart';

void main() {
  group('SetlistParser', () {
    test('should parse date format correctly', () {
      final parser = SetlistParser();
      const testContent = '''
2025.8.7 Thu. Test Venue
『Test Event』

(SE)Test SE
1. Test Song 1
2. Test Song 2''';

      final parsed = parser.parseInputDataForTest(testContent);
      expect(parsed.date, equals('2025-08-07'));
      expect(parsed.venueName, equals('Test Venue'));
      expect(parsed.eventTitle, equals('『Test Event』'));
      expect(parsed.hasSE, isTrue);
      expect(parsed.songs.length, equals(2));
    });

    test('should generate valid IDs', () {
      final parser = SetlistParser();
      final id1 = parser.generateIdForTest();
      final id2 = parser.generateIdForTest();

      expect(id1.length, equals(22));
      expect(id2.length, equals(22));
      expect(id1, isNot(equals(id2)));
    });
  });
}
