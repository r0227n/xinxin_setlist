import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_analytics_service.g.dart';

@Riverpod(keepAlive: true)
FirebaseAnalytics firebaseAnalytics(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
FirebaseAnalyticsService firebaseAnalyticsService(Ref ref) {
  final analytics = ref.watch(firebaseAnalyticsProvider);
  return FirebaseAnalyticsService(analytics);
}

class FirebaseAnalyticsService {
  const FirebaseAnalyticsService(this._analytics);

  final FirebaseAnalytics _analytics;

  Future<void> enableAnalytics({bool enabled = true}) async {
    await _analytics.setAnalyticsCollectionEnabled(enabled);
  }

  /// カスタムイベントを記録
  Future<void> customEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    await _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }
}
