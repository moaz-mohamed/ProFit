import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment
          .center, // Align however you like (i.e .centerRight, centerLeft)
      child: Text("Home screen"),
    );
  }
}
