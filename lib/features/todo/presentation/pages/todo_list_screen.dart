import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/todo.dart';
import '../notifiers/todo_notifier.dart';

class TodoListScreen extends StatelessWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifier = Provider.of<TodoNotifier>(context);
    final controller = TextEditingController();

    void add() async {
      final text = controller.text;
      await notifier.createTodo(text);
      if (notifier.errorMessage == null) {
        controller.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(notifier.errorMessage ?? 'Erro')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Tarefas (DDD)')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Nova Tarefa'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: notifier.isLoading ? null : add,
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          ),
          if (notifier.isLoading) const LinearProgressIndicator(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => notifier.loadTodos(),
              child: ListView.builder(
                itemCount: notifier.todos.length,
                itemBuilder: (context, index) {
                  final Todo todo = notifier.todos[index];
                  return ListTile(
                    title: Text(
                      todo.title.value,
                      style: TextStyle(
                        decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    trailing: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) => notifier.toggleTodo(todo),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}