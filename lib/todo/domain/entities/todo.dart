

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
class Todo extends Equatable{
  String id; //Id
  final String task; //Task
  final String note; //Addition information
  final DateTime lMod; //Time of Last Modification
  final DateTime nTime;//Time when we need to remind about todo
  Todo({
    @required this.id,
    @required this.task,
    @required this.note,
    @required this.lMod,
    @required this.nTime
  });

  @override
  List<Object> get props => [id, task, note, lMod, nTime];

}