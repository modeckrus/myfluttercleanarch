part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoLoading extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded([this.todos = const []]);
  @override
  List<Object> get props => [todos];

  @override
  String toString() {
    return "TodosLoaded { todos: $todos }";
  }
}

class TodoNotLoaded extends TodoState {
  @override
  List<Object> get props => [];
}
