import 'dart:async';
import 'package:uuid/uuid.dart';

import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_title.dart';

class TodoLocalDataSource {
  final List<Todo> _storage = [];
  final Uuid _uuid = const Uuid();

  TodoLocalDataSource() {
    _storage.addAll([
      Todo(
        id: _uuid.v4(),
        title: TodoTitle('Comprar leite'),
        isCompleted: false,
      ),
      Todo(
        id: _uuid.v4(),
        title: TodoTitle('Estudar DDD'),
        isCompleted: true,
      ),
    ]);
  }

  Future<List<Todo>> getAllTodos() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List<Todo>.from(_storage);
  }

  Future<void> addTodo(Todo todo) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final todoWithId = todo.id == null
        ? todo.copyWith(id: _uuid.v4())
        : todo;
    _storage.add(todoWithId);
  }

  Future<void> updateTodo(Todo todo) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final index = _storage.indexWhere((t) => t.id == todo.id);
    if (index >= 0) {
      _storage[index] = todo;
    } else {
      final todoWithId = todo.id == null ? todo.copyWith(id: _uuid.v4()) : todo;
      _storage.add(todoWithId);
    }
  }
}