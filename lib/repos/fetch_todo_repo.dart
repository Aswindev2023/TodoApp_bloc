import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:todo_app/models/todo_model.dart';

class TodoRepo {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/todos';
  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        List<TodoModel> todo =
            jsonData.map((item) => TodoModel.fromJson(item)).toList();
        return todo.take(15).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching todos: $e');
    }
  }

  Future<bool> deleteTodo(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/$id'),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Failed to delete todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting todo: $e');
    }
  }

  Future<TodoModel> postTodos(TodoModel todo) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(todo.toJson()),
      );

      if (response.statusCode == 201) {
        return TodoModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to create todo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating todo: $e');
    }
  }

  Future<TodoModel> updateTodos(int id, Map<String, dynamic> updates) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          "userId": updates['userId'] ?? 1,
          "id": id,
          ...updates,
        }),
      );

      if (response.statusCode == 200) {
        return TodoModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to update todo');
      }
    } catch (e) {
      throw Exception('Error updating todo: $e');
    }
  }
}
