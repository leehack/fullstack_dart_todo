import 'package:remote_todo_flutter/data/remote_todo_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/todo.dart';

part 'todo_repository_provider.g.dart';

@Riverpod(keepAlive: true)
TodoRepository todoRepository(TodoRepositoryRef ref) => RemoteTodoRepository();
