import 'package:flutter/material.dart';
import 'package:todo_provider/model/todo.dart';

class TodoListProvider extends ChangeNotifier {
  final List<Todo> _todoList = [];

  List<Todo> get todos => _todoList;

  // addTodo
  void addTodo(String title) {
    _todoList.add(Todo(title: title));
    notifyListeners();
  }

  // removeTodo
  void removeTodo(int index) {
    _todoList.removeAt(index);
    notifyListeners();
  }

  // toggleTodo
  void toggleTodo(int index) {
    _todoList[index].toggleDone();
    notifyListeners();
  }
}
