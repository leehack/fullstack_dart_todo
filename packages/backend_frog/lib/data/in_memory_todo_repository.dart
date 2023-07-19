import 'package:todo/todo.dart';
import 'package:uuid/uuid.dart';

/// A TodoData
class InMemoryTodoRepository implements TodoRepository {
  /// Local data
  List<Todo> data = [];

  /// Get List of [Todo]
  List<Todo> get todos => data;

  @override
  Future<Todo> getById(String id) async {
    return data.firstWhere((todo) => todo.id == id);
  }

  /// Add a new [todo] and return [Todo] with new id
  @override
  Future<Todo> add(Todo todo) async {
    final newTodo = todo.copyWith(id: const Uuid().v4());
    data = [...data, newTodo];
    return newTodo;
  }

  @override
  Future<void> deleteById(String id) async {
    data = [
      for (final t in data)
        if (t.id != id) t
    ];
  }

  @override
  Future<List<Todo>> fetchAll() async {
    return data;
  }

  @override
  Future<void> updateById(Todo todo) async {
    data = [
      for (final t in data)
        if (t.id == todo.id) todo else t
    ];
  }
}
