// Caso de Uso: AddTodo
import '../entities/todo.dart';
import '../repositories/i_todo_repository.dart';
import '../entities/todo_title.dart';

class AddTodo {
  final ITodoRepository repository;

  AddTodo({required this.repository});

  
  Future<void> call(String titleStr) async {
    final TodoTitle title = TodoTitle(titleStr); 
    final todo = Todo(
      id: null,
      title: title,
      isCompleted: false,
    );
    await repository.saveTodo(todo);
  }
}