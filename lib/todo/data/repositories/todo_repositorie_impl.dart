import 'package:dartz/dartz.dart';
import 'package:supertodo/todo/data/datasources/todo_sembast_data_source.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';
import 'package:supertodo/todo/domain/repositories/todo_repositories.dart';
import 'package:meta/meta.dart';

class TodoRepositoryImpl implements TodoRepository{
  final TodoDaoDb dao;

  TodoRepositoryImpl({
    @required this.dao
  });
  @override
  addTodo(Todo todo) {
    dao.addTodo(todo);
  }

  @override
  getTodosByLMTime() async{
    return right(await dao.getAllSertedByLMTime());
  }

  @override
  removeTodo(Todo todo) {
    dao.remove(todo);
  }

  @override
  updateTodo(Todo todo) {
    dao.update(todo);
  }

}