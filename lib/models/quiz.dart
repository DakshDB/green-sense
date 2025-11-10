import 'question.dart';
import 'category.dart';
import 'action_guide.dart';

class Quiz {
  final String id;
  final String title;
  final String description;
  final List<Question> questions;
  final Difficulty difficulty;
  final Category category;

  Quiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    required this.difficulty,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'questions': questions.map((q) => q.toJson()).toList(),
        'difficulty': difficulty.name,
        'category': category.name,
      };

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        questions: (json['questions'] as List)
            .map((q) => Question.fromJson(q))
            .toList(),
        difficulty: Difficulty.values.byName(json['difficulty']),
        category: Category.values.byName(json['category']),
      );
}
