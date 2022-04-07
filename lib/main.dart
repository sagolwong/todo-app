import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.star),
        title: const Text("Todo"),
        actions: const <Widget>[Icon(Icons.star), Icon(Icons.star)],
      ),
      body: ListView(
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.star),
            title: Text(
              "Title",
              style: TextStyle(color: Colors.orange, fontSize: 20),
            ),
            subtitle: Text("subtitle"),
            trailing: Icon(Icons.edit),
          ),
          ElevatedButton(
            onPressed: () {
              print("Elevated");
            },
            child: const Text("Elevated Button"),
          ),
          TextButton(
            onPressed: () {
              print("Text");
              print(_textController.text);
            },
            child: const Icon(Icons.star),
          ),
          TextField(
            controller: _textController,
            onSubmitted: (value) {
              print(value);
            },
          )
        ],
      ),
    );
  }
}
