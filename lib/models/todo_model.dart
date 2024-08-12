class TodoModel {
  int? userId;
  int id;
  String? title;
  bool? completed;

  TodoModel({this.userId, required this.id, this.title, this.completed});

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        userId: json['userId'] as int?,
        id: json['id'] ?? 0,
        title: json['title'] as String?,
        completed: json['completed'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'completed': completed,
      };
}
