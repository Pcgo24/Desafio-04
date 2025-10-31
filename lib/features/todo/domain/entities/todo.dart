import '../entities/todo_title.dart';

class Todo {
  
  final String? id;
  final TodoTitle title;
  final bool isCompleted;

  const Todo({
    this.id,
    required this.title,
    required this.isCompleted,
  });

  
  Todo copyWith({
    String? id,
    TodoTitle? title,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() => 'Todo(id: $id, title: ${title.value}, completed: $isCompleted)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Todo) return false;
   
    if (id != null && other.id != null) {
      return id == other.id;
    }
    return title.value == other.title.value && isCompleted == other.isCompleted;
  }

  @override
  int get hashCode {
    return id?.hashCode ?? Object.hash(title.value, isCompleted);
  }
}