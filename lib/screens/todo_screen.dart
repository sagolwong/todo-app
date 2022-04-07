import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _textController = TextEditingController();
  List<String> todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
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
          onSubmitted: ((value) {
            todoList.add(value);

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
          title: Text(todoList[i]),
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
