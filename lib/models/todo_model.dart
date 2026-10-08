class Todo {
  final String id;
  final String title;
  final bool isCompleted;
  final String tag;

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.tag = 'عام',
  });

  Todo copyWith({String? id, String? title, bool? isCompleted, String? tag}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      tag: tag ?? this.tag,
    );
  }
}