import 'package:flutter/material.dart';

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
  List<String> todoList = [];

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
