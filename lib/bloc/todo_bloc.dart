import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repos/fetch_todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepo todoRepo;
  TodoBloc({required this.todoRepo}) : super(TodoInitial()) {
    on<LoadingTodoEvent>(_onFetchTodos);
    on<CreateTodoEvent>(_onCreateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
  }

  Future<void> _onFetchTodos(
      LoadingTodoEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await todoRepo.fetchTodos();
      emit(TodoLoaded(todos));
    } catch (e) {
      emit(TodoError(e.toString()));
    }
  }

  Future<void> _onCreateTodo(
      CreateTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        final createdTodo = await todoRepo.postTodos(event.todo);
        final currentState = state as TodoLoaded;
        final updatedTodos = List<TodoModel>.from(currentState.items)
          ..add(createdTodo);
        emit(TodoLoaded(updatedTodos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    }
  }

  Future<void> _onUpdateTodo(
      UpdateTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        final updatedTodo =
            await todoRepo.updateTodos(event.id, event.updatedFields);
        final currentState = state as TodoLoaded;
        final updatedTodos = currentState.items.map((todo) {
          return todo.id == event.id ? updatedTodo : todo;
        }).toList();

        emit(TodoLoaded(updatedTodos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    }
  }

  Future<void> _onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    if (state is TodoLoaded) {
      try {
        final success = await todoRepo.deleteTodo(event.id);
        if (success) {
          final currentState = state as TodoLoaded;
          final updatedTodos =
              currentState.items.where((todo) => todo.id != event.id).toList();
          emit(TodoLoaded(updatedTodos));
        }
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    }
  }
}
