import 'package:random_string/random_string.dart';
import 'package:sembast/sembast.dart';
import 'package:supertodo/core/db/mydatabase.dart';
import 'package:supertodo/todo/data/models/todo_dao_model.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';

abstract class TodoDaoDb{
  Future addTodo(Todo todo);
  Future update(Todo todo);
  Future remove(Todo todo);
  Future<List<Todo>> getAllSertedByLMTime();
}
class TodoDaoDbImpl extends TodoDaoDb{
  static const TODO_STORE_NAME = 'todoStore';
  final _todoStore = stringMapStoreFactory.store(TODO_STORE_NAME);
  
  Future<Database> get _db async => await AppDatabase.instance.database;

  @override
  Future addTodo(Todo todo) async{
    print('Action: add todo from sembast');
    await _todoStore.add(await _db, TodoDao(id: randomString(8), 
    task: todo.task,
    note: todo.note,
    nTime: todo.nTime,
    lMod: todo.lMod).toJson());
  }

  @override
  Future update(Todo todo) async{
    final finder = Finder(filter: Filter.byKey(todo.id)); //Create a finder to find a todo
    await _todoStore.update(await _db, TodoDao.fromTodo(todo).toJson(), finder: finder); //update it
  }

  @override
  Future remove(Todo todo) async{
    final finder = Finder(filter: Filter.byKey(todo.id));
    await _todoStore.delete(await _db, finder: finder);
  }

  @override
  Future<List<Todo>> getAllSertedByLMTime() async{
    print('action: load todos from sembast');
    final finder = Finder(sortOrders: [SortOrder('time')]);
    final records = await _todoStore.find(await _db, finder: finder);
    return records.map((f){
      final todo = TodoDao.fromJson(f.value);
      todo.id = f.key;
      return todo;
    }).toList();
  }

}