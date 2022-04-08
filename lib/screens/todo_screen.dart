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
          onLongPress: () =>
              _showMoreActionsModalBottomSheet(context, todoItem),
        ),
      );
    }

    return todoItemList;
  }

  void _showMoreActionsModalBottomSheet(
      BuildContext context, TodoItem todo) async {
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.star, color: Colors.blue),
              title: Text(
                todo.text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(
                Icons.edit,
              ),
              title: const Text(
                "Edit",
              ),
              onTap: () => _editTodo(todo, (editText) {
                setState(() {
                  todo.text = editText;
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }),
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: const Text(
                "Remove",
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => _confirmRemoveDialog(todo),
            ),
          ],
        );
      },
    );
  }

  Future _confirmRemoveDialog(TodoItem todo) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("Do you want to remove this text?"),
          actions: [
            TextButton(
                child: const Text(
                  "cancel",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              child: const Text(
                "Remove",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                bool isDeleteSuccess =
                    await _firebaseProvider.deleteTodo(widget.title, todo);

                if (isDeleteSuccess) {
                  setState(() {
                    todoList.remove(todo);
                  });
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      },
    );
  }

  Future _editTodo(TodoItem todo, Function callback) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        String editText = todo.text;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  initialValue: editText,
                  onChanged: (value) {
                    editText = value;
                  },
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                          child: const Text(
                            "cancel",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      ElevatedButton(
                        child: const Text(
                          "Edit",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          bool isEditSuccess = await _firebaseProvider.editTodo(
                              widget.title,
                              TodoItem(id: todo.id, text: editText));

                          if (isEditSuccess) {
                            callback(editText);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
