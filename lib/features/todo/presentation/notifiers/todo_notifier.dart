import 'package:flutter/material.dart';

import '../../domain/entities/todo.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/toggle_todo_status.dart';

class TodoNotifier extends ChangeNotifier {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final ToggleTodoStatus toggleTodoStatus;

  List<Todo> _todos = [];
  String? _errorMessage;
  bool _isLoading = false;

  TodoNotifier({
    required this.getTodos,
    required this.addTodo,
    required this.toggleTodoStatus,
  });

  List<Todo> get todos => List.unmodifiable(_todos);
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> loadTodos() async {
    _setLoading(true);
    try {
      final list = await getTodos();
      _todos = list;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Falha ao carregar tarefas: $e';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> createTodo(String title) async {
    _setLoading(true);
    try {
      await addTodo.call(title);
      await loadTodos(); 
      _errorMessage = null;
    } on ArgumentError catch (e) {
      _errorMessage = e.message;
    } catch (e) {
      _errorMessage = 'Falha ao adicionar tarefa: $e';
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> toggleTodo(Todo todo) async {
    _setLoading(true);
    try {
      await toggleTodoStatus.call(todo);
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index >= 0) {
        _todos[index] = _todos[index].copyWith(isCompleted: !todo.isCompleted);
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Falha ao atualizar tarefa: $e';
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}