import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';
import 'package:supertodo/todo/presentation/bloc/todo_bloc.dart';

class AddTodoWidget extends StatelessWidget {
  final TextEditingController controllerTask = TextEditingController();
  final TextEditingController controllerNote = TextEditingController();
  final BasicDateTimeField basicDateTimeField = BasicDateTimeField();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            'Add new tusk',
            style: TextStyle(fontSize: 24),
          ),
          TextFormField(
            controller: controllerTask,
            decoration: InputDecoration(
              labelText: 'Task',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: controllerNote,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                labelText: 'Notes',
                helperText: 'Give us Some notes',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: basicDateTimeField,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: () {
              Todo todo = Todo(
                  task: controllerTask.text,
                  note: controllerNote.text,
                  id: '',
                  nTime: basicDateTimeField.date,
                  lMod: DateTime.now());
              BlocProvider.of<TodoBloc>(context).add(AddTodoE(todo));
              BlocProvider.of<TodoBloc>(context).add(LoadTodosE());
              Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}

class UpdateTodoWidget extends StatelessWidget {
  final Todo todo;
  final TextEditingController controllerTask = TextEditingController();
  final TextEditingController controllerNote = TextEditingController();
  final BasicDateTimeField basicDateTimeField = BasicDateTimeField();
  UpdateTodoWidget({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controllerNote.text = todo.note;
    controllerTask.text = todo.task;
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Text(
            'Edit this tusk',
            style: TextStyle(fontSize: 24),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Task',
            ),
            controller: controllerTask,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: controllerNote,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                labelText: 'Notes',
                helperText: 'Give us Some notes',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: basicDateTimeField,
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: () {
              Todo ntodo = Todo(
                  task: controllerTask.text,
                  note: controllerNote.text,
                  id: todo.id,
                  nTime: basicDateTimeField.date,
                  lMod: DateTime.now());
              BlocProvider.of<TodoBloc>(context).add(UpdateTodoE(ntodo));
              Navigator.pop(context);
            },
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20),
                )),
          )
        ],
      ),
    );
  }
}

class BasicDateTimeField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Chose the time when u want to remind'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
                  TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}
