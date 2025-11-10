import 'category.dart';

class Article {
  final String id;
  final String title;
  final String excerpt;
  final String content;
  final Category category;
  final int readingTime; // in minutes
  final String imageUrl;
  final String author;
  final DateTime publishDate;

  Article({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.content,
    required this.category,
    required this.readingTime,
    required this.imageUrl,
    required this.author,
    required this.publishDate,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'excerpt': excerpt,
        'content': content,
        'category': category.name,
        'readingTime': readingTime,
        'imageUrl': imageUrl,
        'author': author,
        'publishDate': publishDate.toIso8601String(),
      };

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        id: json['id'],
        title: json['title'],
        excerpt: json['excerpt'],
        content: json['content'],
        category: Category.values.byName(json['category']),
        readingTime: json['readingTime'],
        imageUrl: json['imageUrl'],
        author: json['author'],
        publishDate: DateTime.parse(json['publishDate']),
      );
}
