import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final _analytics = FirebaseAnalytics.instance;

  static Future<void> logLogin(String uid) async {
    await _analytics.logLogin(loginMethod: 'phone');
  }
}
