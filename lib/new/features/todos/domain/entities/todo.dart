class Todo {
  final String? id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime dueDate;

  const Todo({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    this.completedAt,
    required this.dueDate,
  });
}
