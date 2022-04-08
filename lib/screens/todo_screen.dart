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
      body: ListView(children: _itemList()),
    );
  }

  List<Widget> _itemList() {
    List<Widget> todoItemList = [];

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

    for (var i = 0; i < todoList.length; i++) {
      todoItemList.add(
        ListTile(
          leading: const Icon(Icons.star, color: Colors.blue),
          title: Text(todoList[i].text),
          subtitle: Text(widget.title),
          trailing: IconButton(
            onPressed: () {
              setState(() {
                todoList.removeAt(i);
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
