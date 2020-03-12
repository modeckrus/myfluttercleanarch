part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
    @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadTodosE extends TodoEvent{
}

class AddTodoE extends TodoEvent{
  final Todo todo;

  AddTodoE(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'AddTodo { todo: $todo }';
}

class RemoveTodoE extends TodoEvent{
  final Todo todo;

  RemoveTodoE(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'Remove { todo: $todo }';
}


class UpdateTodoE extends TodoEvent{
  final Todo todo;

  UpdateTodoE(this.todo);

  @override
  List<Object> get props => [todo];

  @override
  String toString() => 'Update { todo: $todo }';
}