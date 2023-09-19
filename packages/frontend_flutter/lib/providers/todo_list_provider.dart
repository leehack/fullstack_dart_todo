import 'package:remote_todo_flutter/providers/todo_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/todo.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<List<Todo>> build() {
    return ref.read(todoRepositoryProvider).fetchAll();
  }

  Future<void> add(Todo todo) async {
    state = await AsyncValue.guard(() async {
      await ref.read(todoRepositoryProvider).add(todo);
      return ref.read(todoRepositoryProvider).fetchAll();
    });
  }

  void toggleDone(Todo todo) async {
    state = await AsyncValue.guard(() async {
      await ref.read(todoRepositoryProvider).update(todo.toggleDone());
      return ref.read(todoRepositoryProvider).fetchAll();
    });
  }
}
