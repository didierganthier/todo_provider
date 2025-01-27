import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_provider/model/todo.dart';

class TodoListProvider extends ChangeNotifier {
  final List<Todo> _todoList = [];

  List<Todo> get todos => _todoList;

  TodoListProvider() {
    _loadTodos();
  }

  // addTodo
  void addTodo(String title) {
    _todoList.add(Todo(title: title));
    _saveTodos();
    notifyListeners();
  }

  // removeTodo
  void removeTodo(int index) {
    _todoList.removeAt(index);
    _saveTodos();
    notifyListeners();
  }

  // toggleTodo
  void toggleTodo(int index) {
    _todoList[index].toggleDone();
    _saveTodos();
    notifyListeners();
  }

  // loadTodos from sharedPreferences
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosString = prefs.getString('todos');
    if (todosString != null) {
      final _todosJson = jsonDecode(todosString) as List;
      _todoList.addAll(_todosJson
          .map((todo) => Todo(title: todo['title'], isDone: todo['isDone'])));
      notifyListeners();
    }
  }

  // saveTodos in sharedPreferences
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = _todoList
        .map((todo) => {'title': todo.title, 'isDone': todo.isDone})
        .toList();
    await prefs.setString('todos', jsonEncode(todosJson));
  }
}
