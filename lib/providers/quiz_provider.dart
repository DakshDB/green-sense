import 'package:flutter/foundation.dart';
import 'package:green_sense/models/quiz.dart';

class QuizProvider extends ChangeNotifier {
  Quiz? _currentQuiz;
  int _currentQuestionIndex = 0;
  Map<int, String> _answers = {};
  int _score = 0;
  bool _isCompleted = false;

  Quiz? get currentQuiz => _currentQuiz;
  int get currentQuestionIndex => _currentQuestionIndex;
  Map<int, String> get answers => _answers;
  int get score => _score;
  bool get isCompleted => _isCompleted;
  int get totalQuestions => _currentQuiz?.questions.length ?? 0;
  double get progress => totalQuestions > 0
    ? (_currentQuestionIndex + 1) / totalQuestions
    : 0.0;

  void startQuiz(Quiz quiz) {
    _currentQuiz = quiz;
    _currentQuestionIndex = 0;
    _answers = {};
    _score = 0;
    _isCompleted = false;
    notifyListeners();
  }

  void answerQuestion(String answer) {
    if (_currentQuiz == null) return;

    _answers[_currentQuestionIndex] = answer;

    // Check if answer is correct
    if (_currentQuiz!.questions[_currentQuestionIndex].correctAnswer == answer) {
      _score++;
    }

    notifyListeners();
  }

  void nextQuestion() {
    if (_currentQuiz == null) return;

    if (_currentQuestionIndex < _currentQuiz!.questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      _isCompleted = true;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      _currentQuestionIndex--;
      notifyListeners();
    }
  }

  String? getAnswer(int questionIndex) {
    return _answers[questionIndex];
  }

  bool hasAnsweredCurrent() {
    return _answers.containsKey(_currentQuestionIndex);
  }

  void reset() {
    _currentQuiz = null;
    _currentQuestionIndex = 0;
    _answers = {};
    _score = 0;
    _isCompleted = false;
    notifyListeners();
  }
}
