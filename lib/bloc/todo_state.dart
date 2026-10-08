import 'package:equatable/equatable.dart';
import '../models/todo_model.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final String currentFilter;

  const TodoState({
    this.todos = const [],
    this.currentFilter = 'الكل',
  });

  List<Todo> get filteredTodos {
    if (currentFilter == 'نشط') return todos.where((t) => !t.isCompleted).toList();
    if (currentFilter == 'مكتمل') return todos.where((t) => t.isCompleted).toList();
    return todos; // 'الكل'
  }

  double get completionPercentage {
    if (todos.isEmpty) return 0;
    final completed = todos.where((t) => t.isCompleted).length;
    return completed / todos.length;
  }

  TodoState copyWith({List<Todo>? todos, String? currentFilter}) {
    return TodoState(
      todos: todos ?? this.todos,
      currentFilter: currentFilter ?? this.currentFilter,
    );
  }

  @override
  List<Object> get props => [todos, currentFilter];
}