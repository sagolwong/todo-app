import 'package:flutter/material.dart';

class PageParameter {
  final String title;

  PageParameter({required this.title});
}

class Page2Screen extends StatelessWidget {
  final String title;
  const Page2Screen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text(title));
  }
}
