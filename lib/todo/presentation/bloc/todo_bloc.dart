import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';
import 'package:supertodo/todo/domain/repositories/todo_repositories.dart';
import 'package:meta/meta.dart';
import 'package:supertodo/todo/domain/usecases/get_todosByLMTime_usecase.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;

  TodoBloc({@required this.repository});
  @override
  TodoState get initialState => TodoLoading();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if(event is LoadTodosE){
      yield* _mapLoadTodosToState();
    }
    if(event is AddTodoE){
      await repository.addTodo(event.todo);
      yield* _mapLoadTodosToState();
    }
    if(event is UpdateTodoE){
      await repository.updateTodo(event.todo);
      yield* _mapLoadTodosToState();
    }
    if(event is RemoveTodoE){
      await repository.removeTodo(event.todo);
      yield* _mapLoadTodosToState();
    }
  }
  Stream<TodoState> _mapLoadTodosToState() async* {
      print('hello from bloc');
      final ftodos = await this.repository.getTodosByLMTime();
      print(ftodos);
      if(ftodos.isRight()){
        yield TodoLoaded(ftodos.getOrElse(null));
      }
      /*
      ftodos.fold((failure)async*{
        print('something go wrong');
        yield TodoNotLoaded();
      }, (todos)async*{
        print('bloc todos: ');
        yield TodoLoaded(todos);
      });
      */
  }

}
