import 'dart:convert';

class ChatAppData {
  ChatAppData({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.author,
  });
  String? id;
  final String title;
  final String description;
  final bool isCompleted;
  final String author;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'isCompleted': isCompleted});
    result.addAll({'author': author});

    return result;
  }

  factory ChatAppData.fromMap(Map<String, dynamic> map) {
    return ChatAppData(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      author: map['author'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatAppData.fromJson(String source) =>
      ChatAppData.fromMap(json.decode(source));
}
