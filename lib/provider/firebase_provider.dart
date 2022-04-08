import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:todo/models/todo.dart';

class FirebaseProvider {
  Future<List<TodoItem>> getTodoList(String categaryName) async {
    try {
      final response = await FirebaseDatabase.instance.ref(categaryName).once();

      List<TodoItem> todoList = [];
      String json = jsonEncode(response.snapshot.value);
      Map<dynamic, dynamic> values = jsonDecode(json);

      values.forEach((key, value) {
        value['id'] = key;
        todoList.add(TodoItem.fromJson(value));
      });

      return todoList;
    } catch (error) {
      return [];
    }
  }

  Future<bool> createTodoItem(String categoryName, TodoItem todo) async {
    try {
      await FirebaseDatabase.instance.ref(categoryName).update({
        todo.id: {"text": todo.text}
      });

      return true;
    } catch (error) {
      return false;
    }
  }
}
