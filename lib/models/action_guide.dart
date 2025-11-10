import 'category.dart';

enum Difficulty { easy, medium, advanced }

extension DifficultyExtension on Difficulty {
  String get displayName {
    switch (this) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.advanced:
        return 'Advanced';
    }
  }
}

class ActionGuide {
  final String id;
  final String title;
  final String description;
  final List<String> steps;
  final Difficulty difficulty;
  final Map<String, String> impact;
  final Category category;
  final String imageUrl;

  ActionGuide({
    required this.id,
    required this.title,
    required this.description,
    required this.steps,
    required this.difficulty,
    required this.impact,
    required this.category,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'steps': steps,
        'difficulty': difficulty.name,
        'impact': impact,
        'category': category.name,
        'imageUrl': imageUrl,
      };

  factory ActionGuide.fromJson(Map<String, dynamic> json) => ActionGuide(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        steps: List<String>.from(json['steps']),
        difficulty: Difficulty.values.byName(json['difficulty']),
        impact: Map<String, String>.from(json['impact']),
        category: Category.values.byName(json['category']),
        imageUrl: json['imageUrl'],
      );
}
