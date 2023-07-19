import 'package:todo/todo.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final todo = Todo(id: 'id', title: 'awesome');

    setUp(() {
      // Additional setup goes here.
    });

    test('CopyWith', () {
      final copy = todo.copyWith(title: 'awesome2');
      expect(copy.title, 'awesome2');
    });
  });
}
