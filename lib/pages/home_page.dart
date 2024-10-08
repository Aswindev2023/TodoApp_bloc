import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/utils/edit_todo.dart';
import 'package:todo_app/utils/snackbar_todo.dart';
import 'package:todo_app/utils/todo_list.dart';

class HomePage extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackbarTodo(message: message).getSnackBar(),
    );
  }

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      // backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'To-do',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TodoLoaded) {
            final toDoList = state.items;
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    children: toDoList.map((todo) {
                      return TodoList(
                        todo: todo,
                        onChanged: (value) {
                          final updates = {
                            'title': todo.title,
                            'completed': value,
                          };

                          context.read<TodoBloc>().add(UpdateTodoEvent(
                                todo.id,
                                updates,
                              ));
                          showSnackbar(context, 'Todo Updated');
                        },
                        deleteFunction: (context) {
                          context
                              .read<TodoBloc>()
                              .add(DeleteTodoEvent(todo.id));
                          showSnackbar(context, 'Todo Deleted');
                        },
                        editFunction: (context, todo) => showDialog(
                          context: context,
                          builder: (context) => EditTodoDialog(
                            todo: todo,
                            id: todo.id,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              hintText: 'Add a new todo item',
                              filled: true,
                              fillColor: Colors.deepPurple.shade200,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        FloatingActionButton(
                          onPressed: () {
                            if (_controller.text.isNotEmpty) {
                              final newTodo = TodoModel(
                                title: _controller.text,
                                completed: false,
                                id: 0,
                              );
                              context
                                  .read<TodoBloc>()
                                  .add(CreateTodoEvent(newTodo));
                              showSnackbar(context, 'Todo Added');
                              _controller.clear();
                            }
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else if (state is TodoError) {
            return Center(child: Text('Error: ${state.messages}'));
          } else {
            return const Center(child: Text('No Todos Available'));
          }
        },
      ),
    );
  }
}
