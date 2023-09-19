import 'package:todo/todo.dart';

abstract interface class TodoRepository {
  Future<List<Todo>> fetchAll();
  Future<Todo> getById(String id);
  Future<Todo> add(Todo todo);
  Future<void> deleteById(String id);
  Future<void> update(Todo todo);
}
