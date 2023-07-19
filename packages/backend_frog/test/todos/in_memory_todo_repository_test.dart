import 'package:remote_todo_backend/data/in_memory_todo_repository.dart';
import 'package:test/test.dart';
import 'package:todo/todo.dart';

void main() {
  group('fetch all', () {
    test('fetch all todos".', () {
      InMemoryTodoRepository()
          .fetchAll()
          .then((value) => expect(value, List<Todo>.empty()));
    });
  });

  group('add and delete', () {
    final repo = InMemoryTodoRepository();
    final todo = Todo(id: 'id', title: 'title');
    late Todo newTodo;
    test('add a todo".', () async {
      final added = await repo.add(todo);
      expect(added, isA<Todo>());
      newTodo = added;
    });

    test('get a todo".', () async {
      expect(repo.getById(newTodo.id), completion(newTodo));
    });

    test('delete a todo".', () async {
      await repo.deleteById(newTodo.id);
    });

    test('deleted todo not found".', () async {
      expect(() => repo.getById(newTodo.id), throwsStateError);
    });
  });
}
