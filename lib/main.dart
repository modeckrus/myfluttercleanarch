import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';
import 'package:supertodo/todo/presentation/bloc/todo_bloc.dart';
import 'package:supertodo/todo/presentation/pages/home-page.dart';

import 'injection_container.dart' as di;
void main()async{
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "SuperTodo",
        theme: ThemeData.dark(),
        home: BlocProvider<TodoBloc>(
          create: (context){
            return TodoBloc(repository: di.sl())..add(LoadTodosE());
          },
          child: MyHomePage(),
        ),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          BlocProvider.of<TodoBloc>(context).add(AddTodoE(Todo(id: '1', task: 'task', note: 'note', nTime: DateTime.now(), lMod: DateTime.now())));
        },
      ),
      body: Container(
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state){
            if(state is TodoLoading){
              return Text('loading');
            }
            if(state is TodoLoaded){
              return Text('loaded');
            }
            if(state is TodoNotLoaded){
              return Text('not loaded');
            }
          },
        ),
      ),
    );
  }
}