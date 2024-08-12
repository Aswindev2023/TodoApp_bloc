part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadingTodoEvent extends TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final TodoModel todo;

  const CreateTodoEvent(this.todo);

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends TodoEvent {
  final int id;
  final Map<String, dynamic> updatedFields;

  const UpdateTodoEvent(this.id, this.updatedFields);
  @override
  List<Object> get props => [id, updatedFields];
}

class DeleteTodoEvent extends TodoEvent {
  final int id;

  const DeleteTodoEvent(this.id);

  @override
  List<Object> get props => [id];
}
