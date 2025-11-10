import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PledgeProvider extends ChangeNotifier {
  List<String> _selectedCommitments = [];
  Map<String, bool> _commitmentProgress = {};
  DateTime? _pledgeDate;

  List<String> get selectedCommitments => _selectedCommitments;
  Map<String, bool> get commitmentProgress => _commitmentProgress;
  DateTime? get pledgeDate => _pledgeDate;
  bool get hasPledge => _pledgeDate != null;
  int get completedCount => _commitmentProgress.values.where((v) => v).length;
  double get completionPercentage => _selectedCommitments.isEmpty
    ? 0.0
    : completedCount / _selectedCommitments.length;

  PledgeProvider() {
    _loadPledge();
  }

  Future<void> _loadPledge() async {
    final prefs = await SharedPreferences.getInstance();

    final commitments = prefs.getStringList('pledge_commitments') ?? [];
    final dateString = prefs.getString('pledge_date');

    _selectedCommitments = commitments;
    _pledgeDate = dateString != null ? DateTime.parse(dateString) : null;

    // Load progress for each commitment
    for (final commitment in commitments) {
      final key = 'pledge_progress_${commitment.hashCode}';
      _commitmentProgress[commitment] = prefs.getBool(key) ?? false;
    }

    notifyListeners();
  }

  Future<void> createPledge(List<String> commitments) async {
    final prefs = await SharedPreferences.getInstance();

    _selectedCommitments = commitments;
    _pledgeDate = DateTime.now();
    _commitmentProgress = {for (var c in commitments) c: false};

    await prefs.setStringList('pledge_commitments', commitments);
    await prefs.setString('pledge_date', _pledgeDate!.toIso8601String());

    notifyListeners();
  }

  Future<void> toggleCommitmentProgress(String commitment) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'pledge_progress_${commitment.hashCode}';

    _commitmentProgress[commitment] = !(_commitmentProgress[commitment] ?? false);
    await prefs.setBool(key, _commitmentProgress[commitment]!);

    notifyListeners();
  }

  Future<void> resetPledge() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear all progress
    for (final commitment in _selectedCommitments) {
      final key = 'pledge_progress_${commitment.hashCode}';
      await prefs.remove(key);
    }

    await prefs.remove('pledge_commitments');
    await prefs.remove('pledge_date');

    _selectedCommitments = [];
    _commitmentProgress = {};
    _pledgeDate = null;

    notifyListeners();
  }
}
