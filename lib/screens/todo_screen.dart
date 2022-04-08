import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/provider/firebase_provider.dart';
import 'package:uuid/uuid.dart';

class TodoParameters {
  final String title;

  TodoParameters({required this.title});
}

class TodoScreen extends StatefulWidget {
  final String title;
  const TodoScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _textController = TextEditingController();
  final _firebaseProvider = FirebaseProvider();
  List<TodoItem> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title + " - Todo List"),
      ),
      body: FutureBuilder(
        future: _firebaseProvider.getTodoList(widget.title),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: _itemList(context, snapshot.data as List<TodoItem>));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  List<Widget> _itemList(BuildContext context, List<TodoItem> _todoList) {
    List<Widget> todoItemList = [];
    todoList = _todoList;

    todoItemList.add(
      Container(
        margin: const EdgeInsets.all(10),
        child: TextField(
          controller: _textController,
          onSubmitted: ((value) async {
            TodoItem todo = TodoItem(id: const Uuid().v4(), text: value);
            bool isCreatedSuccess =
                await _firebaseProvider.createTodoItem(widget.title, todo);

            if (isCreatedSuccess) {
              todoList.add(todo);
            }

            setState(() {
              _textController.clear();
            });
          }),
        ),
      ),
    );

    for (var todoItem in todoList) {
      todoItemList.add(
        ListTile(
          leading: const Icon(Icons.star, color: Colors.blue),
          title: Text(todoItem.text),
          subtitle: Text(widget.title),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                todoList.remove(todoItem);
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ),
      );
    }

    return todoItemList;
  }
}
