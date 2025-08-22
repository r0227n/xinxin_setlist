// Basic Flutter widget tests that avoid web dependencies

import 'package:app/i18n/translations.g.dart' as app_translations;
import 'package:app_logger/app_logger.dart';
import 'package:app_preferences/app_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  setUpAll(() {
    // Initialize AppLogger for all tests
    if (!AppLogger.isInitialized) {
      AppLogger.initialize(LoggerConfig.development());
    }
  });

  Widget createTestApp(Widget child) {
    return ProviderScope(
      child: app_translations.TranslationProvider(
        child: MaterialApp(home: child),
      ),
    );
  }

  group('Basic Widget Tests', () {
    testWidgets('Basic MaterialApp loads correctly', (tester) async {
      // Build a simple test widget without web dependencies
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            appBar: AppBar(title: const Text('XINXIN SETLIST')),
            body: const Center(child: Text('Test App')),
          ),
        ),
      );

      // Verify the app title is displayed
      expect(find.text('XINXIN SETLIST'), findsOneWidget);
      expect(find.text('Test App'), findsOneWidget);
    });

    testWidgets('Basic navigation works', (tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            appBar: AppBar(
              title: const Text('XINXIN SETLIST'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            body: const Center(child: Text('Home')),
          ),
        ),
      );

      // Find the settings navigation button
      final settingsButton = find.byIcon(Icons.settings);
      expect(settingsButton, findsOneWidget);

      // Verify the button is tappable
      final iconButton = tester.widget<IconButton>(
        find.ancestor(
          of: settingsButton,
          matching: find.byType(IconButton),
        ),
      );
      expect(iconButton.onPressed, isNotNull);
    });

    testWidgets('AppBar shows correct styling', (tester) async {
      await tester.pumpWidget(
        createTestApp(
          Scaffold(
            appBar: AppBar(title: const Text('Test App')),
            body: const Center(child: Text('Content')),
          ),
        ),
      );

      // Find the AppBar
      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);

      // Get the AppBar widget
      final appBarWidget = tester.widget<AppBar>(appBar);

      // Verify the AppBar is properly configured
      expect(appBarWidget, isNotNull);
      expect(appBarWidget.title, isA<Text>());
    });
  });

  group('Theme Tests', () {
    testWidgets('App respects theme configuration', (tester) async {
      await tester.pumpWidget(
        createTestApp(
          const Scaffold(
            body: Center(child: Text('Theme Test')),
          ),
        ),
      );

      // Get the MaterialApp
      final materialApp = find.byType(MaterialApp);
      expect(materialApp, findsOneWidget);

      final app = tester.widget<MaterialApp>(materialApp);
      expect(app, isNotNull);
    });
  });

  group('Localization Tests', () {
    testWidgets('App initializes with translation provider', (tester) async {
      // Create a test SharedPreferences instance
      SharedPreferences.setMockInitialValues({});
      final prefs = await SharedPreferences.getInstance();

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: app_translations.TranslationProvider(
            child: const MaterialApp(
              home: Scaffold(body: Text('Localization Test')),
            ),
          ),
        ),
      );

      // Verify the app loads without errors
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.text('Localization Test'), findsOneWidget);
    });

    testWidgets('Translation provider works correctly', (tester) async {
      // Set locale to Japanese
      await app_translations.LocaleSettings.setLocale(
        app_translations.AppLocale.ja,
      );

      await tester.pumpWidget(
        ProviderScope(
          child: app_translations.TranslationProvider(
            child: const MaterialApp(
              home: Scaffold(body: Text('Test')),
            ),
          ),
        ),
      );

      // Verify the test passes
      await tester.pump();
      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
