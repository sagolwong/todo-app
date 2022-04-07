import 'package:flutter/material.dart';
import 'package:todo/screens/page_2_screen.dart';
import 'package:todo/screens/todo_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      routes: <String, WidgetBuilder>{"/": (context) => const TodoScreen()},
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == "/page2") {
          PageParameter args = settings.arguments as PageParameter;
          return MaterialPageRoute(builder: (context) {
            return Page2Screen(
              title: args.title,
            );
          });
        }
      },
    );
  }
}
