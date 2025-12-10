import 'package:shared_preferences/shared_preferences.dart';

class UsageTrackingService {
  static const String _queryCountKey = 'ai_chat_query_count';
  static const String _lastQueryDateKey = 'ai_chat_last_query_date';
  static const int _dailyQueryLimit = 30;

  /// Check if user can make another query today
  Future<bool> canMakeQuery() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayString();
    final lastQueryDate = prefs.getString(_lastQueryDateKey);
    final queryCount = prefs.getInt(_queryCountKey) ?? 0;

    // If it's a new day, reset the counter
    if (lastQueryDate != today) {
      await _resetDailyCount();
      return true;
    }

    // Check if user has exceeded the daily limit
    return queryCount < _dailyQueryLimit;
  }

  /// Get remaining queries for today
  Future<int> getRemainingQueries() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayString();
    final lastQueryDate = prefs.getString(_lastQueryDateKey);
    final queryCount = prefs.getInt(_queryCountKey) ?? 0;

    // If it's a new day, user has full quota
    if (lastQueryDate != today) {
      return _dailyQueryLimit;
    }

    return (_dailyQueryLimit - queryCount).clamp(0, _dailyQueryLimit);
  }

  /// Get queries used today
  Future<int> getQueriesUsedToday() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayString();
    final lastQueryDate = prefs.getString(_lastQueryDateKey);
    final queryCount = prefs.getInt(_queryCountKey) ?? 0;

    // If it's a new day, no queries used yet
    if (lastQueryDate != today) {
      return 0;
    }

    return queryCount;
  }

  /// Record a query usage
  Future<void> recordQuery() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayString();
    final lastQueryDate = prefs.getString(_lastQueryDateKey);
    final queryCount = prefs.getInt(_queryCountKey) ?? 0;

    // If it's a new day, start fresh
    if (lastQueryDate != today) {
      await prefs.setString(_lastQueryDateKey, today);
      await prefs.setInt(_queryCountKey, 1);
    } else {
      // Increment the counter
      await prefs.setInt(_queryCountKey, queryCount + 1);
    }
  }

  /// Reset daily count (called when new day starts)
  Future<void> _resetDailyCount() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayString();
    await prefs.setString(_lastQueryDateKey, today);
    await prefs.setInt(_queryCountKey, 0);
  }

  /// Get today's date as string (YYYY-MM-DD)
  String _getTodayString() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Get daily query limit
  int get dailyLimit => _dailyQueryLimit;

  /// Check if user is approaching the limit (80% usage)
  Future<bool> isApproachingLimit() async {
    final used = await getQueriesUsedToday();
    return used >= (_dailyQueryLimit * 0.8).floor();
  }

  /// Get time until reset (next day)
  Duration getTimeUntilReset() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    return tomorrow.difference(now);
  }
}
