import '../entities/todo.dart';
import '../repositories/i_todo_repository.dart';

class GetTodos {
  final ITodoRepository repository;

  GetTodos({required this.repository});

  Future<List<Todo>> call() async {
    return repository.getTodos();
  }
}