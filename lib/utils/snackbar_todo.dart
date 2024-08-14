import 'package:flutter/material.dart';

class SnackbarTodo {
  final String message;

  SnackbarTodo({required this.message});

  SnackBar getSnackBar() {
    return SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.deepPurple.shade400,
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
