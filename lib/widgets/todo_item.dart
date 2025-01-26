import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/provider/todo_list_provider.dart';

class TodoItem extends StatelessWidget {
  final int index;

  const TodoItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<TodoListProvider>().todos[index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.pink[300],
        child: ListTile(
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (value) =>
                {context.read<TodoListProvider>().toggleTodo(index)},
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: IconButton(
            onPressed: () =>
                {context.read<TodoListProvider>().removeTodo(index)},
            icon: Icon(
              Icons.delete,
            ),
          ),
        ),
      ),
    );
  }
}
