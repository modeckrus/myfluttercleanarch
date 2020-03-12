

import 'package:dartz/dartz.dart';
import 'package:supertodo/core/error/failure.dart';
import 'package:supertodo/core/usecases/usecase.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';
import 'package:supertodo/todo/domain/repositories/todo_repositories.dart';
import 'package:supertodo/todo/domain/usecases/params.dart';

class RemoveTodoUS implements UseCase<Todo, Params>{
  final TodoRepository repository;
  RemoveTodoUS(this.repository);
  @override
  Future<Either<Failure, Todo>> call(params) async{
    return await repository.removeTodo(params.todo);
  }
}