

import 'package:dartz/dartz.dart';
import 'package:supertodo/core/error/failure.dart';
import 'package:supertodo/core/usecases/usecase.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';
import 'package:supertodo/todo/domain/repositories/todo_repositories.dart';

class GetTodosByLMTimeUS implements UseCase<List<Todo>, NoParams>{
  final TodoRepository repository;
  GetTodosByLMTimeUS(this.repository);
  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async{
    return await repository.getTodosByLMTime();
  }
}