import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/todo/data/datasources/todo_local_datasource.dart';
import 'features/todo/data/repositories/todo_repository_impl.dart';
import 'features/todo/domain/usecases/add_todo.dart';
import 'features/todo/domain/usecases/get_todos.dart';
import 'features/todo/domain/usecases/toggle_todo_status.dart';
import 'features/todo/presentation/notifiers/todo_notifier.dart';
import 'features/todo/presentation/pages/todo_list_screen.dart';

void main() {
  // Configuração manual de dependências (simples)
  final localDataSource = TodoLocalDataSource(); // simula armazenamento local e gera ids
  final repository = TodoRepositoryImpl(localDataSource);
  final getTodos = GetTodos(repository: repository);
  final addTodo = AddTodo(repository: repository);
  final toggleTodoStatus = ToggleTodoStatus(repository: repository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TodoNotifier(
            getTodos: getTodos,
            addTodo: addTodo,
            toggleTodoStatus: toggleTodoStatus,
          )..loadTodos(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DDD Refactor Challenge',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoListScreen(),
    );
  }
}