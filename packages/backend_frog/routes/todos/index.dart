import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo/todo.dart';

Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => await _get(context),
    HttpMethod.post => await _post(context),
    _ => Response(statusCode: HttpStatus.notFound)
  };
}

Future<Response> _get(RequestContext context) async {
  final todos = await context.read<TodoRepository>().fetchAll();
  final json = [for (var todo in todos) todo.asMap];
  return Response.json(body: json);
}

Future<Response> _post(RequestContext context) async {
  final json = await context.request.json() as Map<String, dynamic>;
  final todo = await context.read<TodoRepository>().add(Todo.fromMap(json));
  return Response.json(body: todo.asMap);
}
