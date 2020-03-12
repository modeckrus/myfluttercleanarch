import 'package:dartz/dartz.dart';
import 'package:supertodo/core/error/failure.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';

abstract class TodoRepository{
  addTodo(Todo todo);
  updateTodo(Todo todo);
  removeTodo(Todo todo);
  Future <Either<Failure, List<Todo>>> getTodosByLMTime();//Get todos by Last Time Modified time
}