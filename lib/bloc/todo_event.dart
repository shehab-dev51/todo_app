import 'package:equatable/equatable.dart';
import '../models/todo_model.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddTodo extends TodoEvent {
  final Todo todo;
  AddTodo(this.todo);
}

class ToggleTodo extends TodoEvent {
  final String id;
  ToggleTodo(this.id);
}

class DeleteTodo extends TodoEvent {
  final String id;
  DeleteTodo(this.id);
}

class ChangeFilter extends TodoEvent {
  final String filter;
  ChangeFilter(this.filter);
}