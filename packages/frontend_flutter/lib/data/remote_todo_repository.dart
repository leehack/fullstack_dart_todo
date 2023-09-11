import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo/todo.dart';

const baseURL = "http://localhost:8080";
const baseHeaders = {
  'Origin': baseURL,
  'Content-Type': 'application/json',
};

class RemoteTodoRepository implements TodoRepository {
  @override
  Future<Todo> add(Todo todo) async {
    final response = await http.Client().post(
      Uri.parse("$baseURL/todos"),
      headers: baseHeaders,
      body: jsonEncode(todo.asMap),
    );
    final json = response.body;

    return Todo.fromMap(jsonDecode(json));
  }

  @override
  Future<void> deleteById(String id) async {
    await http.Client().delete(
      Uri.parse("$baseURL/todos/$id"),
      headers: baseHeaders,
    );
  }

  @override
  Future<List<Todo>> fetchAll() async {
    final response = await http.Client().get(
      Uri.parse("$baseURL/todos"),
      headers: baseHeaders,
    );
    final json = response.body;

    return [for (final todo in jsonDecode(json)) Todo.fromMap(todo)];
  }

  @override
  Future<Todo> getById(String id) async {
    final response = await http.Client()
        .get(Uri.parse("$baseURL/todos/$id"), headers: baseHeaders);
    final json = response.body;

    return Todo.fromMap(jsonDecode(json));
  }

  @override
  Future<void> updateById(Todo todo) async {
    await http.Client().put(
      Uri.parse("$baseURL/todos/${todo.id}"),
      headers: baseHeaders,
      body: jsonEncode(todo.asMap),
    );
  }
}
