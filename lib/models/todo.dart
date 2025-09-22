class ToDo {
  final String? id;
  final String title;
  final bool isDone;

  const ToDo({this.id, required this.title, this.isDone = false});

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(
      id: json['id'] as String?,
      title: json['title'] as String,
      isDone: json['is_done'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'is_done': isDone};
  }
}
