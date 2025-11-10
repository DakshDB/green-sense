import 'package:shared_preferences/shared_preferences.dart';
import '../models/daily_challenge.dart';
import '../data/challenges_data.dart';

class ChallengeService {
  static const String _completionsKey = 'challenge_completions';
  static const DateTime _epochStart = DateTime(2024, 1, 1);

  /// Get challenge for today (rotates through list based on date)
  DailyChallenge getTodaysChallenge() {
    final now = DateTime.now();
    final daysSinceEpoch = now.difference(_epochStart).inDays;
    final challengeIndex = daysSinceEpoch % allChallenges.length;

    final challenge = allChallenges[challengeIndex];
    return DailyChallenge(
      id: challenge.id,
      title: challenge.title,
      description: challenge.description,
      difficulty: challenge.difficulty,
      category: challenge.category,
      date: DateTime(now.year, now.month, now.day), // Normalize to midnight
    );
  }

  /// Mark challenge complete for today
  Future<void> completeChallenge(String challengeId) async {
    final prefs = await SharedPreferences.getInstance();
    final completions = await getCompletionHistory();

    final today = _normalizeDate(DateTime.now());
    completions[today] = challengeId;

    // Convert map to storable format
    final encoded = completions.entries.map((e) => '${e.key.millisecondsSinceEpoch}:${e.value}').toList();
    await prefs.setStringList(_completionsKey, encoded);
  }

  /// Check if today's challenge is complete
  Future<bool> isTodayComplete() async {
    final completions = await getCompletionHistory();
    final today = _normalizeDate(DateTime.now());
    return completions.containsKey(today);
  }

  /// Get completion history (last 90 days)
  Future<Map<DateTime, String>> getCompletionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = prefs.getStringList(_completionsKey) ?? [];

    final Map<DateTime, String> completions = {};
    for (final entry in encoded) {
      final parts = entry.split(':');
      if (parts.length == 2) {
        final date = DateTime.fromMillisecondsSinceEpoch(int.parse(parts[0]));
        completions[_normalizeDate(date)] = parts[1];
      }
    }

    return completions;
  }

  /// Calculate current streak (consecutive days)
  Future<int> getCurrentStreak() async {
    final completions = await getCompletionHistory();
    if (completions.isEmpty) return 0;

    int streak = 0;
    DateTime checkDate = _normalizeDate(DateTime.now());

    // Check if today is complete, if not start from yesterday
    if (!completions.containsKey(checkDate)) {
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    // Count backwards from today/yesterday
    while (completions.containsKey(checkDate)) {
      streak++;
      checkDate = checkDate.subtract(const Duration(days: 1));
    }

    return streak;
  }

  /// Get longest streak ever
  Future<int> getLongestStreak() async {
    final completions = await getCompletionHistory();
    if (completions.isEmpty) return 0;

    final sortedDates = completions.keys.toList()..sort();

    int longestStreak = 1;
    int currentStreak = 1;

    for (int i = 1; i < sortedDates.length; i++) {
      final diff = sortedDates[i].difference(sortedDates[i - 1]).inDays;

      if (diff == 1) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else {
        currentStreak = 1;
      }
    }

    return longestStreak;
  }

  /// Get total challenges completed
  Future<int> getTotalCompleted() async {
    final completions = await getCompletionHistory();
    return completions.length;
  }

  /// Get completion calendar for last 30 days
  Future<Map<DateTime, bool>> getCompletionCalendar() async {
    final completions = await getCompletionHistory();
    final Map<DateTime, bool> calendar = {};

    final today = _normalizeDate(DateTime.now());

    for (int i = 0; i < 30; i++) {
      final date = today.subtract(Duration(days: i));
      calendar[date] = completions.containsKey(date);
    }

    return calendar;
  }

  /// Normalize date to midnight UTC for consistent comparison
  DateTime _normalizeDate(DateTime date) {
    return DateTime.utc(date.year, date.month, date.day);
  }

  /// Clear all completion data (for testing)
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_completionsKey);
  }
}
