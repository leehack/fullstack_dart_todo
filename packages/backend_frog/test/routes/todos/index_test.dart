import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:todo/todo.dart';

import '../../../routes/todos/index.dart' as route;

class _MockRequestContext extends Mock implements RequestContext {}

class _MockRequest extends Mock implements Request {}

class _MockTodosRepository extends Mock implements TodoRepository {}

void main() {
  late RequestContext context;
  late Request request;
  late TodoRepository todoRepository;

  const id = 'id';
  final todo = Todo(
    id: id,
    title: 'Test title',
  );

  setUpAll(() => registerFallbackValue(todo));

  setUp(() {
    context = _MockRequestContext();
    request = _MockRequest();
    todoRepository = _MockTodosRepository();
    when(() => context.read<TodoRepository>()).thenReturn(todoRepository);
    when(() => context.request).thenReturn(request);
  });

  group('GET /', () {
    test('responds with a 200".', () async {
      when(() => request.method).thenReturn(HttpMethod.get);
      when(() => todoRepository.fetchAll()).thenAnswer((_) async => []);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));

      verify(() => context.read<TodoRepository>()).called(1);
    });
  });

  group('POST /', () {
    test('responds with a 200".', () async {
      when(() => request.method).thenReturn(HttpMethod.post);
      when(() => request.json()).thenAnswer((_) async => todo.asMap);
      when(() => todoRepository.add(any())).thenAnswer((_) async => todo);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(response.json(), completion(todo.asMap));
    });
  });
}
