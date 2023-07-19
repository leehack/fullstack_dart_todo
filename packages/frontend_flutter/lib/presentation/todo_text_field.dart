import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:remote_todo_flutter/providers/todo_list_provider.dart';
import 'package:todo/todo.dart';

class TodoTextField extends ConsumerStatefulWidget {
  const TodoTextField({super.key});

  @override
  ConsumerState<TodoTextField> createState() => _TodoTextFieldState();
}

class _TodoTextFieldState extends ConsumerState<TodoTextField> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Enter a new todo',
      ),
      focusNode: focusNode,
      controller: controller,
      onSubmitted: (value) async {
        await ref.read(todoListProvider.notifier).add(
              Todo(id: '', title: value),
            );
        controller.clear();
        focusNode.requestFocus();
      },
    );
  }
}
