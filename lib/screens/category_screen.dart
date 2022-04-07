import 'package:flutter/material.dart';
import 'package:todo/screens/todo_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category")),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          _categoryItem(context, "Personal", Icons.person),
          _categoryItem(context, "Work", Icons.work),
        ]),
      ),
    );
  }

  Widget _categoryItem(
      BuildContext context, String categoryName, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        onTap: (() => Navigator.of(context).pushNamed(
              "/todo",
              arguments: TodoParameters(title: categoryName),
            )),
        child: Container(
          margin: const EdgeInsets.all(5),
          child: Column(children: <Widget>[
            Icon(
              icon,
              size: 200,
            ),
            Divider(
              height: 1,
              color: Colors.grey[200],
            ),
            Text(
              categoryName,
              style: const TextStyle(fontSize: 20),
            )
          ]),
        ),
      ),
    );
  }
}
