import 'package:flutter_test/flutter_test.dart';
import 'package:remote_todo_flutter/data/remote_todo_repository.dart';
import 'package:todo/todo.dart';

void main() {
  group("get all todos in remote", () {
    test("successfully fetch", () async {
      final todos = await RemoteTodoRepository().fetchAll();
      expect(todos, isA<List<Todo>>());
    });
  });
}
