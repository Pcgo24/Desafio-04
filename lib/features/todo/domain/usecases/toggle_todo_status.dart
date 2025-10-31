import '../entities/todo.dart';
import '../repositories/i_todo_repository.dart';

class ToggleTodoStatus {
  final ITodoRepository repository;

  ToggleTodoStatus({required this.repository});

  Future<void> call(Todo todo) async {
    final toggled = todo.copyWith(isCompleted: !todo.isCompleted);
    await repository.updateTodo(toggled);
  }
}