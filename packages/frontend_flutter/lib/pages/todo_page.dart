import 'package:flutter/material.dart';
import 'package:remote_todo_flutter/presentation/todo_list_view.dart';
import 'package:remote_todo_flutter/presentation/todo_text_field.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TodoTextField(),
          ),
          Expanded(child: SelectionArea(child: TodoListView())),
        ],
      ),
    );
  }
}
