import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';

class EditTodoDialog extends StatelessWidget {
  final TodoModel todo;
  final int? id;
  const EditTodoDialog({super.key, required this.todo, required this.id});

  @override
  Widget build(BuildContext context) {
    final TextEditingController editController = TextEditingController();
    editController.text = todo.title!;

    return AlertDialog(
      title: const Text('Edit Todo'),
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
              Navigator.of(context).pop();
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
