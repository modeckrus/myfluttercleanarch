
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:supertodo/core/httpclient/httpclient.dart';
import 'package:supertodo/core/network/network_info.dart';
import 'package:supertodo/todo/data/datasources/todo_sembast_data_source.dart';
import 'package:supertodo/todo/data/repositories/todo_repositorie_impl.dart';
import 'package:supertodo/todo/domain/repositories/todo_repositories.dart';
import 'package:supertodo/todo/domain/usecases/add_todo_usecase.dart';
import 'package:supertodo/todo/domain/usecases/get_todosByLMTime_usecase.dart';
import 'package:supertodo/todo/domain/usecases/remove_todo_usecase.dart';
import 'package:supertodo/todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;


Future<void> init() async{
  //Bloc
  sl.registerFactory(
    () => TodoBloc(repository: sl()) //Repository depend
  );

  //Use Cases
  sl.registerLazySingleton(() => AddTodoUS(sl()));
  sl.registerLazySingleton(() => UpdateTodoE(sl()));
  sl.registerLazySingleton(() => RemoveTodoUS(sl()));
  sl.registerLazySingleton(() => GetTodosByLMTimeUS(sl()));

  //Repositories

  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(dao: sl())
  );

  //Data Sources
  sl.registerLazySingleton<TodoDaoDb>(
    () => TodoDaoDbImpl()
  );


  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  sl.registerLazySingleton<HttpClient>(() => HttpClient());
  sl.registerLazySingleton<DataConnectionChecker>(() => DataConnectionChecker());
}