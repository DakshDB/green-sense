import 'category.dart';
import 'action_guide.dart';

class DailyChallenge {
  final String id;
  final String title;
  final String description;
  final Difficulty difficulty;
  final Category category;
  final DateTime date;

  DailyChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'difficulty': difficulty.name,
        'category': category.name,
        'date': date.toIso8601String(),
      };

  factory DailyChallenge.fromJson(Map<String, dynamic> json) =>
      DailyChallenge(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        difficulty: Difficulty.values.byName(json['difficulty']),
        category: Category.values.byName(json['category']),
        date: DateTime.parse(json['date']),
      );
}
