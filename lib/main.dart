import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/screens/category_screen.dart';
import 'package:todo/screens/todo_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      routes: <String, WidgetBuilder>{"/": (context) => const CategoryScreen()},
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == "/todo") {
          TodoParameters args = settings.arguments as TodoParameters;
          return MaterialPageRoute(builder: (context) {
            return TodoScreen(
              title: args.title,
            );
          });
        }
      },
    );
  }
}
