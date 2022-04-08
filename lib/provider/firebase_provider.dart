import 'package:firebase_database/firebase_database.dart';
import 'package:todo/models/todo.dart';

class FirebaseProvider {
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
