class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime dueDate;

  const TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.createdAt,
    this.completedAt,
    required this.dueDate,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      isDone: json['is_done'] == true,
      createdAt: _parseDate(json['created_at']) ?? DateTime.now(),
      completedAt: _parseDate(json['completed_at']),
      dueDate: _parseDate(json['due_date']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'is_done': isDone,
      // ép về epoch milli (int)
      'created_at': createdAt.millisecondsSinceEpoch,
      'completed_at': completedAt?.millisecondsSinceEpoch,
      'due_date': dueDate.millisecondsSinceEpoch,
    };
  }

  // Hỗ trợ parse nhiều kiểu dữ liệu mà MockAPI trả về
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      // epoch giây
      if (value < 10000000000) {
        return DateTime.fromMillisecondsSinceEpoch(value * 1000);
      }
      // epoch milli
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }
}
