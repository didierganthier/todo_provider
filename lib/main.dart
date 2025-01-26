import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/provider/todo_list_provider.dart';
import 'package:todo_provider/widgets/todo_item.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      child: const MyApp(),
      create: (context) => TodoListProvider(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: const Text(
          'Todo List',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple[100],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(
              16.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(hintText: 'Add a new todo'),
                  ),
                ),
                IconButton(
                  onPressed: _addTodo,
                  icon: Icon(
                    Icons.add,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Consumer<TodoListProvider>(
              builder: (context, todoListProvider, child) {
                return ListView.builder(
                  itemCount: todoListProvider.todos.length,
                  itemBuilder: (context, index) => TodoItem(index: index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addTodo() {
    final newTodo = _textController.text.trim();
    if (newTodo.isNotEmpty) {
      context.read<TodoListProvider>().addTodo(newTodo);
      _textController.clear();
    }
  }
}
