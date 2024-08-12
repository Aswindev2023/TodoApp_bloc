part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  final List<TodoModel> items;

  const TodoLoaded(this.items);
  @override
  List<Object> get props => [items];
}

class TodoCreated extends TodoState {
  final TodoModel todo;

  const TodoCreated(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodoDeleted extends TodoState {
  final int id;

  const TodoDeleted(this.id);

  @override
  List<Object> get props => [id];
}

class TodoUpdate extends TodoState {
  final TodoModel todoUpdate;
  const TodoUpdate(this.todoUpdate);

  @override
  List<Object> get props => [todoUpdate];
}

final class TodoError extends TodoState {
  final String messages;

  const TodoError(this.messages);
  @override
  List<Object> get props => [messages];
}
