import 'package:supertodo/todo/domain/entities/todo.dart';
import 'package:meta/meta.dart';

class TodoDao extends Todo{
  TodoDao({
    @required String id,
    @required String task,
    @required String note,
    @required DateTime lMod,
    @required DateTime nTime
  }):super(id: id, task: task, note: note, lMod: lMod, nTime: nTime);

  factory TodoDao.fromTodo(Todo todo){
    return TodoDao(
      id: todo.id,
      task: todo.task,
      note: todo.note,
      lMod: todo.lMod,
      nTime: todo.nTime
    );
  }
  
  factory TodoDao.fromJson(Map<String, dynamic> json){
    return TodoDao(
      id: json['id'],
      task: json['task'],
      note: json['note'],
      nTime: DateTime.parse(json['nTime']),
      lMod: DateTime.parse(json['lMod']),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'task' : task,
      'note' : note,
      'nTime' : nTime.toString(),
      'lMod' : lMod.toString(),
    };
  }
}

class TodosModelDao {
  final List<Todo> todos;
  TodosModelDao(this.todos);
  //List<Todo> todos = [];
  factory TodosModelDao.fromJson(dynamic json){
    List<Todo> todos = [];
    for(var td in json){
      var todo = TodoDao.fromJson(td);
      todos.add(todo);
    }
    return TodosModelDao(todos);
  }
  dynamic toJson(){
    return todos;
  }
}