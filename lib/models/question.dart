class Question {
  final String text;
  final List<String> options;
  final int correctAnswerIndex;
  final String explanation;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
  });

  Map<String, dynamic> toJson() => {
        'text': text,
        'options': options,
        'correctAnswerIndex': correctAnswerIndex,
        'explanation': explanation,
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        text: json['text'],
        options: List<String>.from(json['options']),
        correctAnswerIndex: json['correctAnswerIndex'],
        explanation: json['explanation'],
      );
}
