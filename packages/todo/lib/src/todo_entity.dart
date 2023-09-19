class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({
    this.id = '',
    required this.title,
    this.isDone = false,
  });

  Todo toggleDone() => copyWith(isDone: !isDone);

  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        isDone: isDone ?? this.isDone,
      );

  factory Todo.fromMap(Map<String, dynamic> map) => Todo(
        id: map['id'] as String,
        title: map['title'] as String,
        isDone: map['isDone'] as bool,
      );

  Map<String, dynamic> get asMap => {
        'id': id,
        'title': title,
        'isDone': isDone,
      };
}
