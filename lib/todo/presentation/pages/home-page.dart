import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supertodo/todo/presentation/bloc/todo_bloc.dart';
import 'package:supertodo/todo/presentation/pages/todo_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('title'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is TodoLoading) {
            return Text('loading');
          }
          if (state is TodoLoaded) {
            return RefreshIndicator(
              onRefresh: (){
                BlocProvider.of<TodoBloc>(context).add(LoadTodosE());
              },
                  child: ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context2, index) {
                    final todo = state.todos[index];
                    return Dismissible(
                      key: ValueKey(todo.id),
                      background: Container(
                        color: Colors.green,
                        child: Text('complete'),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        child: Text('delete'),
                      ),
                      onDismissed: (direction) {
                          print('delete');
                          BlocProvider.of<TodoBloc>(context).add(RemoveTodoE(todo));
                          BlocProvider.of<TodoBloc>(context).add(LoadTodosE());
                      },
                      child: Container(
                        color: Color.fromRGBO(29, 37, 44, 1),
                        child: ListTile(
                          title: Text(todo.task),
                          subtitle: Text(todo.note),
                          trailing: Text(todo.lMod.toString()),
                          onTap: () {
                            print('tapped');
                            Scaffold.of(context).showBottomSheet(
                              (context) {
                                return UpdateTodoWidget(todo: todo,);
                              },
                              elevation: 25,
                              backgroundColor: Color.fromRGBO(23, 29, 35, 1),
                            );
                          },
                        ),
                      ),
                    );
                  }),
            );
          }
        }),
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            print('tapped');

            Scaffold.of(context).showBottomSheet(
              (context) {
                return AddTodoWidget();
              },
              elevation: 25,
              backgroundColor: Color.fromRGBO(23, 29, 35, 1),
            );
          },
          tooltip: 'Add Todo',
          child: Icon(Icons.add),
        );
      }), // This trailing comma makes auto-formatting nicer for build methods.
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}