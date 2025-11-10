import 'category.dart';

class SuccessStory {
  final String id;
  final String title;
  final String summary;
  final String fullStory;
  final String imageUrl;
  final Map<String, String> metrics;
  final String timeline;
  final String source;
  final Category category;

  SuccessStory({
    required this.id,
    required this.title,
    required this.summary,
    required this.fullStory,
    required this.imageUrl,
    required this.metrics,
    required this.timeline,
    required this.source,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'summary': summary,
        'fullStory': fullStory,
        'imageUrl': imageUrl,
        'metrics': metrics,
        'timeline': timeline,
        'source': source,
        'category': category.name,
      };

  factory SuccessStory.fromJson(Map<String, dynamic> json) => SuccessStory(
        id: json['id'],
        title: json['title'],
        summary: json['summary'],
        fullStory: json['fullStory'],
        imageUrl: json['imageUrl'],
        metrics: Map<String, String>.from(json['metrics']),
        timeline: json['timeline'],
        source: json['source'],
        category: Category.values.byName(json['category']),
      );
}
