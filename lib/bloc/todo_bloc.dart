import 'package:flutter_bloc/flutter_bloc.dart';
import 'todo_event.dart';
import 'todo_state.dart';
import '../models/todo_model.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState()) {

    on<AddTodo>((event, emit) {
      final updated = List<Todo>.from(state.todos)..add(event.todo);
      emit(state.copyWith(todos: updated));
    });

    on<ToggleTodo>((event, emit) {
      final updated = state.todos.map((todo) {
        return todo.id == event.id ? todo.copyWith(isCompleted: !todo.isCompleted) : todo;
      }).toList();
      emit(state.copyWith(todos: updated));
    });

    on<DeleteTodo>((event, emit) {
      final updated = state.todos.where((todo) => todo.id != event.id).toList();
      emit(state.copyWith(todos: updated));
    });

    on<ChangeFilter>((event, emit) {
      emit(state.copyWith(currentFilter: event.filter));
    });
  }
}