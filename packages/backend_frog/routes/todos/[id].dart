import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo/todo.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  return switch (context.request.method) {
    HttpMethod.get => await _get(context, id),
    HttpMethod.put => await _put(context, id),
    HttpMethod.delete => await _delete(context, id),
    _ => Response(statusCode: HttpStatus.notFound)
  };
}

Future<Response> _get(RequestContext context, String id) async {
  final todo = await context.read<TodoRepository>().getById(id);

  return Response.json(body: todo.asMap);
}

Future<Response> _put(RequestContext context, String id) async {
  final json = await context.request.json() as Map<String, dynamic>;
  final todo = Todo.fromMap(json);
  await context.read<TodoRepository>().update(todo);
  return Response();
}

Future<Response> _delete(RequestContext context, String id) async {
  final json = await context.request.json() as Map<String, dynamic>;
  final id = json['id'] as String;
  await context.read<TodoRepository>().deleteById(id);
  return Response();
}
