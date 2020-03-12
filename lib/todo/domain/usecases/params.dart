import 'package:equatable/equatable.dart';
import 'package:supertodo/todo/domain/entities/todo.dart';
import 'package:meta/meta.dart';

class Params extends Equatable {
  final Todo todo;
  Params({
    @required this.todo,
  });

  @override
  // TODO: implement props
  List<Object> get props => [todo];
}