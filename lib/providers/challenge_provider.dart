import 'package:flutter/foundation.dart';
import 'package:green_sense/models/challenge.dart';
import 'package:green_sense/services/challenge_service.dart';

class ChallengeProvider extends ChangeNotifier {
  final ChallengeService _service = ChallengeService();
  Challenge? _todayChallenge;
  int _currentStreak = 0;
  int _totalPoints = 0;
  List<DateTime> _completedDates = [];
  bool _isTodayCompleted = false;

  Challenge? get todayChallenge => _todayChallenge;
  int get currentStreak => _currentStreak;
  int get totalPoints => _totalPoints;
  List<DateTime> get completedDates => _completedDates;
  bool get isTodayCompleted => _isTodayCompleted;

  ChallengeProvider() {
    _loadData();
  }

  void _loadData() {
    _todayChallenge = _service.getTodayChallenge();
    _isTodayCompleted = _service.isChallengeCompleted(DateTime.now());
    _currentStreak = _service.getCurrentStreak();
    _totalPoints = _service.getTotalPoints();
    _completedDates = _service.getCompletedDates();
    notifyListeners();
  }

  Future<void> completeChallenge() async {
    if (_todayChallenge == null || _isTodayCompleted) return;

    await _service.completeChallenge(_todayChallenge!);
    _isTodayCompleted = true;
    _totalPoints += _todayChallenge!.points;
    _currentStreak = _service.getCurrentStreak();
    _completedDates = _service.getCompletedDates();
    notifyListeners();
  }

  void refresh() {
    _loadData();
  }
}
