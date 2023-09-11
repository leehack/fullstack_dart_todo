import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_todo_flutter/providers/todo_list_provider.dart';
import 'package:todo/todo.dart';

class TodoListView extends ConsumerWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(todoListProvider)) {
      AsyncData(:final value) => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: value.length,
          itemBuilder: (context, index) => TodoItem(todo: value[index]),
        ),
      AsyncLoading() => const Center(child: CircularProgressIndicator()),
      _ => const Center(child: Text("Error")),
    };
  }
}

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key, required this.todo});

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        Checkbox(
          value: todo.isDone,
          onChanged: (value) {
            ref.read(todoListProvider.notifier).toggleDone(todo);
          },
        ),
      ],
    );
  }
}
