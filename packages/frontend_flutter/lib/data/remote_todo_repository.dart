import 'dart:convert';

import 'package:todo/todo.dart';
import 'package:http/http.dart' as http;

const baseURL = "http://localhost:8080";

class RemoteTodoRepository implements TodoRepository {
  @override
  Future<Todo> add(Todo todo) async {
    final client = http.Client();
    final response = await client.post(
      Uri.parse("$baseURL/todos"),
      headers: {
        'Origin': 'http://localhost:8080',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(todo.asMap),
    );
    final json = response.body;

    return Todo.fromMap(jsonDecode(json));
  }

  @override
  Future<void> deleteById(String id) async {
    final client = http.Client();
    await client.delete(
      Uri.parse("$baseURL/todos/$id"),
      headers: {
        'Origin': 'http://localhost:8080',
        'Content-Type': 'application/json',
      },
    );
  }

  @override
  Future<List<Todo>> fetchAll() async {
    final client = http.Client();
    final response = await client.get(
      Uri.parse("$baseURL/todos"),
      headers: {
        'Origin': 'http://localhost:8080',
        'Content-Type': 'application/json',
      },
    );
    final json = response.body;

    return [for (final todo in jsonDecode(json)) Todo.fromMap(todo)];
  }

  @override
  Future<Todo> getById(String id) async {
    final client = http.Client();
    final response = await client.get(
      Uri.parse("$baseURL/todos/$id"),
      headers: {
        'Origin': 'http://localhost:8080',
        'Content-Type': 'application/json',
      },
    );
    final json = response.body;

    return Todo.fromMap(jsonDecode(json));
  }

  @override
  Future<void> updateById(Todo todo) async {
    final client = http.Client();
    await client.put(
      Uri.parse("$baseURL/todos/${todo.id}"),
      headers: {
        'Origin': 'http://localhost:8080',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(todo.asMap),
    );
  }
}
