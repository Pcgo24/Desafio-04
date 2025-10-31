import '../../domain/entities/todo.dart';
import '../../domain/repositories/i_todo_repository.dart';
import '../datasources/todo_local_datasource.dart';

class TodoRepositoryImpl implements ITodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<List<Todo>> getTodos() => localDataSource.getAllTodos();

  @override
  Future<void> saveTodo(Todo todo) => localDataSource.addTodo(todo);

  @override
  Future<void> updateTodo(Todo todo) => localDataSource.updateTodo(todo);
}