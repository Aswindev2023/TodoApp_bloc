import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/todo_bloc.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/repos/fetch_todo_repo.dart';

void main() {
  final TodoRepo todoRepo = TodoRepo();
  runApp(BlocProvider(
    create: (context) => TodoBloc(todoRepo: todoRepo)..add(LoadingTodoEvent()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
