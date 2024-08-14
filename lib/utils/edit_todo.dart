import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/utils/snackbar_todo.dart';

class EditTodoDialog extends StatelessWidget {
  final TodoModel todo;
  final int? id;

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackbarTodo(message: message).getSnackBar(),
    );
  }

  const EditTodoDialog({super.key, required this.todo, required this.id});

  @override
  Widget build(BuildContext context) {
    final TextEditingController editController = TextEditingController();
    editController.text = todo.title!;

    return AlertDialog(
      backgroundColor: Colors.greenAccent.shade200,
      title: const Text(
        'Edit Todo',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      ),
      content: TextField(
        controller: editController,
        decoration: const InputDecoration(
          hintText: 'Edit todo item',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (editController.text.isNotEmpty) {
              context.read<TodoBloc>().add(UpdateTodoEvent(
                    todo.id,
                    {'title': editController.text, 'id': id},
                  ));
              showSnackbar(context, 'Todo Updated');
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
